namespace GeneratedProject.GeneratedProject;

using Microsoft.Sales.Document;
using Microsoft.Foundation.Company;
using Microsoft.Inventory.Ledger;

report 50309 item_reclassiffication_report
{
    ApplicationArea = All;
    Caption = 'item_reclassiffication_report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'RDL/50009_itemreclass.rdl';
    dataset
    {
        dataitem(SalesHeader; "Sales Header")
        {
            column(comp_pic; comp.Picture)
            {

            }
            column(comp_name; comp.Name)
            {

            }
            column(comp_add; comp.Address)
            {

            }
            column(comp_add2; comp."Address 2")
            {

            }
            column(compcity; comp.City)
            {

            }
            column(compstate; comp."State Code")
            {

            }
            column(comppostcode; comp."Post Code")
            {

            }
            column(compgst; comp."GST Registration No.")
            {

            }
            column(Posting_Date;"Posting Date")
            {
                
            }
            column(Payment_Terms_Code;"Payment Terms Code")
            {
                
            }
            column(ShiptoName; "Ship-to Name")
            {
            }
            column(ShiptoAddress; "Ship-to Address")
            {
            }
            column(ShiptoAddress2; "Ship-to Address 2")
            {
            }
            column(ShiptoCity; "Ship-to City")
            {
            }
            column(ShiptoGSTRegNo; "Ship-to GST Reg. No.")
            {
            }
            column(ShiptoPostCode; "Ship-to Post Code")
            {
            }
            column(ShiptoCountryRegionCode; "Ship-to Country/Region Code")
            {
            }
            column(BilltoName; "Bill-to Name")
            {
            }
            column(BilltoAddress; "Bill-to Address")
            {
            }
            column(BilltoAddress2; "Bill-to Address 2")
            {
            }
            column(BilltoCity; "Bill-to City")
            {
            }
            column(BilltoPostCode; "Bill-to Post Code")
            {
            }
            column(BilltoCountryRegionCode; "Bill-to Country/Region Code")
            {
            }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(amt; amt)
                {

                }
                column(Unit_Price; "Unit Price")
                {

                }
                column(Ino; Ino)
                {

                }
                column(Ides; Ides)
                {

                }
                column(Iqty; Iqty)
                {

                }
                trigger OnAfterGetRecord()
                begin
                    amt := iqty * "Unit Price";
                end;
            }
            trigger OnAfterGetRecord()
            begin
                ILE.Reset();
                ILE.SetRange("Document No.", SalesHeader."No.");
                if ILE.FindFirst() then begin
                    Ino := ILE."Item No.";
                    Ides := ILE."Item Description";
                    Iqty := ILE.Quantity;

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
    trigger OnInitReport()
    begin
        comp.Get();
        comp.CalcFields(Picture);
    end;

    var
        ILE: Record "Item Ledger Entry";
        Ino: Code[20];
        Ides: Text;
        Iqty: Decimal;
        amt: Decimal;
        comp: Record "Company Information";
}
