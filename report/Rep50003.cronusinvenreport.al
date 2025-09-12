report 50300cronus_inven_report
{
    ApplicationArea = All;
    Caption = 'cronus_inven_report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'cronus_inven_report.rdl';
    dataset
    {
        dataitem(SalesHeader; "Sales Header")
        {
            column(comppic; comp.Picture)
            {
            }
            column(compname; comp.Name)
            {
            }
            column(compadd; comp.Address)
            {

            }
            column(compadd2; comp."Address 2")
            {

            }
            column(compcity; comp.City)
            {

            }
            column(compstate; comp."State Code")
            {

            }
            column(comppostcode; comp."Post Code")
            {

            }
            column(compgst; comp."GST Registration No.")
            {

            }
            column(Posting_Date; "Posting Date")
            {

            }
            dataitem("Sales Line"; "Sales Line")
            {
                column(No_; "No.")
                {

                }
                column(shelf_no; shelf_no)
                {

                }
                column(Description; Description)
                {

                }
                column(Unit_of_Measure; "Unit of Measure")
                {

                }
                column(Quantity; Quantity)
                {

                }
                column(Unit_Price; "Unit Price")
                {

                }
                column(Amount; Amount)
                {

                }
                column(inv_posting_group; inv_posting_group)
                {

                }
                column(vendor_item_no; vendor_item_no)
                {

                }
                column(BOM; BOM)
                {

                }
                trigger OnAfterGetRecord()
                begin
                    item.Reset();
                    item.SetRange("No.", "Sales Line"."No.");
                    if item.FindFirst() then begin
                        shelf_no := item."Shelf No.";
                        inv_posting_group := item."Inventory Posting Group";
                        vendor_item_no := item."Vendor Item No.";
                        BOM := item."Production BOM No.";
                    end;
                    Amount := Quantity * "Unit Price";

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
        comp: Record "Company Information";
        item: Record Item;
        shelf_no: Text[20];
        inv_posting_group: Text[20];
        vendor_item_no: Code[20];
        BOM: Code[20];
}
