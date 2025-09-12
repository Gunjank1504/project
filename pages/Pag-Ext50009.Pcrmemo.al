pageextension 53009 Pcr_memo extends "Posted Purchase Credit Memo"
{
    actions
    {
        addafter("&Print")
        {
            action("demo_report")
            {
                ApplicationArea = All;
                PromotedCategory = Process;
                Promoted = true;
                PromotedOnly = true;
                RunObject = report "demo_report";
                
                trigger OnAction()
                var
                   so: Record "Purch. Cr. Memo Hdr.";
                   so1:Report demo_report;
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
