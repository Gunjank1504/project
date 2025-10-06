namespace GeneratedProject.GeneratedProject;

using Microsoft.Sales.Document;
using Microsoft.Foundation.Company;

report 80009 Salesorder_report
{
    ApplicationArea = All;
    Caption = 'Salesorder_report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout=RDLC;
    RDLCLayout='RDL/Salesorder_report.rdl';
    
    dataset
    {
        dataitem("Sales Header";"Sales Header")
        {
            column(compname;comp.Name){


            }
            column(compaddress;comp.Address){}
            column(compadd2;comp."Address 2"){}
            column(compGST;comp."GST Registration No."){}
            column(No_;"No."){}
            column(Sell_to_Address;"Sell-to Address"){}
            column(Sell_to_Customer_Name;"Sell-to Customer Name"){}
            column(Bill_to_Name;"Bill-to Name"){}
            column(Bill_to_Address;"Bill-to Address"){}

        
        dataitem(SalesLine; "Sales Line")
        {
            DataItemLink="Document No." = field("No.");
            column(No_1;"No."){}
            column(Description; Description)
            {
            }
            column(Quantity; Quantity)
            {
            }
            column(No; "No.")
            {
            }
            column(UnitPrice; "Unit Price")
            {
            }
            column(UnitofMeasure; "Unit of Measure")
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
    var
        myInt: Integer;
    begin
        comp.Get();
        comp.CalcFields(Picture);
        
    end;
    var
    comp:Record"Company Information";
}
