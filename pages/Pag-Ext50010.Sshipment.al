pageextension 50340 Sshipment1 extends "Posted Sales Shipment"
{
     actions
    {
        addafter("&Shipment")
        {
            action("Delivery challan3")
            {
                ApplicationArea = All;
                PromotedCategory = Process;
                Promoted = true;
                PromotedOnly = true;
                RunObject = report "Delivery challan2";
                
                trigger OnAction()
                var
                   so: Record "Sales Shipment Header";
                   so1:Report "Delivery challan2";
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
