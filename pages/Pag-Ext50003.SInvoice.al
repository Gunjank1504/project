pageextension 50103 SInvoice extends "Sales Order"
{
    layout{
        addafter(General)
        {
           field(consignee_address;Rec.consignee_address)
            {
                ApplicationArea = All;
            }
            field("location"; Rec."location")
            {
                ApplicationArea = All;
                Editable = rec.consignee_address = rec.consignee_address::consignee=false;
            }
        }
    }
}
