report 50113 MOI_Report
{
    ApplicationArea = All;
    Caption = 'MOI_Report';
    RDLCLayout = 'RDL/Moi_reports.rdl';
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            column(comp; comp.name)
            {

            }
            column(compadd; comp.Address)
            {

            }
            column(compadd2; comp."Address 2")
            {

            }
            column(comppic;comp.Picture)
            {

            }

            column(No_; "No.")
            {
            }
            column(Ship_to_Address; "Ship-to Address")
            {
            }
            column(Document_Date; "Document Date")
            {

            }
            column(Salesperson_Code; "Salesperson Code")
            {

            }
            column(Quote_No_; "Quote No.")
            {

            }
            column(Shipment_Method_Code; "Shipment Method Code")
            {

            }
            column(Payment_Terms_Code; "Payment Terms Code")
            {

            }
            column(Shipment_Date; "Shipment Date")
            {

            }
            column(Sell_to_Customer_Name; "Sell-to Customer Name")
            {

            }


            dataitem(SalesLine; "Sales Line")
            {
                column(Item_Category_Code; "Item Category Code")
                {
                }
                column(Description; "Description")
                {
                }
                column(Quantity; "Quantity")
                {
                }
                column(Unit_of_Measure; "Unit of Measure")
                {
                }
                column(Unit_Price; "Unit Price")
                {
                }
                column(Line_Amount; "Line Amount")
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
        comp: Record "Company Information";
}
