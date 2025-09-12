tableextension 50022 shipment_ext extends "Sales Shipment Header"
{
    fields
    {
        field(50010;"Brokers Name" ; Code[20])
        {
            Caption = 'Brokers Name';
            DataClassification = ToBeClassified;
            Editable=true;
        }
    }
}
