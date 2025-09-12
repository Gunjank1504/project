pageextension 70048 Scr_memo extends "Posted Sales Credit Memo"
{
    actions
    {
        addafter("Customer")
        {
            action("debit_note")
            {
                ApplicationArea = All;
                PromotedCategory = Process;
                Promoted = true;
                PromotedOnly = true;
                RunObject = report "debit_note";
                
                trigger OnAction()
                var
                   so: Record "Sales Cr.Memo Header";
                   so1:Report "Debit_note";
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