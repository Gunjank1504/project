report 50022 "Asha&sonsSalesinv"
{
    ApplicationArea = All;
    Caption = 'Asha&sonsSalesinv';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'RDL/AshaSaleinv.rdl';
    dataset
    {
        dataitem(SalesInvoiceHeader; "Sales Invoice Header")
        {
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
            column(comp_pc;comp."Post Code")
            {
                
            }
            column(compsc;comp."State Code")
            {
                
            }
            column(comp_gst;comp."GST Registration No.")
            {
                
            }
            column(comp_pan;comp."P.A.N. No.")
            {
                
            }
            column(comp_shipadd;comp."Ship-to Address")
            {
                
            }
            column(comp_shipadd2;comp."Ship-to Address 2")
            {
                
            }
            column(comp_shipcity;comp."Ship-to City")
            {
                
            }
            column(comp_shippc;comp."Ship-to Post Code")
            {
                
            }
            column(ASNNo; "ASN No.")
            {
            }
            column(Order_No_;"Order No.")
            {
                
            }
            column(Order_Date;"Order Date")
            {
                
            }
            column(BilltoName; "Bill-to Name")
            {
            }
            column(BilltoAddress; "Bill-to Address")
            {
            }
            column(BilltoAddress2; "Bill-to Address 2")
            {
            }
            column(BilltoCity; "Bill-to City")
            {
            }
            column(BilltoCountryRegionCode; "Bill-to Country/Region Code")
            {
            }
            column(BilltoPostCode; "Bill-to Post Code")
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
            column(ShiptoName; "Ship-to Name")
            {
            }
            column(ShiptoPhoneNo; "Ship-to Phone No.")
            {
            }
            column(ShiptoPostCode; "Ship-to Post Code")
            {
            }
            column(ShippingAgentCode; "Shipping Agent Code")
            {
            }
            column(ShiptoCountryRegionCode; "Ship-to Country/Region Code")
            {
            }
            column(ShiptoGSTRegNo; "Ship-to GST Reg. No.")
            {
            }
            column(No; "No.")
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
            column(EWayBillNo; "E-Way Bill No.")
            {
            }
            column(AcknowledgementDate; "Acknowledgement Date")
            {
            }
            column(AcknowledgementNo; "Acknowledgement No.")
            {
            }
            column(DispatchNo; "Dispatch No.")
            {
            }
            column(TransportMethod; "Transport Method")
            {
            }
            column(VehicleNo; "Vehicle No.")
            {
            }
            column(SOcreatedby; "SO created by")
            {
            }
            column(PaymentTermsCode; "Payment Terms Code")
            {
            }
            column(DueDate; "Due Date")
            {
            }
            column(DriverNo; "Driver No.")
            {
            }
            dataitem("Sales Invoice Line";"Sales Invoice Line")
            {
                column(SrNo;SrNo)
                {
                    
                }
                column(Description;Description)
                {
                    
                }
                column(HSN_SAC_Code;"HSN/SAC Code")
                {
                    
                }
                column(Unit_Volume;"Unit Volume")
                {
                    
                }
                column(Quantity;Quantity)
                {
                    
                }
                column(Unit_Price;"Unit Price")
                {
                    
                }
                column(Line_Discount__;"Line Discount %")
                {
                    
                }
                column(IGSTAmt;IGSTAmt)
                {
                    
                }
                column(IGSTRate;IGSTRate)
                {
                    
                }
                column(CGSTAmt;CGSTAmt)
                {
                    
                }
                column(CGSTRate;CGSTRate)
                {
                    
                }
                column(SGSTAmt;SGSTAmt)
                {
                    
                }
                column(SGSTRate;SGSTRate)
                {
                    
                }
                trigger OnAfterGetRecord()
                begin
                    SrNo +=1 ;
                    Amount:= "Unit Price" * Quantity;


                     clear(GSTrate);
                    clear(CGSTAmt);
                    clear(CGSTRate);
                    clear(SGSTAmt);
                    Clear(SGSTRate);
                    clear(IGSTAmt);
                    Clear(IGSTRate);
                    "Sales Invoice Line".Reset();
                     "Sales Invoice Line".SetRange("Document No.", "No.");
                    if  "Sales Invoice Line".FindFirst() then begin
                        repeat
                            taxinformation.Reset();
                            taxinformation.SetFilter("Tax Record ID", '%1',  "Sales Invoice Line".RecordId);
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
                        until  "Sales Invoice Line".Next() = 0;
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
    comp:Record "Company Information";
    SrNo:Integer;
    Amount:Decimal;
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
