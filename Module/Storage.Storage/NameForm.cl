class NameForm : TextForm
{
    maide prusate Bool Init()
    {
        base.Init();
        this.Extern : share Extern;
        this.TextInfra : share TextInfra;

        var Int k;
        k : this.Extern.Environ_System();

        var Bool b;
        b : 2 < k & k < 5;

        inf (b)
        {
            this.Form : this.TextInfra.AlphaSiteForm;
        }

        inf (~b)
        {
            this.Form : new TextForm;
            this.Form.Init();
        }

        return true;
    }

    field precate Extern Extern { get { return data; } set { data : value; } }
    field precate TextInfra TextInfra { get { return data; } set { data : value; } }
    field precate TextForm Form { get { return data; } set { data : value; } }

    maide prusate Int Execute(var Int n)
    {
        return this.Form.Execute(n);
    }
}