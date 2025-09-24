namespace GeneratedProject.GeneratedProject;

using Microsoft.Sales.Document;
using Microsoft.Foundation.Company;

report 50002 Asha_SQuot
{
    ApplicationArea = All;
    Caption = 'Asha_SQuot';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'RDL/Asha_SQuot.rdl';

    dataset
    {
        dataitem(SalesHeader; "Sales Header")
        {
            column(comp_pic;comp.Picture)
            {
                
            }
            column(comp_;comp.Name)
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
            column(comp_st;comp."State Code")
            {
                
            }
            column(comp_gst;comp."GST Registration No.")
            {
                
            }
            column(comp_pan;comp."P.A.N. No.")
            {
                
            }
            column(comp_ph;comp."Phone No.")
            {
                
            }
            column(comp_email;comp."E-Mail")
            {
                
            }
            column(comp_pc;comp."Post Code")
            {
                
            }
         
            column(No; "No.")
            {
            }
            column(SelltoCustomerNo; "Sell-to Customer No.")
            {
            }
            column(DocumentDate; "Document Date")
            {
            }
            column(SelltoCustomerName; "Sell-to Customer Name")
            {
            }
            column(SelltoAddress; "Sell-to Address")
            {
            }
            column(SelltoAddress2; "Sell-to Address 2")
            {
            }
            column(SelltoCity; "Sell-to City")
            {
            }
            column(SelltoCountryRegionCode; "Sell-to Country/Region Code")
            {
            }
            column(SelltoPostCode; "Sell-to Post Code")
            {
            }
            column(PaymentTermsCode; "Payment Terms Code")
            {
            }
            column(CurrencyCode; "Currency Code")
            {
            }
            column(ShipmentMethodCode; "Shipment Method Code")
            {
            }
            column(DueDate; "Due Date")
            {
            }
            column(SO_created_by;"SO created by")
            {
                
            }
            dataitem("Sales Line";"Sales Line")
            {
                column(No_;"No.")
                {
                    
                }
                column(Description;Description)
                {
                    
                }
                column(Quantity;Quantity)
                {
                    
                }
                column(Unit_Price;"Unit Price")
                {
                    
                }
                column(Shipment_Date;"Shipment Date")
                {
                    
                }
                column(Promised_Delivery_Date;"Promised Delivery Date")
                {
                    
                }
                column(Line_Amount;"Line Amount")
                {
                    
                }
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
    comp: Record "Company Information";

}
