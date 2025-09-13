report 60003 list_report
{
    ApplicationArea = All;
    Caption = 'list_report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'RDL/list_report.rdl';
    dataset
    {
        dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
        {
            column(Vendor_Invoice_No_; "Vendor Invoice No.")
            {

            }
            column(Vendor_GST_Reg__No_; "Vendor GST Reg. No.")
            {

            }
            column(Ship_to_Name; "Ship-to Name")
            {

            }
            column(Order_No_; "Order No.")
            {

            }

            dataitem(PurchInvLine; "Purch. Inv. Line")
            {

                column(PostingDate; "Posting Date")
                {
                }
                column(DocumentNo; "Document No.")
                {
                }
                column(BuyfromVendorNo; "Buy-from Vendor No.")
                {
                }
                column(VendorItemNo; "Vendor Item No.")
                {
                }
                column(No_; "No.")
                {

                }
                column(Quantity; Quantity)
                {
                }
                column(Unit_of_Measure_Code; "Unit of Measure Code")
                {
                }
                column(Unit_Price__LCY_;"Unit Price (LCY)")
                {
                }
                column(Line_Discount_Amount; "Line Discount Amount")
                {
                }
                column(Amount; Amount)
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
                column(GSTAmt; GSTAmt)
                {

                }
                trigger OnPreDataItem()
                begin
                    SETRANGE("Posting Date", StartDate, EndDate);
                end;

                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin
                    Amount := Quantity * "Unit Price (LCY)";

                    clear(GSTrate);
                    clear(CGSTAmt);
                    clear(CGSTRate);
                    clear(SGSTAmt);
                    Clear(SGSTRate);
                    clear(IGSTAmt);
                    Clear(IGSTRate);
                    PurchInvLine.Reset();
                    PurchInvLine.SetRange("Document No.", "No.");
                    if PurchInvLine.FindFirst() then begin
                        repeat
                            taxinformation.Reset();
                            taxinformation.SetFilter("Tax Record ID", '%1', PurchInvLine.RecordId);
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
                        until PurchInvLine.Next() = 0;
                    end;
                    GSTrate := Abs(SGSTRate + IGSTRate + CGSTRate);
                    GSTAmt := Abs(SGSTAmt + IGSTAmt + CGSTAmt);
                end;
            }
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
        startDate: Date;
        EndDate: Date;
        Amount: Integer;
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
