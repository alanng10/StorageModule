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

        var Int ka;
        ka : extern.StorageEntry_New();
        extern.StorageEntry_Init(ka);

        extern.StorageComp_Entry(0, ka, pathU);

        var Int nameK;
        var Int existK;
        var Int foldK;
        var Int sizeK;
        var Int createTimeK;
        var Int modifyTimeK;
        var Int ownerK;
        var Int groupK;
        var Int permitK;
        nameK : extern.StorageEntry_NameGet(ka);
        existK : extern.StorageEntry_ExistGet(ka);
        foldK : extern.StorageEntry_FoldGet(ka);
        sizeK : extern.StorageEntry_SizeGet(ka);
        createTimeK : extern.StorageEntry_CreateTimeGet(ka);
        modifyTimeK : extern.StorageEntry_ModifyTimeGet(ka);
        ownerK : extern.StorageEntry_OwnerGet(ka);
        groupK : extern.StorageEntry_GroupGet(ka);
        permitK : extern.StorageEntry_PermitGet(ka);

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

        extern.StorageEntry_Final(ka);
        extern.StorageEntry_Delete(ka);

        internInfra.StringDelete(pathU);

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
        ka : 1;
        ka : bit <(ka, index);

        var Bool a;
        a : ~((bit & (value, ka)) = 0);
        return a;
    }
}