pageextension 70015 sinv_report extends "Sales Invoice"
{
     actions
    {
        addafter("P&osting")
        {
            action("koprex1")
            {
                ApplicationArea = All;
                PromotedCategory = Process;
                Promoted = true;
                PromotedOnly = true;
                RunObject = report "koprex1";
                
                trigger OnAction()
                var
                   so: Record "Sales Invoice Header";
                   so1:Report "koprex1";
                begin
                    Clear(so1);
                    so.Reset();
                    so.SetRange("No.",Rec."No.");
                    so1.SetTableView(so);
                    so1.Run();
                end;
            }
            action("durian_report")
            {
                 ApplicationArea = All;
                RunObject = report "durian_report";
                Image = Report;

                trigger OnAction()
                var
                   so: Record "Sales Invoice Header";
                   so1:Report "durian_report";
                begin
                    Clear(so1);
                    so.Reset();
                    so.SetRange("No.",Rec."No.");
                    so1.SetTableView(so);
                    so1.Run();
                end;
            }
        }
    }

}
