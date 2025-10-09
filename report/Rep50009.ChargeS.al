namespace GeneratedProject.GeneratedProject;
using Microsoft.Foundation.Company;
using Microsoft.Inventory.Ledger;
using Microsoft.Inventory.Item;
using Microsoft.Purchases.History;

report 60987 Charge_S
{
    ApplicationArea = All;
    Caption = 'Charge_S';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'RDL/Rep60987-Charges.rdl';
    dataset
    {

        dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
        {
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                ILE.Reset();
                PIH.Reset();
                PRH.Reset();
                PIH.SetRange("Order No.", PRH."Order No.");
                PRH.SetRange("No.", ILE."Document No.");
                if ILE.FindFirst() then begin
                    charge_amt := ILE."Cost Amount (Actual)";
                end;
            end;
        }
        dataitem(PurchInvLine; "Purch. Inv. Line")
        {
            RequestFilterFields = "Buy-from Vendor No.", "Document No.", "Item Category Code", "Posting Date";
            DataItemTableView = where(Type = filter('ITEM'));

            column(compname; comp.Name) { }
            column(comppic; comp.Picture) { }
            column(compadd; comp.Address) { }
            column(compadd2; comp."Address 2") { }
            column(Document_No_; "Document No.")
            {

            }
            column(Line_Amount; "Line Amount")
            {
            }
            column(No; "No.")
            {
            }
            column(Description; Description)
            {
            }
            column(QuantityBase; "Quantity (Base)")
            {
            }
            column(BuyfromVendorName; "Buy-from Vendor Name")
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
            column(BuyfromVendorNo; "Buy-from Vendor No.")
            {
            }
            column(charge_amt; charge_amt) { }
            column(charge_unit_price; charge_amt / "Quantity (Base)") { }
            column(unit_price; unit_price) { }
            column(charge_amtsum; charge_amtsum) { }

            //     Clear(charge_amt);
            //     ILE.SetRange("Document No.", PurchInvLine."Receipt No.");
            //     ILE.SetRange("Item No.",PurchInvLine."No.");
            //   //  ILE.SetRange("Document Line No.",PurchInvLine."Line No.");
            //     if ILE.FindFirst() then begin
            //         ILE.CalcFields("Cost Amount (Actual)");
            //         charge_amt := ILE."Cost Amount (Actual)";
            //     end;


            // trigger OnPreDataItem()
            // var
            //     myInt: Integer;
            // begin
            //     //PurchInvLine.SetRange("No.", ITEMNO);


            // end;

            // trigger OnAfterGetRecord()
            // var
            //     myInt: Integer;

            // begin
            //     // Clear(charge_amt);
            //     // Clear(Charge_rate);
            //     // Clear(charge_unit_price);
            //     // Clear(unit_price);
            //     // PIL.Reset();
            //     // PIL.SetRange("Document No.", ILE."Document No.");
            //     // if Documentno <> '' then
            //     //     PIL.SetRange("Document No.", Documentno);

            //     // if PIL.FindFirst() then begin
            //     ILE.Reset();
            //     ILE.SetRange("Document No.", PurchInvLine."No.");
            //     // ILE.SetRange("Item No.", PurchInvLine."No.");
            //     if ILE.FindFirst() then begin
            //         // ILE.CalcFields("Cost Amount (Actual)");
            //         charge_amt := ILE."Cost Amount (Actual)";
            //     end;
            //     // charge_unit_price := charge_amt / "Quantity (Base)";
            //     // unit_price := "Line Amount" / "Quantity (Base)";
            //     // charge_amtsum += charge_amt;
            // end;






            // if "Quantity (Base)" <> 0 then begin


            // end else begin
            //     charge_unit_price := 0;
            //     unit_price := 0;
            // end;
            //end;
            // end;


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
                    field(Document_No; Documentno)
                    {
                        ApplicationArea = All;
                        Caption = 'Document_No.';
                        TableRelation = "Purch. Inv. Line"."Document No.";
                    }
                    // field(Item_No; ITEMNO)
                    // {
                    //     ApplicationArea = All;
                    //     Caption = 'Item_No.';
                    //     TableRelation = Item;
                    //     // TableRelation = "Purch. Inv. Line"."No.";
                    // }
                    // field(Vendor_No; PurchInvLine."Buy-from Vendor No.")
                    // {
                    //     ApplicationArea = All;
                    //     Caption = 'Vendor_No.';
                    //     // TableRelation = "Purch. Inv. Line"."No.";
                    // }
                    // field(Document_No; PurchInvLine."Document No.")
                    // {
                    //     ApplicationArea = All;
                    //     Caption = 'Document_No.';
                    //     // TableRelation = "Purch. Inv. Line"."No.";
                    // }
                    // field(documentdate; documentdate)
                    // {
                    //     ApplicationArea = All;
                    //     Caption = 'Document_Date';
                    //     // TableRelation = "Purch. Inv. Line"."No.";
                    // }
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
    var
        myInt: Integer;
    begin
        comp.Get();
        comp.CalcFields(Picture);

    end;

    var
        PIH: Record "Purch. Inv. Header";
        PRH: Record "Purch. Rcpt. Header";
        comp: Record "Company Information";
        ILE: Record "Item Ledger Entry";
        PIL: Record "Purch. Inv. Line";
        charge_amt: Decimal;
        ITEMNO: Code[20];
        itemrec: Record Item;
        Documentno: Code[20];
        charge_unit_price: Decimal;
        Charge_rate: Decimal;
        unit_price: Decimal;
        documentdate: DateFormula;
        purchinvheader: Record "Purch. Inv. Header";
        charge_amtsum: Decimal;
}
