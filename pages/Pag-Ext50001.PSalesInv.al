pageextension 50121 PSalesInv extends "Posted Sales Invoice"
{
    layout
    {
        addafter("Transport Method")
        {
            field("Transporter Name";Rec."Transporter Name")
            {
                ApplicationArea = All ;
                Caption = 'Transporter Name';
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
