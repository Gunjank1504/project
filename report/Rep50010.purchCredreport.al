report 60010 "demo_report"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'demo_report';
    DefaultLayout = RDLC;
    RDLCLayout = 'RDL/demo_cred_report.rdl';
    dataset
    {
        dataitem("Purch. Cr. Memo Hdr."; "Purch. Cr. Memo Hdr.")
        {
            column(Document_Date; "Document Date")
            {

            }
            column(Vendor_Cr__Memo_No_; "Vendor Cr. Memo No.")
            {

            }
            column(Invoice_Type; "Invoice Type")
            {

            }
            column(Bill_of_Entry_No_; "Bill of Entry No.")
            {

            }
            column(Bill_of_Entry_Date; "Bill of Entry Date")
            {

            }
            column(Bill_to_Location_POS_; "Bill to-Location(POS)")
            {

            }
            column(Location_GST_Reg__No_; "Location GST Reg. No.")
            {

            }
            column(GST_Vendor_Type; "GST Vendor Type")
            {

            }
            column(Vendor_GST_Reg__No_; "Vendor GST Reg. No.")
            {

            }
            column(Location_State_Code; "Location State Code")
            {

            }

            dataitem(PurchCrMemoLine; "Purch. Cr. Memo Line")
            {
                column(SerialNo; SerialNo)
                {

                }
                column(DocumentNo; "Document No.")
                {
                }
                column(BuyfromVendorNo; "Buy-from Vendor No.")
                {
                }
                column(BuyfromVendorName; "Buy-from Vendor Name")
                {
                }
                column(PostingDate; "Posting Date")
                {
                }
                column(LineAmount; "Line Amount")
                {
                }
                column(LocationCode; "Location Code")
                {
                }
                column(Source_Document_Type; "Source Document Type")
                {

                }
                column(HSN_SAC_Code; "HSN/SAC Code")
                {

                }
                column(statename; statename)
                {

                }
                column(glno;glno)
                {
                    
                }
                column(totalvalue;totalvalue)
                {
                    
                }
                trigger OnAfterGetRecord()
                begin
                    SerialNo += 1;
                    totalvalue:= Quantity * "Unit Price (LCY)";
                    State1.Reset();
                    State1.SetRange(Code, "Purch. Cr. Memo Hdr."."Location State Code");
                    if State1.FindFirst() then begin
                        statename := State1.Description;
                    end;
                    GlEntry.Reset();
                    GlEntry.SetRange("Item No.",PurchCrMemoLine."No.");
                    if GlEntry.FindFirst() then begin
                        glno:=GlEntry."Document No.";
                    end;
                end;
            }
            trigger OnPreDataItem()
            begin
                PurchCrMemoLine.SetRange(PurchCrMemoLine."Posting Date",startdate,enddate);
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
                    field(startdate;startdate)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';
                    }
                    field(enddate;enddate)
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';
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
        SerialNo: Integer;
        State1: Record State;
        statename: Text[20];
        GlEntry:Record "Item Ledger Entry";
        glno:Code[20];
        startdate:Date;
        enddate:Date;
        totalvalue:Integer;
}
