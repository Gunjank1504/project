namespace GeneratedProject.GeneratedProject;

using Microsoft.Inventory.Ledger;
using Microsoft.Warehouse.Ledger;
using Microsoft.Foundation.Company;

report 50049 Average_report
{
    ApplicationArea = All;
    Caption = 'Average_report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'RDL/average.rdl';
    dataset
    {
        // dataitem("Warehouse Entry";"Warehouse Entry")
        // {

        //    RequestFilterFields = "Bin Code";
        // }
        dataitem(ItemLedgerEntry; "Item Ledger Entry")
        {
            RequestFilterFields = "Location Code", "Item No.";


            dataitem(WarehouseEntry; "Warehouse Entry")
            {
                DataItemLink = "Reference No." = FIELD("Document No."),
                       "Item No." = FIELD("Item No.");
                RequestFilterFields = "Bin Code";
            }

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
            column(comp_city; comp.City)
            {

            }
            column(comp_statec; comp."State Code")
            {

            }
            column(comp_postcode; comp."Post Code")
            {

            }
            column(comp_regionc; comp."Country/Region Code")
            {

            }
            column(comp_gst; comp."GST Registration No.")
            {

            }
            column(LocationCode; "Location Code")
            {
            }
            column(ItemNo; "Item No.")
            {
            }
            column(Item_Description; "Item Description")
            {

            }
            column(Quantity; Quantity)
            {

            }
            column(Cost_Amount__Actual_; "Cost Amount (Actual)")
            {

            }
            column(binv; binv)
            {

            }
            column(average; average)
            {

            }
            trigger OnAfterGetRecord()
            begin
                Clear(costamount);
                Clear(qty);
                costamount := 0;
                qty := 0;
                costamount := ItemLedgerEntry."Cost Amount (Actual)";
                qty := ItemLedgerEntry.Quantity;

                average := costamount / qty;
                Clear(ware);
                ware.Reset();
                ware.SetRange("Reference No.", ItemLedgerEntry."Document No.");
                if ware.FindFirst() then begin
                    binv := ware."Bin Code";
                end;
            end;

            trigger OnPreDataItem()
            begin
                SETRANGE("Posting Date", StartDate, EndDate);
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
                    field(startDate; startDate)
                    {
                        Caption = 'Start Date';
                        ApplicationArea = All;
                    }
                    field(EndDate; EndDate)
                    {
                        Caption = 'End Date';
                        ApplicationArea = All;
                    }
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
        comp: Record "Company Information";
        ware: Record "Warehouse Entry";
        binv: Code[20];
        StartDate: Date;
        EndDate: Date;
        BinWise: Code[50];
        average: Decimal;
        costamount: Decimal;
        qty: Decimal;
}
