namespace GeneratedProject.GeneratedProject;

using Microsoft.Purchases.History;
using Microsoft.Finance.TaxEngine.TaxTypeHandler;
using Microsoft.Finance.TaxBase;
using Microsoft.Purchases.Document;
using Microsoft.Foundation.Company;
using Microsoft.Sales.Customer;

report 50004 Calibration_ServiceRep
{
    ApplicationArea = All;
    Caption = 'Calibration_ServiceRep';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'RDL/50004 calibration_servicerepo.rdl';
    dataset
    {
        dataitem("Purchase Header";"Purchase Header")
        {
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
            column(comp_pc;comp."Post Code")
            {
                
            }
            column(comp_st;comp_st)
            {
                
            }
            column(comp_ph;comp."Phone No.")
            {
                
            }
            column(comp_mail;comp."E-Mail")
            {
                
            }
            column(comp_gst;comp."GST Registration No.")
            {
                
            }
            column(comp_region;comp."Country/Region Code")
            {
                
            }
            column(ShiptoAddress; "Ship-to Address")
            {
            }
            column(ShiptoAddress2; "Ship-to Address 2")
            {
            }
            column(ShiptoName; "Ship-to Name")
            {
            }
            column(ShiptoCity; "Ship-to City")
            {
            }
            column(ShiptoPostCode; "Ship-to Post Code")
            {
            }
            column(No; "No.")
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
            column(custgst;custgst)
            {
                
            }
            dataitem("Purchase Line";"Purchase Line")
            {
                DataItemLink= "Document No." = field("No.");
                column(SrNo;SrNo)
                {
                    
                }
                column(Description;Description)
                {
                    
                }
                column(Variant_Code;"Variant Code")
                {
                    
                }
                column(Quantity;Quantity)
                {
                    
                }
                column(Unit_Price__LCY_;"Unit Price (LCY)")
                {
                    
                }
                column(Amount;Amount)
                {
                    
                }
                column(CGSTRate;CGSTRate)
                {
                    
                }
                column(SGSTRate;SGSTRate)
                {
                    
                }
                column(CGSTAmt;CGSTAmt)
                {
                    
                }
                column(SGSTAmt;SGSTAmt)
                {
                    
                }
                trigger OnAfterGetRecord()
                begin
                    SrNo +=1;

                     clear(GSTrate);
                    clear(CGSTAmt);
                    clear(CGSTRate);
                    clear(SGSTAmt);
                    Clear(SGSTRate);
                    clear(IGSTAmt);
                    Clear(IGSTRate);
                    "Purchase Line".Reset();
                    "Purchase Line".SetRange("Document No.", "No.");
                    if "Purchase Line".FindFirst() then begin
                        repeat
                            taxinformation.Reset();
                            taxinformation.SetFilter("Tax Record ID", '%1', "Purchase Line".RecordId);
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
                        until "Purchase Line".Next() = 0;
                    end;
                    GSTrate := Abs(SGSTRate + IGSTRate + CGSTRate);
                    GSTAmt := Abs(SGSTAmt + IGSTAmt + CGSTAmt);
                end;
                
            }

            trigger OnAfterGetRecord()
            begin
                cust.Reset();
                cust.SetRange("No.","Purchase Header"."Sell-to Customer No.");
                if cust.FindFirst() then begin
                    custgst:=cust."GST Registration No.";
                end;
                st.Reset();
                st.SetRange(Code,"Purchase Header"."Location State Code");
                if st.FindFirst() then begin
                    comp_st:=st.Description;
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
        comp.CalcFields(Picture);
    end;
    var
    cust: Record Customer;
    comp: Record "Company Information";
    st: Record State;
    custgst: Code[20];
    SrNo: Integer;
    comp_st:Text[50];
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
