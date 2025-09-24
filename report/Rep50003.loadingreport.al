namespace GeneratedProject.GeneratedProject;

using Microsoft.Sales.History;
using Microsoft.Foundation.Company;

report 50003 loading_report
{
    ApplicationArea = All;
    Caption = 'loading_report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'RDL/50003 loading.rdl';
    dataset
    {
        dataitem(SalesInvoiceHeader; "Sales Invoice Header")
        {
            column(comp_name;comp.Name)
            {
                
            }
            column(comp_city;comp.City)
            {
                
            }
            column(SelltoCustomerName; "Sell-to Customer Name")
            {
            }
            column(SelltoCity; "Sell-to City")
            {
            }
            column(VehicleNo; "Vehicle No.")
            {
            }
            column(DriverNo; "Driver No.")
            {
            }
            dataitem("Sales Invoice Line";"Sales Invoice Line")
            {
                  DataItemLink= "Document No." = field("No.");
                column(Quantity;Quantity/10)
                {
                    
                }
                column(Description;Description)
                {
                    
                }
                column(Variant_Code;"Variant Code")
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
    end;
    var
    comp:Record "Company Information";
}
