namespace GeneratedProject.GeneratedProject;

using Microsoft.Purchases.History;
using Microsoft.Inventory.Item;
using Microsoft.Manufacturing.ProductionBOM;
using Microsoft.Foundation.Company;

report 50009 PurchInvBOMdetail
{
    ApplicationArea = All;
    Caption = 'PurchInvBOMdetail';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'RDL/50009 PurchInvBOMdetail.rdl';
    dataset
    {
        dataitem(PurchInvHeader; "Purch. Inv. Header")
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
            column(comp_city; comp.City)
            {

            }
            column(comp_state; comp."State Code")
            {

            }
            column(comp_pc; comp."Post Code")
            {

            }
            column(comp_gst; comp."GST Registration No.")
            {

            }
            column(BuyfromAddress; "Buy-from Address")
            {
            }
            column(BuyfromAddress2; "Buy-from Address 2")
            {
            }
            column(BuyfromCity; "Buy-from City")
            {
            }
            column(BuyfromPostCode; "Buy-from Post Code")
            {
            }
            column(BuyfromVendorName; "Buy-from Vendor Name")
            {
            }
            column(BuyfromVendorNo; "Buy-from Vendor No.")
            {
            }
            column(BuyfromCountryRegionCode; "Buy-from Country/Region Code")
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
            column(ShiptoCountryRegionCode; "Ship-to Country/Region Code")
            {
            }
            column(ShiptoName; "Ship-to Name")
            {
            }
            column(ShiptoPhoneNo; "Ship-to Phone No.")
            {
            }
            column(ShiptoPostCode; "Ship-to Post Code")
            {
            }
            // column(Ipic;Ipic.Picture)
            // {

            // }

            dataitem("Purch. Inv. Line"; "Purch. Inv. Line")
            {
                DataItemLink = "Document No." = field("No.");
                column(No_; "No.")
                {

                }
                column(Description; Description)
                {

                }
                column(Unit_Price__LCY_; "Unit Price (LCY)")
                {

                }
                column(Unit_of_Measure; "Unit of Measure")
                {

                }
                column(Quantity__Base_; "Quantity (Base)")
                {

                }
                column(amt; amt)
                {

                }
                column(BOMno; BOMno)
                {

                }
                column(BOMdes; BOMdes)
                {

                }
                column(BOMqty; BOMqty)
                {

                }
                column(BOMunit; BOMunit)
                {

                }
                column(itemdetail; itemdetail)
                {

                }
                column(MaterialUsed; MaterialUsed)
                {

                }
                trigger OnAfterGetRecord()
                begin
                    amt := "Quantity (Base)" * "Unit Price (LCY)";

                    // Get Item related to this purchase line
                    if ItemRec.Get("No.") then begin
                        // Get Production BOM from Item
                        if ItemRec."Production BOM No." <> '' then begin
                            BOML.Reset();
                            BOML.SetRange("Production BOM No.", ItemRec."Production BOM No.");
                            if BOML.FindFirst() then begin
                                // BOMno := BomH."No.";
                                // BOMdes := BomH.Description;

                                // Now get BOM Lines for this BOM
                                // BOML.Reset();
                                // BOML.SetRange("Production BOM No.", BomH."No.");
                                // if BOML.FindFirst() then begin
                                //     BOMno := BOML."No.";
                                //     BOMdes := BOML.Description;
                                //     BOMunit := BOML."Unit of Measure Code";
                                //     BOMqty := BOML."Quantity per";
                                //     // MaterialUsed := true;
                                // end;
                                // BOMdes := '';
                                // BOMunit := '';
                                // BOMqty := 0;
                                // BOMno :='';
                                // if BOML.FindFirst() then begin
                                    repeat
                                        BOMdes += BOML.Description;
                                        BOMunit += BOML."Unit of Measure Code";
                                        BOMqty += BOML."Quantity per";
                                         BOMno +=BOML."No.";
                                    until BOML.Next() = 0;
                                end;
                            end;
                        end;
                    end;
                // end;
            }

        }
    }
    requestpage
    {
        SaveValues = true;
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(itemdetail; itemdetail)
                    {
                        ApplicationArea = all;
                        Caption = 'Item detail';
                    }
                    field(MaterialUsed; MaterialUsed)
                    {
                        ApplicationArea = All;
                        Caption = 'Material used';
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
        // Ipic.Get();
        // Ipic.CalcFields(Picture);
    end;

    var
        comp: Record "Company Information";
        amt: Decimal;
        BOML: Record "Production BOM Line";
        BomH: Record "Production BOM Header";
        BOMno: Code[1000];
        BOMdes: Text[500];
        BOMunit: code[100];
        BOMqty: Decimal;
        ItemRec: Record Item;
        MaterialUsed: Boolean;
        itemdetail: Boolean;
        
}
