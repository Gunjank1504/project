pageextension 50702 PostScrmemo extends "Posted Sales Credit Memo"
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
