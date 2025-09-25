report 60007 test
{
    ApplicationArea = All;
    Caption = 'test';
    UsageCategory = Administration;
    ProcessingOnly = true;
    dataset
    {
        
        
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(A;A)
                    {
                        ApplicationArea = all;
                    }
                    field(B;B)
                    {
                        ApplicationArea = all;
                    }
                    field(C;C)
                    {
                        ApplicationArea = all;
                    }
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
    var
    A: Integer;
    B:Integer;
    C:Option "Add","Minus","divide","multiply";

    trigger OnPreReport()
    begin
        // if C=C::Add then
        // Message(Format(A+B))
        // else if C=C::Minus then
        // Message(Format(A-B))
        // else if C=C::divide then
        // Message(Format(A/B))
        // else 
        // Message(Format(A*B));
        // Message('on pre report');
    end;
    trigger OnInitReport()
    var
        cust: Record Customer;
        SH: Record "Sales Header";
    begin
        // A:=10;
        // Message('on init Report');
        Clear(cust);
        cust.Get('40000');
        Message(cust.Name);

        Clear(SH);
        SH.Get(SH."Document Type"::Order,'101005');
        Message(SH."Sell-to Customer Name");
    end;

    trigger OnPostReport()
    var
        myInt: Integer;
    begin
        Message('On post Report');
    end;
}
