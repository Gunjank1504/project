pageextension 50702 PostScrmemo extends "Posted Sales Credit Memo"
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
