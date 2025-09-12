report 50023 PartyWise_report
{
    ApplicationArea = All;
    Caption = 'PartyWise_report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'partywise.rdl';
    dataset
    {
         dataitem(ItemLedgerEntry; "Item Ledger Entry")
            {
                column(PostingDate; "Posting Date")
                {
                }
                column(ItemDescription; "Item Description")
                {
                }
            }
        dataitem("Sales Shipment Header"; "Sales Shipment Header")
        {
            column(Ship_to_Name; "Ship-to Name")
            {

            }
            column(Ship_to_City; "Ship-to City")
            {

            }
            column(custstate; custstate)
            {

            }
            column(custcity; custcity)
            {

            }
            column(Broker_Name; "Broker Name")
            {

            }
           dataitem("Sales Shipment Line";"Sales Shipment Line")
        {
            DataItemLink = "Document No." = FIELD("No.");
            column(Quantity;Quantity)
            {
                
            }
            column(Unit_Price;"Unit Price")
            {
                
            }
            column(Item_Charge_Base_Amount;"Item Charge Base Amount")
            {
                
            }
            column(SWA;SWA)
            {
                
            }
            column(No__of_Bag;"No. of Bag")
            {
                
            }
        trigger OnAfterGetRecord()
        var
            myInt: Integer;
        begin
            SWA:= Quantity / 10;
            
        end;
        }

            trigger OnAfterGetRecord()
            begin
                cust.Reset();
                "Sales Shipment Header".Reset();
                cust.SetRange("No.", "Sales Shipment Header"."Sell-to Customer No.");
                if cust.FindFirst() then begin
                    custstate := cust."State Code";
                    custcity := cust.City;
                end;

                
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    var
        // st: Record State;
        cust: Record Customer;
        custstate: Text[100];
        SWA: Decimal;
        custcity: Text[100];
        SSL: Record "Sales Shipment Line";
}
