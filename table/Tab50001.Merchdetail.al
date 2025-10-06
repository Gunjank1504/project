table 50021 Merch_detail
{
    Caption = 'Merch_detail';
    DataClassification = ToBeClassified;
    
    
    fields
    {
        field(1; IMEI; Code[100])
        {
        
            Editable = true;
            Caption = 'IMEI';
            

        }
        field(2; "Client ID"; Code[100])
        {
            Editable = true;
            Caption = 'Client ID';
        }
        field(3; "Device No"; Code[100])
        {
            Editable = true;
            Caption = 'Device No';
        }
        field(4; "Merchant ID"; Code[100])
        {
            Editable = true;
            Caption = 'Merchant ID';
        }
        field(5; "Store ID"; Code[100])
        {
            Editable = true;
            Caption = 'Store ID';
        }
        field(6; "Merchant Store POS Code"; Code[100])
        {
            Editable = true;
            Caption = 'Merchant Store POS Code';
        }
        field(7; "Security Token No"; Code[100])
        {
            Editable = true;
            Caption = 'Security Token No';
        }
        field(8; "Merchant Name"; Text[100])
        {
            Editable = true;
            Caption = 'Merchant Name';
        }
        field(9; "Store Name"; Text[100])
        {
            Editable = true;
            Caption = 'Store Name';
        }
    }
    keys
    {
        key(PK; IMEI)
        {
            Clustered = true;
        }
    }
}
