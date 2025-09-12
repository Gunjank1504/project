report 59108 "sales team member list"
{
    ApplicationArea = All;
    Caption = 'sales team member list';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(salesMember; "sales Member")
        {
            column(CustomerNo; "Customer No.")
            {
            }
            column(SalesMemberNo; "Sales Member No")
            {
            }
            column(Name; Name)
            {
            }
            column(Address; Address)
            {
            }
            column(Address2; Address2)
            {
            }
            column(DateofJoining; "Date of Joining")
            {
            }
            column(MobileNo; "Mobile No")
            {
            }
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
}
