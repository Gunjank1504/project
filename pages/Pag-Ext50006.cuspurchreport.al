pageextension 70206 cus_purch_report extends "Purchase Order"
{
     actions
    {
        addafter("P&osting")
        {
            action("porder")
            {
                ApplicationArea = All;
                PromotedCategory = Process;
                Promoted = true;
                PromotedOnly = true;
                RunObject = report "porder";
                
                trigger OnAction()
                var
                   so: Record "Purchase Header";
                   so1:Report "porder";
                begin
                    Clear(so1);
                    so.Reset();
                    so.SetRange("No.",Rec."No.");
                    so1.SetTableView(so);
                    so1.Run();
                end;
            }
            action("Purchase_Header_Inv")
            {
                 ApplicationArea = All;
                RunObject = report "Purchase_Header_Inv";
                Image = Report;

                trigger OnAction()
                var
                   so: Record "Purchase Header";
                   so1:Report "Purchase_Header_Inv";
                begin
                    Clear(so1);
                    so.Reset();
                    so.SetRange("No.",Rec."No.");
                    so1.SetTableView(so);
                    so1.Run();
                end;
            }
             action("K_PO_report")
            {
                 ApplicationArea = All;
                RunObject = report "K_PO_report";
                Image = Report;

                trigger OnAction()
                var
                   so: Record "Purchase Header";
                   so1:Report "K_PO_report";
                begin
                    Clear(so1);
                    so.Reset();
                    so.SetRange("No.",Rec."No.");
                    so1.SetTableView(so);
                    so1.Run();
                end;
            }
            action("VPO_report")
            {
                 ApplicationArea = All;
                RunObject = report "VPO_report";
                Image = Report;

                trigger OnAction()
                var
                   so: Record "Purchase Header";
                   so1:Report "VPO_report";
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
