pageextension 50411 shipment_ext extends "Posted Sales Shipment"
{
    layout{
        addafter("Posting Date")
        {
            field("Brokers Name";Rec."Brokers Name" )
            {
                ApplicationArea = All;
                Editable = true; 
            }
            
        }
    }
}
