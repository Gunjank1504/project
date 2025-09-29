namespace GeneratedProject.GeneratedProject;

using Microsoft.Sales.History;

report 50007 kuber_stateGrouping
{
    ApplicationArea = All;
    Caption = 'kuber_stateGrouping';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'RDL/50007_kuberstategrp.rdl';
    dataset
    {
        dataitem(SalesInvoiceHeader; "Sales Invoice Header")
        {
            column(State;State)
            {
                
            }
            column(LocationStateCode; "Location State Code")
            {
            }
            column(Posting_Date;"Posting Date")
            {
                
            }
            dataitem("Sales Invoice Line";"Sales Invoice Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemLinkReference = SalesInvoiceHeader;
                column(Net_Weight;"Net Weight")
                {
                    
                }
                column(Quantity;Quantity)
                {
                    
                }
                column(amt;amt)
                {
                    
                }
                trigger OnAfterGetRecord()
                begin
                    amt:="Quantity (Base)"* "Unit Price";
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
    var
    amt:Decimal;
}
