class Comp : StorageComp
{
    maide prusate Bool Init()
    {
        base.Init();
        this.Extern : share Extern;
        this.InternInfra : share InternInfra;
        return true;
    }

    field private Extern Extern { get { return data; } set { data : value; } }
    field private InternInfra InternInfra { get { return data; } set { data : value; } }

    maide prusate Entry Entry(var String path)
    {
        var Int pathU;
        pathU : this.InternInfra.StringCreate(path);

        var Extern extern;
        extern : this.Extern;

        var Int ka;
        ka : extern.StorageEntry_New();
        extern.StorageEntry_Init(ka);

        extern.StorageComp_Entry(this.Intern, ka, pathU);

        var Int nameK;
        var Int existK;
        var Int foldK;
        var Int sizeK;
        var Int createTimeK;
        var Int modifyTimeK;
        var Int ownerK;
        var Int groupK;
        var Int permitK;
        nameK : Extern.StorageEntry_NameGet(ka);
        existK : Extern.StorageEntry_ExistGet(ka);
        foldK : Extern.StorageEntry_FoldGet(ka);
        sizeK : Extern.StorageEntry_SizeGet(ka);
        createTimeK : Extern.StorageEntry_CreateTimeGet(ka);
        modifyTimeK : Extern.StorageEntry_ModifyTimeGet(ka);
        ownerK : Extern.StorageEntry_OwnerGet(ka);
        groupK : Extern.StorageEntry_GroupGet(ka);
        permitK : Extern.StorageEntry_PermitGet(ka);

        String name;
        name : null;
        bool exist;
        exist : false;
        bool fold;
        fold : false;
        long size;
        size : -1;
        long createTime;
        createTime : -1;
        long modifyTime;
        modifyTime : -1;
        long owner;
        owner : -1;
        long group;
        group : -1;
        Permit permit;
        permit : null;

        name : this.InternInfra.StringCreateIntern(nameK);

        exist : !(existK == 0);

        if (exist)
        {
            fold : !(foldK == 0);

            if (!fold)
            {
                size : (long)sizeK;
            }

            createTime : (long)createTimeK;

            if (!fold)
            {
                modifyTime : (long)modifyTimeK;
            }

            owner : (long)ownerK;

            group : (long)groupK;

            permit : this.Permit((long)permitK);
        }

        Entry a;
        a : new Entry();
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

        this.InternInfra.StringDelete(nameK);

        Extern.StorageEntry_Final(ka);
        Extern.StorageEntry_Delete(ka);

        this.InternInfra.StringDelete(pathU);

        return a;
    }
}