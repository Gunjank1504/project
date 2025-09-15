pageextension 50821 salesOrder extends "Sales Order"
{
    layout
    {
        addafter("Posting Date")
        {
            field("Transporter Name"; Rec."Transporter Name")
            {
                ApplicationArea = All;
                Editable = true;
            }
        }
    }
}
