pageextension 50821 salesOrder extends "Sales Order"
{
    layout
    {
        addafter("Posting Date")
        {
            field("Transporters Name";Rec."Transporters Name")
            {
                ApplicationArea = All;
                Editable = true;
            }
        }
    }
}
