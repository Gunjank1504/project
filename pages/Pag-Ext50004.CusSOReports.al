pageextension 70024 Cus_SOReports extends "Sales Order"
{
    actions
    {
        addafter("P&osting")
        {
            action("MOI_Report")
            {
                ApplicationArea = All;
                PromotedCategory = Process;
                Promoted = true;
                PromotedOnly = true;
                RunObject = report "MOI_Report";
                
                trigger OnAction()
                var
                   so: Record "Sales Header";
                   so1:Report "MOI_Report";
                begin
                    Clear(so1);
                    so.Reset();
                    so.SetRange("No.",Rec."No.");
                    so1.SetTableView(so);
                    so1.Run();
                end;
            }
            action("cronus_inven_report")
            {
                 ApplicationArea = All;
                RunObject = report "cronus_inven_report";
                Image = Report;

                trigger OnAction()
                var
                   so: Record "Sales Header";
                   so1:Report "cronus_inven_report";
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
