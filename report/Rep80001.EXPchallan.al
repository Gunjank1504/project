report 80001 EXP_challan
{
    ApplicationArea = All;
    Caption = 'EXP_challan';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'RDL/EXP_challan.rdl';
    dataset
    {
        dataitem(SalesShipmentHeader; "Sales Shipment Header")
        {
            column(fcity; fcity)
            {

            }
            column(toc; toc)
            {

            }
            column(comp_name; comp.Name)
            {

            }
            column(comp_add; comp.Address)
            {

            }
            column(LR_RR_No_; "LR/RR No.")
            {

            }
            column(LR_RR_Date; "LR/RR Date")
            {

            }
            column(comp_add2; comp."Address 2")
            {

            }
            column(comp_city; comp.City)
            {

            }
            column(comppc; comp."Post Code")
            {

            }
            column(compsc; comp."State Code")
            {

            }
            column(comp_mail; comp."E-Mail")
            {

            }
            column(comp_gst; comp."GST Registration No.")
            {

            }
            column(comp_pan; comp."P.A.N. No.")
            {

            }
            column(No_; "No.")
            {

            }
            column(VehicleNo; "Vehicle No.")
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
            column(TransportMethod; "Transport Method")
            {
            }
            // column(BilltoName; "Bill-to Name")
            // {
            // }
            // column(BilltoAddress; "Bill-to Address")
            // {
            // }
            // column(BilltoAddress2; "Bill-to Address 2")
            // {
            // }
            // column(BilltoCity; "Bill-to City")
            // {
            // }
            // column(BilltoCountryRegionCode; "Bill-to Country/Region Code")
            // {
            // }
            // column(BilltoPostCode; "Bill-to Post Code")
            // {
            // }
            // column(BilltoContactNo; "Bill-to Contact No.")
            // {
            // }
            // column(ShiptoName; "Ship-to Name")
            // {
            // }
            // column(ShiptoAddress; "Ship-to Address")
            // {
            // }
            // column(ShiptoAddress2; "Ship-to Address 2")
            // {
            // }
            // column(ShiptoCity; "Ship-to City")
            // {
            // }
            // column(ShiptoCountryRegionCode; "Ship-to Country/Region Code")
            // {
            // }
            // column(ShiptoPostCode; "Ship-to Post Code")
            // {
            // }
            // column(ShiptoPhoneNo; "Ship-to Phone No.")
            // {
            // }
            // column(ShiptoGSTRegNo; "Ship-to GST Reg. No.")
            // {
            // }
            column(fadd; fadd)
            {

            }
            column(fadd2; fadd2)
            {

            }
            column(fname; fname)
            {

            }
            column(tname;tname)
            {

            }
            column(toadd;toadd)
            {
                
            }
            column(tadd2;tadd2)
            {
                
            }
            dataitem("Sales Shipment Line"; "Sales Shipment Line")
            {
                column(SrNo; SrNo)
                {

                }
                column(Description; Description)
                {

                }
                column(HSN_SAC_Code; "HSN/SAC Code")
                {

                }
                column(Gross_Weight; "Gross Weight")
                {

                }
                column(Quantity; Quantity)
                {

                }
                column(Net_Weight; "Net Weight")
                {

                }
                column(Unit_Price; "Unit Price")
                {

                }
                column(Amount; Amount)
                {

                }
                trigger OnAfterGetRecord()
                begin
                    SrNo += 1;
                    Amount := Quantity * "Unit Price";
                end;
            }
            trigger OnAfterGetRecord()
            begin
                transshipm.Reset();
                transshipm.SetRange("Transfer-from Code", "SalesShipmentHeader"."Location Code");
                if transshipm.FindFirst() then begin
                    fcity := transshipm."Transfer-from City";
                    toc := transshipm."Transfer-to City";
                    fadd := transshipm."Transfer-from Address";
                    fadd2 := transshipm."Transfer-from Address 2";
                    fname := transshipm."Transfer-from Name";
                    // fgst:=transshipm.gst;
                    // femail:transshipm.transferfrome;
                    // fph:transshipm.transferfrom;
                    toadd := transshipm."Transfer-to Address";
                    tadd2 := transshipm."Transfer-to Address 2";
                    tname := transshipm."Transfer-to Name";
                    // tgst:=;
                    // temail:=transshipm.transferto;
                    // tph:=transshipm.transferto;
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
    end;

    var
        comp: Record "Company Information";
        SrNo: Integer;
        Amount: Decimal;
        lrno: Code[20];
        sales: Record "Sales Header";
        transshipm: Record "Transfer Shipment Header";
        fcity: Text[50];
        fadd: Text[50];
        fadd2: Text[50];
        fname: Text[50];
        fgst: Text[20];
        femail: Text[50];
        fph: Text[50];
        toc: Text[50];
        toadd: Text[50];
        tadd2: Text[50];
        tname: Text[50];
        tgst: Text[50];
        temail: Text[50];
        tph: Text[50];
}
