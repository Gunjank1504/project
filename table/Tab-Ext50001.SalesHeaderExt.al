namespace GeneratedProject.GeneratedProject;

using Microsoft.Sales.Document;
using Microsoft.Inventory.Location;

tableextension 50031 SalesHeader_Ext extends "Sales Header"
{
    fields
    {
        field(50000; "Location Name"; Text[100])
        {
            Caption = 'Location Name';
            DataClassification = ToBeClassified;
            TableRelation=Location;
        }
       
    }
}
