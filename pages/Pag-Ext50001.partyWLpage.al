pageextension 50052 partyWLinepage extends "Posted Sales Shpt. Subform"
{
    layout{
        addafter(Quantity)
        {
            field("no of Bagg";Rec."no. of Bagg")
            {
                ApplicationArea = All;
                Editable = true; 
            }
            
        }
    }
}
