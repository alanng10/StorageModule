class Infra : StorageInfra
{
    maide prusate Bool Init()
    {
        this.NameForm : this.CreateNameForm();
        return true;
    }

    maide precate NameForm CreateNameForm()
    {
        var NameForm a;
        a : new NameForm;
        a.Init();
        return a;
    }

    field prusate TextForm NameForm { get { return data; } set { data : value; } }
}