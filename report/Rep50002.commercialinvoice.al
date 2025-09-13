report 50112 "commercial invoice"
{
    ApplicationArea = All;
    Caption = 'commercial invoice';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout ='RDL/commercial_report.rdl';
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
            column(comp_state;comp."State Code")
            {
                
            }
            column(comp_gst;comp."GST Registration No.")
            {
                
            }
            column(ReferenceInvoiceNo; "Reference Invoice No.")
            {
            }
            column(Posting_Date;"Posting Date")
            {
                
            }
            column(OrderNo; "Order No.")
            {
            }
            column(OrderDate; "Order Date")
            {
            }
            column(Bill_to_Name;"Bill-to Name")
            {
                
            }
            column(Bill_to_Address;"Bill-to Address")
            {
                
            }
            column(Bill_to_Country_Region_Code;"Bill-to Country/Region Code")
            {
                
            }
            column(Bill_to_City;"Bill-to City")
            {
                
            }
            column(Bill_to_Contact_No_;"Bill-to Contact No.")
            {
                
            }
            column(Ship_to_Name;"Ship-to Name")
            {
                
            }
            column(Ship_to_Address;"Ship-to Address")
            {
                
            }
            column(Ship_to_Country_Region_Code;"Ship-to Country/Region Code")
            {
                
            }
            column(Ship_to_Contact;"Ship-to Contact")
            {
                
            }

            column(ModeofTransport; "Mode of Transport")
            {
            }
            column(PaymentTermsCode; "Payment Terms Code")
            {
            }

            dataitem("Sales Invoice Line";"Sales Invoice Line")
        {
           column(SerialNo;SerialNo)
           {
            
           }
           column(Description;Description)
           {
            
           }
           column(Qty__per_Unit_of_Measure;"Qty. per Unit of Measure")
           {
            
           }
           column(Quantity;Quantity)
           {
            
           }
           column(Unit_Price;"Unit Price")
           {
            
           }
           column(Amount;Amount)
           {
            
           }
           column(HSN_SAC_Code;"HSN/SAC Code")
           {
            
           }
           trigger OnAfterGetRecord()
           begin
           Amount := Quantity*"Unit Price";
           end;
        }
        trigger OnAfterGetRecord()
        begin
            SerialNo += 1;
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
    var
    comp: Record "Company Information";
    SerialNo:Integer;
    Amount:Decimal;
}
