tableextension 50019 SaleInv extends "sales invoice header"
{
    fields
    {
        field(50002; "Transporters Name"; Text[100])
        {
            Caption = 'Transporters Name';
            DataClassification = ToBeClassified;
        }
        field(500010; "Dispatch No.";Text[20])
        {
            Caption = 'Dispatch No.';
            DataClassification = ToBeClassified;
        }
         field(500011; "Driver No.";Integer)
        {
            Caption = 'Driver No.';
            DataClassification = ToBeClassified;
        }
         field(500012; "ASN No.";Integer)
        {
            Caption = 'ASN No.';
            DataClassification = ToBeClassified;
        }
        field(500013; "SO created by";Text[100])
        {
            Caption = 'SO created by';
            DataClassification = ToBeClassified;
        }
    }
}
