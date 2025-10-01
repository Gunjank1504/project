namespace GeneratedProject.GeneratedProject;

using Microsoft.Inventory.Ledger;
using Microsoft.Foundation.Company;
using Microsoft.Warehouse.Structure;
using Microsoft.Warehouse.Ledger;

report 50069 Aver_report
{
    ApplicationArea = All;
    Caption = 'Aver_report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'RDL/50069_aver.rdl';
    dataset
    {
        dataitem(ItemLedgerEntry; "Item Ledger Entry")
        {
             RequestFilterFields = "Location Code", "Item No.";
            column(comp_pic;comp.Picture)
            {
                
            }
            column(comp_name;comp.Name)
            {
                
            }
            column(comp_add;comp.Address)
            {
                
            }
            column(comp_add2;comp."Address 2")
            {
                
            }
            column(comp_city;comp.City)
            {
                
            }
            column(comp_statec;comp."State Code")
            {
                
            }
            column(comp_postcode;comp."Post Code")
            {
                
            }
            column(comp_regionc;comp."Country/Region Code")
            {
                
            }
            column(comp_gst;comp."GST Registration No.")
            {
                
            }
            column(LocationCode; "Location Code")
            {
            }
            column(ItemNo; "Item No.")
            {
            }
            column(Item_Description;"Item Description")
            {
                
            }
            column(Quantity;Quantity)
            {
                
            }
            column(Cost_Amount__Actual_;"Cost Amount (Actual)")
            {
                
            }
            column(binv;binv)
            {
                
            }
            column(average;average)
            {
                
            }
            trigger OnAfterGetRecord()
            begin
                Clear(costamount);
                Clear(qty);
                costamount:=0;
                qty:=0;
                costamount:=ItemLedgerEntry."Cost Amount (Actual)";
                qty:=ItemLedgerEntry.Quantity;
            
                average:=costamount/qty;
                Clear(ware);
                ware.Reset();
                ware.SetRange("Reference No.",ItemLedgerEntry."Document No.");
                if ware.FindFirst() then begin
                   binv:=ware."Bin Code";
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
                group(filter)
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
                    field(BinWise;BinWise)
                    {
                        Caption = 'Bin Code';
                        ApplicationArea = All;
                        TableRelation = Bin.Code;
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
    comp:Record "Company Information";
    ware:Record "Warehouse Entry";
    binv:Code[20];
    StartDate:Date;
    EndDate:Date;
    BinWise:Code[50];
    average:Decimal;
    costamount:Decimal;
    qty:Decimal;
}
