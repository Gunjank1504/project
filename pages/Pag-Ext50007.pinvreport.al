pageextension 70207 pinvreport extends "Purchase Invoices"
{
    actions
    {
        addafter("P&osting")
        {
            action("list_report")
            {
                ApplicationArea = All;
                PromotedCategory = Process;
                Promoted = true;
                PromotedOnly = true;
                RunObject = report "porder";
                
                trigger OnAction()
                var
                   so: Record "Purch. Inv. Header";
                   so1:Report "list_report";
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
