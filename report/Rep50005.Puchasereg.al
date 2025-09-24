namespace GeneratedProject.GeneratedProject;

using Microsoft.Finance.TaxBase;
using Microsoft.Finance.GeneralLedger.Ledger;
using Microsoft.Finance.TaxEngine.TaxTypeHandler;
using Microsoft.Purchases.History;

report 50005 Puchase_reg
{
    ApplicationArea = All;
    Caption = 'Puchase_reg';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'RDL/Purchase_reg.rdl';
    dataset
    {
        dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
        {
            column(No; "No.")
            {
            }
            column(OrderDate; "Order Date")
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
            column(VendorInvoiceNo; "Vendor Invoice No.")
            {
            }
            column(BuyfromVendorName; "Buy-from Vendor Name")
            {
            }
            column(VendorGSTRegNo; "Vendor GST Reg. No.")
            {
            }
            column(glname; glname)
            {

            }
            column(GST_Vendor_Type; "GST Vendor Type")
            {

            }
            column(statename; statename)
            {

            }
            dataitem("Purch. Inv. Line"; "Purch. Inv. Line")
            {
                column(HSN_SAC_Code; "HSN/SAC Code")
                {

                }
                column(Description; Description)
                {

                }
                column(Quantity; Quantity)
                {

                }
                column(Unit_of_Measure_Code; "Unit of Measure Code")
                {

                }
                column(GSTRate; GSTRate)
                {

                }
                column(CGSTAmt; CGSTAmt)
                {

                }
                column(SGSTAmt; SGSTAmt)
                {

                }
                column(IGSTAmt; IGSTAmt)
                {

                }
                column(Line_Amount; "Line Amount")
                {

                }
                column(Discount; Discount)
                {

                }
                column(Source_Document_Type; "Source Document Type")
                {

                }
                column(GST_Group_Type; "GST Group Type")
                {

                }
                column(TDS_Section_Code; "TDS Section Code")
                {

                }
                column(GST_Credit; "GST Credit")
                {

                }
                trigger OnAfterGetRecord()
                begin
                    clear(GSTrate);
                    clear(CGSTAmt);
                    clear(CGSTRate);
                    clear(SGSTAmt);
                    Clear(SGSTRate);
                    clear(IGSTAmt);
                    Clear(IGSTRate);
                    "Purch. Inv. Line".Reset();
                    "Purch. Inv. Line".SetRange("Document No.", "No.");
                    if "Purch. Inv. Line".FindFirst() then begin
                        repeat
                            taxinformation.Reset();
                            taxinformation.SetFilter("Tax Record ID", '%1', "Purch. Inv. Line".RecordId);
                            taxinformation.SetFilter("Value Type", '1%', taxinformation."Value Type"::COMPONENT);
                            taxinformation.SetRange("Visible on Interface", true);
                            if taxinformation.FindFirst() then begin
                                repeat
                                    ComponentAmt := TaxTypeObjHelper.GetComponentAmountFrmTransValue(taxinformation);
                                    if taxinformation.GetAttributeColumName() = 'CGST' then begin
                                        CGSTAmt += ComponentAmt;
                                        CGSTRate := taxinformation.percent;

                                    end;
                                    if taxinformation.GetAttributeColumName() = 'SGST' then begin
                                        SGSTAmt += ComponentAmt;
                                        SGSTRate := taxinformation.percent;
                                    end;
                                    if taxinformation.GetAttributeColumName() = 'IGST' then begin
                                        IGSTAmt += ComponentAmt;
                                        IGSTRate := taxinformation.percent;
                                    end;

                                until taxinformation.Next() = 0;
                            end;
                        until "Purch. Inv. Line".Next() = 0;
                    end;
                    GSTrate := Abs(SGSTRate + IGSTRate + CGSTRate);
                    GSTAmt := Abs(SGSTAmt + IGSTAmt + CGSTAmt);
                end;
            }
            trigger OnAfterGetRecord()
            begin
                GL.Reset();
                gl.SetRange("Document No.", "Purch. Inv. Header"."No.");
                if gl.FindFirst() then begin
                    glname := gl.Description;
                end;
                state1.Reset();
                state1.SetRange(Code, "Purch. Inv. Header"."Location State Code");
                if state1.FindFirst() then begin
                    statename := state1.Description;
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
        GL: Record "G/L Entry";
        state1: Record State;
        statename: Text[20];
        glname: Text[100];
        GSTAmt: Decimal;
        ItemGstrate: Decimal;
        CGSTAmt: Decimal;
        IGSTAmt: Decimal;
        SGSTAmt: Decimal;
        GSTRate: Decimal;
        IGSTRate: Decimal;
        SGSTRate: Decimal;
        CGSTRate: Decimal;
        taxinformation: Record "Tax Transaction Value";
        ComponentAmt: Decimal;
        TaxTypeObjHelper: Codeunit "Tax Type Object Helper";
}
