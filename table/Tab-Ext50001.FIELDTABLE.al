tableextension 70001 FIELD_TABLE extends "Sales Header"
{
    
    fields
    {
        field(50001; "Who did job"; Text[100])
        {
            Caption = 'Who did job';
            DataClassification = ToBeClassified;
            TableRelation = "Salesperson/Purchaser";
        }
        field(50002; "when item was picked"; Date)
        {
            Caption = 'when item was picked';
            DataClassification = ToBeClassified;
        }
        field(50003; "where repaired"; Text[100])
        {
            Caption = 'where repaired';
            DataClassification = ToBeClassified;
            TableRelation = Location;
        }
        field(50004; "when invoiced"; Date)
        {
            Caption = 'when invoiced';
            DataClassification = ToBeClassified;
        }
        field(50005; "consignee_address"; Option)
        {
            OptionMembers = ,consignee,location;
            OptionCaption = ', consignee,location';
            Caption = 'consignee_address';
            DataClassification = ToBeClassified;
            
        }
        field(50006; location; Text[20])
        {
            Caption = 'location';
            DataClassification = ToBeClassified;
            TableRelation = Location.Code;
        }
         field(50007; consignee; Text[20])
        {
            Caption = 'consignee';
            DataClassification = ToBeClassified;
            TableRelation = Location.Code;
        }
field(50009; "location of repaired"; Text[100])
{
            Caption = 'location of repaired';
            DataClassification = ToBeClassified;
            TableRelation = Location.Code;
}


        // field(50008; "Transporter Name"; Text[100])
        // {
        //     Caption = 'Transporter Name';
        //     DataClassification = ToBeClassified;
        // }
    }
}
