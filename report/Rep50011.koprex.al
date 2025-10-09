report 50111 koprex1
{
    ApplicationArea = All;
    Caption = 'koprex';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'RDL/koprex.rdl';
    dataset
    {
        dataitem(SalesInvoiceHeader; "Sales Invoice Header")
        {
            column(comppic; comp.Picture)
            {

            }
            column(comp; comp.Name)
            {

            }
            column(compadd2; comp."Address 2")
            {

            }
            column(compgst; comp."GST Registration No.")
            {

            }
            column(Reference_Invoice_No_; "Reference Invoice No.")
            {

            }
            column(EWayBillNo; "E-Way Bill No.")
            {
            }
            column(Posting_Date; "Posting Date")
            {
            }
            column(Payment_Terms_Code; "Payment Terms Code")
            {
            }
            column(Acknowledgement_No_; "Acknowledgement No.")
            {
            }
            column(No_; "No.")
            {
            }
            column(Order_Date; "Order Date")
            {
            }
            column(Transport_Method; "Transport Method")
            {
            }
            column(Vehicle_No_; "Vehicle No.")
            {
            }


            column(Ship_to_Address; "Ship-to Address")
            {
            }
            column(Ship_to_Address_2; "Ship-to Address 2")
            {

            }
            column(Ship_to_City; "Ship-to City")
            {

            }
            column(Ship_to_Post_Code; "Ship-to Post Code")
            {

            }
            column(Ship_to_Name; "Ship-to Name")
            {

            }
            column(Customer_GST_Reg__No_; "Customer GST Reg. No.")
            {

            }

            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                column(No_1; "No.") { }
                column(Description; Description)
                {

                }
                column(SerialNumber; SerialNumber)
                {

                }
                column(HSN_SAC_Code; "HSN/SAC Code")
                {

                }
                column(Unit_of_Measure; "Unit of Measure")
                {

                }
                column(Quantity; Quantity)
                {

                }
                column(Unit_Price; "Unit Price")
                {

                }
                column(Total; Total)
                {

                }
                column(compadd; comp.Address)
                {

                }
                column(comp_bank_name; comp."Bank Name")
                {

                }
                column(comp_bank_account_no; comp."Bank Account No.")
                {

                }
                column(comp_bank_branch_no; comp."Bank Branch No.")
                {

                }
                column(comp_phone_no; comp."Phone No.")
                {

                }
                column(comp_email; comp."E-Mail")
                {

                }

                column(IGST; IGST)
                {

                }
                column(IGSTper; IGSTper)
                {

                }
                column(GST_per; GST_per)
                {

                }
                column(SGST; SGST)
                {

                }
                column(SGSTper; SGSTper)
                {

                }
                column(CGST; CGST)
                {

                }
                column(CGSTper; CGSTper)
                {

                }
                column(GstAmount; GstAmount)
                {

                }
                column(TotalAmount; TotalAmount)
                {

                }


                trigger OnAfterGetRecord()

                begin
                    Total := Quantity * "Unit Price";
                    SerialNumber += 1;

                    Clear(CGST);
                    Clear(IGST);
                    Clear(SGST);
                    Clear(CGSTper);
                    Clear(SGSTper);
                    Clear(IGSTper);
                    Clear(totalgst);
                    Clear(total2);
                    Clear(GstAmount);
                    DetailedGSTLedgerEntry.Reset();
                    DetailedGSTLedgerEntry.SetRange("Document No.", "Document No.");
                    DetailedGSTLedgerEntry.SetRange("Document Line No.", "Sales Invoice Line"."Line No.");
                    DetailedGSTLedgerEntry.SetRange("Transaction Type", DetailedGSTLedgerEntry."Transaction Type"::sales);
                    DetailedGSTLedgerEntry.SetRange("Entry Type", DetailedGSTLedgerEntry."Entry Type"::"Initial Entry");
                    DetailedGSTLedgerEntry.SetRange("HSN/SAC Code", "HSN/SAC Code");
                    DetailedGSTLedgerEntry.CalcSums(DetailedGSTLedgerEntry."GST Amount", "GST Base Amount");
                    GstAmount := DetailedGSTLedgerEntry."GST Base Amount" / 2;
                    if DetailedGSTLedgerEntry.FindFirst() then begin
                        if DetailedGSTLedgerEntry."GST Component Code" = 'IGST' then
                            GstAmount := GstAmount * 2;
                        repeat
                            if DetailedGSTLedgerEntry."GST Component Code" = 'CGST' then begin
                                CGST := Abs(DetailedGSTLedgerEntry."GST Amount");
                                CGSTper := Abs(DetailedGSTLedgerEntry."GST %");
                                ItemGSTRate := Abs(DetailedGSTLedgerEntry."GST %");
                            end;
                            if DetailedGSTLedgerEntry."GST Component Code" = 'SGST' then begin
                                SGST := Abs(DetailedGSTLedgerEntry."GST Amount");
                                SGSTper := Abs(DetailedGSTLedgerEntry."GST %");
                                ItemGSTRate := Abs(DetailedGSTLedgerEntry."GST %");
                            end;
                            if DetailedGSTLedgerEntry."GST Component Code" = 'IGST' then begin
                                IGST := Abs(DetailedGSTLedgerEntry."GST Amount");
                                IGSTper := Abs(DetailedGSTLedgerEntry."GST %");
                                ItemGSTRate := Abs(DetailedGSTLedgerEntry."GST %");
                            end;
                        until DetailedGSTLedgerEntry.Next = 0;
                    end;
                    GstAmount := (IGST + CGST + SGST);
                    GST_per := (IGSTper + CGSTper + SGSTper);
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
        SerialNumber: Integer;
        Total: Decimal;
        comp: Record "Company Information";
        vendor: Record Vendor;
        vgst: Code[20];
        vname: Text[100];
        vadd: Text[100];
        vadd2: Text[100];
        vstate: Text[100];
        vcity: Text[100];
        vpostc: Text[100];
        CGST: Decimal;
        IGST: Decimal;
        SGST: Decimal;
        GST_per: Decimal;
        CGSTper: Decimal;
        SGSTper: Decimal;
        IGSTper: Decimal;
        totalgst: Decimal;
        total2: Decimal;
        GstAmount: Decimal;
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        ItemGSTRate: Decimal;
        TotalAmount: Decimal;


}
