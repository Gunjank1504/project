report 60002 Purchase_Header_Inv
{
    ApplicationArea = All;
    Caption = 'Purchase_Header_Inv';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'RDL/comm_purchase_header_inv.rdl';
    dataset
    {
        dataitem(PurchaseHeader; "Purchase Header")
        {
            column(comp; comp.Name)
            {

            }
            column(comppic; comp.Picture)
            {

            }
            column(compadd; comp.Address)
            {

            }
            column(compadd2; comp."Address 2")
            {

            }
            column(compcity; comp.City)
            {

            }
            column(compgst; comp."GST Registration No.")
            {

            }
            column(Buy_from_Vendor_Name; "Buy-from Vendor Name")
            {

            }
            column(Buy_from_Address; "Buy-from Address")
            {

            }
            column(Buy_from_Address_2; "Buy-from Address 2")
            {

            }
            column(Buy_from_City; "Buy-from City")
            {

            }
            column(Buy_from_Country_Region_Code; "Buy-from Country/Region Code")
            {

            }
            column(Vendor_Invoice_No_; "Vendor Invoice No.")
            {

            }
           column(vgst;vgst)
           {
            
           }
            
            column(Vendor_Order_No_; "Vendor Order No.")
            {
            }
            column(Order_Date; "Order Date")
            {

            }
            column(Posting_Date; "Posting Date")
            {

            }
            column(E_Way_Bill_No_; "E-Way Bill No.")
            {

            }
            column(Ship_to_Name; "Ship-to Name")
            {

            }
            column(Ship_to_Address; "Ship-to Address")
            {

            }
            column(Ship_to_Country_Region_Code; "Ship-to Country/Region Code")
            {

            }
            
            column(Transport_Method; "Transport Method")
            {

            }
            column(Payment_Terms_Code; "Payment Terms Code")
            {

            }
            dataitem("Purchase Line"; "Purchase Line")
            {
                column(SerialNumber; SerialNumber)
                {

                }
                column(Description; Description)
                {

                }
                column(Quantity; Quantity)
                {

                }
                column(Unit_Price__LCY_; "Unit Price (LCY)")
                {

                }
                column(Amount; Amount)
                {

                }
                trigger OnAfterGetRecord()
                begin
                    Amount := Quantity * "Unit Price (LCY)";
                    SerialNumber += 1;
                end;
            }
            trigger OnAfterGetRecord()
            begin
               vendor.Reset();
               vendor.SetRange("No.",PurchaseHeader."Vendor Invoice No.");
               if vendor.FindFirst() then begin
                vgst:=vendor."GST Registration No.";
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
    var
        myInt: Integer;
    begin
        
        comp.Get();
        comp.CalcFields(Picture);
        SerialNumber := 0;
    end;

    var
        comp: Record "Company Information";
        SerialNumber: Integer;
        Amoumt: Decimal;
        vendor:Record Vendor;
        vgst:Code[20];
      
}
