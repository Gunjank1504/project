namespace GeneratedProject.GeneratedProject;

using Microsoft.Sales.Document;
using Microsoft.Inventory.Location;

pageextension 50032 Sales_Order_Extends extends "Sales Order"
{
    layout
    {
        addafter(General)
        {
            field("Location Name"; Rec."Location Name")
            {
                ApplicationArea = all;
                TableRelation = Location;

            }

        }
    }

}
