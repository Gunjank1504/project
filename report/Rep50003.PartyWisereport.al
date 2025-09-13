report 50023 PartyWise_report
{
    ApplicationArea = All;
    Caption = 'PartyWise_report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'RDL/partywise.rdl';
    dataset
    {
         // Top-level: Sales Shipment Header
        dataitem("Sales Shipment Header"; "Sales Shipment Header")
        {
            column("Ship_to_Name"; "Ship-to Name") { }
            column("Ship_to_City"; "Ship-to City") { }
            column("custstate"; custstate) { }
            column("custcity"; custcity) { }
            column("Broker_Name"; "Brokers Name") { }

            // Sales Shipment Line - nested under Header
            dataitem("Sales Shipment Line"; "Sales Shipment Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemLinkReference = "Sales Shipment Header";

                column(Quantity; Quantity) { }
                column("Unit_Price"; "Unit Price") { }
                column("Item_Charge_Base_Amount"; "Item Charge Base Amount") { }
                column(SWA; SWA) { }
                column("No__of_Bag"; "No. of Bagg") { }
                column("No"; "No.") { }

                // Item Ledger Entry - nested under Line to get Posting Date & Item Details
                dataitem("Item Ledger Entry"; "Item Ledger Entry")
                {
                    DataItemLink = 
                        "Document No." = FIELD("Document No."),
                        "Item No." = FIELD("No.");
                    DataItemLinkReference = "Sales Shipment Line";

                    DataItemTableView = 
                        SORTING("Item No.", "Document No.")
                        WHERE("Entry Type" = CONST(Sale));

                    column("PostingDate"; "Posting Date") { }
                    column("ItemDescription"; "Item Description") { }
                }

                trigger OnAfterGetRecord()
                begin
                    SWA := Quantity / 10;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                if cust.Get("Sell-to Customer No.") then begin
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
                    // Add filters here if needed
                }
            }
        }
        actions
        {
            area(Processing)
            {
                // Add actions here if needed
            }
        }
    }

    var
        cust: Record Customer;
        custstate: Text[100];
        custcity: Text[100];
        SWA: Decimal;
}
