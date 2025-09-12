pageextension 60021 field_page extends "Sales Order"
{
    layout{
        addafter(General){
            field("Who did job";Rec."Who did job")
            {
                ApplicationArea = All;
                Editable = true;

            }
            field("when item was picked";Rec."when item was picked")
            {
                ApplicationArea = All;
                Editable = true;

            }
            field("where repaired";Rec."where repaired")
            {
                ApplicationArea = All;
                Editable = true;

            }
            field("when invoiced";Rec."Posting Date")
            {
                ApplicationArea = All;
                Editable = true;

            }
        }
        addafter("LR/RR Date")
        {
            field("Dispatch No.";Rec."Dispatch No.")
            {
                ApplicationArea = All;
                Editable = true;
            }
          field("Driver No.";Rec."Driver No.")
          {
             ApplicationArea = All;
                Editable = true;
          }
          field("ASN No.";Rec."ASN No.")
          {
            ApplicationArea = All ;
            Editable = true ; 
          }
          field("SO created by";Rec."SO created by")
          {
            ApplicationArea = All;
            Editable = true ; 
          }
        }
    }
}
