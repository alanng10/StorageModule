class Permit : Any
{
    field prusate Bool OwnerRead { get { return data; } set { data : value; } }
    field prusate Bool OwnerWrite { get { return data; } set { data : value; } }
    field prusate Bool GroupRead { get { return data; } set { data : value; } }
    field prusate Bool GroupWrite { get { return data; } set { data : value; } }
    field prusate Bool OtherRead { get { return data; } set { data : value; } }
    field prusate Bool OtherWrite { get { return data; } set { data : value; } }
    field prusate Int Other { get { return data; } set { data : value; } }
}