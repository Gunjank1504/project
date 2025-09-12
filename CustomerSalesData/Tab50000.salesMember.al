table 50090 "sales Member"
{
    Caption = 'sales Member';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
        }
        field(2; "Sales Member No"; Code[20])
        {
            Caption = 'Sales Member No';
        }
        field(3; Name; Text[50])
        {
            Caption = 'Name';
        }
        field(4; "Mobile No"; Text[20])
        {
            Caption = 'Mobile No';
        }
        field(5; Address; Text[30])
        {
            Caption = 'Address';
        }
        field(6; "Date of Joining"; Date)
        {
            Caption = 'Date of Joining';
        }
        field(7; "Address2"; Text[30])
        {
            Caption = 'Address2';
        }
    }
    keys
    {
        key(PK; "Customer No.","Sales Member No")
        {
            Clustered = true;
        }
    }
}
