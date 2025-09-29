namespace GeneratedProject.GeneratedProject;

using Microsoft.Sales.Document;
using Microsoft.Inventory.Item;
using System.Utilities;
using Microsoft.Foundation.Company;

report 50006 Kuber_listing
{
    ApplicationArea = All;
    Caption = 'Kuber_listing';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'RDL/kuber_listing.rdl';
    dataset
    {
        dataitem(SalesHeader; "Sales Header")
        {
            DataItemTableView = where("Document Type" = filter(Order));

            RequestFilterFields="Document Date","No.","Sell-to Customer No.";
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
            column(No; "No.")
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
            column(SelltoCustomerNo; "Sell-to Customer No.")
            {
            }
            column(SelltoCustomerName; "Sell-to Customer Name")
            {
            }
            column(Sell_to_City;"Sell-to City")
            {
                
            }

            column(Due_Date;"Due Date")
            {
                
            }
            column(particular;particular)
            {
                
            }
            column(alldata;alldata)
            {
                
            }
            dataitem("Sales Line";"Sales Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemLinkReference = "SalesHeader";
                column(No_;"No.")
                {
                    
                }
                column(Description;Description)
                {
                    
                }
                column(Unit_Price;"Unit Price")
                {
                    
                }
                column(Net_Weight;"Net Weight")
                {
                    
                }
                column(Total_quantity;"Quantity (Base)")
                {
                    
                }
                column(Qty__Shipped__Base_;"Qty. Shipped (Base)")
                {
                    
                }
                column(recived_amt;recived_amt)
                {
                    
                }
                column(wt_shipped;wt_shipped)
                {
                    
                }
                column(rem_wt;rem_wt)
                {
                    
                }
                column(rem_qt;rem_qt)
                {
                    
                }
                column(amt;amt)
                {
                    
                }
                column(rem_amt;rem_amt)
                {
                    
                }
                column(Varient_Wt;Varient_Wt)
                {
                    
                }
              
                column(NoOFBag;NoOFBag)
                {
                    
                }
                column(NoOfBagShipped;NoOfBagShipped)
                {
                    
                }
                trigger OnAfterGetRecord()
                begin
                    amt:="Quantity (Base)"*"Unit Price";
                    recived_amt:="Quantity Shipped"*"Unit Price";
                    wt_shipped:="Quantity Shipped"/10;
                    rem_wt:="Net Weight"-wt_shipped;
                    rem_qt:="Quantity (Base)" - "Qty. Shipped (Base)";
                    rem_amt:=Amount-recived_amt;

                    itemV.Reset();
                    itemV.SetRange("Item No.","Sales Line"."No.");
                    // ItemV.SetRange(Code, "Sales Line"."Variant Code");
                     if itemV.FindFirst() then begin
                        Varient_Wt:=itemV.weight;
                        NoOFBag:="Sales Line"."Quantity (Base)" / Varient_Wt;
                        NoOfBagShipped:="Sales Line"."Quantity Shipped" / Varient_Wt;
                     end
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
                group(filter)
                {
                    field(alldata;alldata)
                    {
                        Caption = 'alldata';
                        ApplicationArea = All;
                    }
                    field(particular;particular)
                    {
                        Caption = 'particular';
                        ApplicationArea = All;
                        
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
    trigger OnInitReport()
    begin
        comp.Get();
        comp.CalcFields(Picture);
    end;
    var
    comp: Record "Company Information";
    recived_amt:Decimal;
    wt_shipped:Decimal;
    rem_wt:Decimal;
    rem_qt:Decimal;
    rem_amt:Decimal;
    amt:decimal;
    itemV:Record "Item Variant";
    Varient_Wt:Decimal;
    NoOFBag:Decimal;
    NoOfBagShipped:Decimal;
    alldata:Boolean;
    particular:Boolean;
}
