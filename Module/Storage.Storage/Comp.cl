class Comp : StorageComp
{
    maide prusate Bool Init()
    {
        base.Init();
        this.PrivateExtern : share Extern;
        this.PrivateInternInfra : share InternInfra;
        return true;
    }

    field private Extern PrivateExtern { get { return data; } set { data : value; } }
    field private InternInfra PrivateInternInfra { get { return data; } set { data : value; } }

    maide prusate Entry Entry(var String path)
    {
        var InternInfra internInfra;
        internInfra : this.PrivateInternInfra;

        var Int pathU;
        pathU : internInfra.StringCreate(path);

        var Extern extern;
        extern : this.PrivateExtern;

        var Int k;
        k : extern.StorageEntry_New();
        extern.StorageEntry_Init(k);

        extern.StorageComp_Entry(0, k, pathU);

        var Entry a;
        a : this.EntryFromIntern(k);

        extern.StorageEntry_Final(k);
        extern.StorageEntry_Delete(k);

        internInfra.StringDelete(pathU);

        return a;
    }

    maide prusate Array EntryList(var String path, var Bool fold, var Bool file)
    {
        var InternInfra internInfra;
        internInfra : this.PrivateInternInfra;

        var Int pathU;
        pathU : internInfra.StringCreate(path);

        var Int foldU;
        foldU : internInfra.Bool(fold);

        var Int fileU;
        fileU : internInfra.Bool(file);

        var Extern extern;
        extern : this.PrivateExtern;

        var Int k;
        k : extern.StorageComp_EntryList(0, pathU, foldU, fileU);

        internInfra.StringDelete(pathU);

        ulong countU;
        countU : extern.Array_CountGet(k);

        long count;
        count : (long)countU;

        Array array;
        array : this.ListInfra.ArrayCreate(count);

        long i;
        i : 0;
        while (i < count)
        {
            ulong indexU;
            indexU : (ulong)i;

            ulong u;
            u : extern.Array_ItemGet(k, indexU);

            Entry a;
            a : this.EntryFromIntern(u);

            array.SetAt(i, a);

            i : i + 1;
        }

        i : 0;
        while (i < count)
        {
            long indexA;
            indexA : count - 1 - i;

            ulong indexAU;
            indexAU : (ulong)indexA;

            ulong ua;
            ua : extern.Array_ItemGet(k, indexAU);

            extern.StorageEntry_Final(ua);
            extern.StorageEntry_Delete(ua);

            i : i + 1;
        }

        extern.Array_Final(k);
        extern.Array_Delete(k);

        return array;
    }

    maide private Entry EntryFromIntern(var Int k)
    {
        var InternInfra internInfra;
        internInfra : this.PrivateInternInfra;

        var Extern extern;
        extern : this.PrivateExtern;

        var Int nameK;
        var Int existK;
        var Int foldK;
        var Int sizeK;
        var Int createTimeK;
        var Int modifyTimeK;
        var Int ownerK;
        var Int groupK;
        var Int permitK;
        nameK : extern.StorageEntry_NameGet(k);
        existK : extern.StorageEntry_ExistGet(k);
        foldK : extern.StorageEntry_FoldGet(k);
        sizeK : extern.StorageEntry_SizeGet(k);
        createTimeK : extern.StorageEntry_CreateTimeGet(k);
        modifyTimeK : extern.StorageEntry_ModifyTimeGet(k);
        ownerK : extern.StorageEntry_OwnerGet(k);
        groupK : extern.StorageEntry_GroupGet(k);
        permitK : extern.StorageEntry_PermitGet(k);

        var String name;
        var Bool exist;
        var Bool fold;
        var Int size;
        var Int createTime;
        var Int modifyTime;
        var Int owner;
        var Int group;
        var Permit permit;

        name : internInfra.StringCreateIntern(nameK);

        exist : ~(existK = 0);

        inf (exist)
        {
            fold : ~(foldK = 0);

            inf (~fold)
            {
                size : sizeK;
            }

            createTime : createTimeK;

            inf (~fold)
            {
                modifyTime : modifyTimeK;
            }

            owner : ownerK;

            group : groupK;

            permit : this.Permit(permitK);
        }

        var Entry a;
        a : new Entry;
        a.Init();
        a.Name : name;
        a.Exist : exist;
        a.Fold : fold;
        a.Size : size;
        a.CreateTime : createTime;
        a.ModifyTime : modifyTime;
        a.Owner : owner;
        a.Group : group;
        a.Permit : permit;

        internInfra.StringDelete(nameK);

        return a;
    }

    maide private Permit Permit(var Int value)
    {
        var Permit a;
        a : new Permit;
        a.Init();

        a.OwnerRead : this.HasFlag(value, 0);
        a.OwnerWrite : this.HasFlag(value, 1);
        a.GroupRead : this.HasFlag(value, 2);
        a.GroupWrite : this.HasFlag(value, 3);
        a.OtherRead : this.HasFlag(value, 4);
        a.OtherWrite : this.HasFlag(value, 5);
        a.Other : null;
        return a;
    }

    maide private Bool HasFlag(var Int value, var Int index)
    {
        var Int ka;
        ka : bit <(1, index);

        var Bool a;
        a : ~((bit & (value, ka)) = 0);
        return a;
    }
}