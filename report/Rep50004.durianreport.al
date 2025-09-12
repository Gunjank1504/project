report 60004 durian_report
{
    ApplicationArea = All;
    Caption = 'durian_report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'durian_rep.rdl';
    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            RequestFilterFields = "Location Code";
            column(comp_name; comp.Name)
            {

            }
            column(comp_pic;comp.Picture)
            {
                
            }
            column(compadd;comp.Address)
            {
                
            }
            column(compadd2;comp."Address 2")
            {
                
            }
            column(comp_city;comp.City)
            {
                
            }
            column(comp_state;comp."State Code")
            {
                
            }
            column(comp_post;comp."Post Code")
            {
                
            }
            column(compgst;comp."GST Registration No.")
            {
                
            }
            column(StartDate; StartDate)
            {

            }
            column(EndDate; EndDate)
            {

            }
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink= "Document No." = field("No.");

                column(Document_No_; "Document No.")
                {

                }
                column(No_; "No.")
                {

                }
                column(Posting_Date; "Posting Date")
                {

                }
                column(Description; Description)
                {

                }
                column(Sell_to_Customer_No_; "Sell-to Customer No.")
                {

                }
                column(Sell_to_Customer_Name; "Sell-to Customer Name")
                {

                }
                column(Location_Code; "Location Code")
                {

                }
                column(Quantity; Quantity)
                {

                }
                column(Inventry; Inventry)
                {

                }
                column(shrt_qty;shrt_qty)
                {
                    
                }
                column(blueQty;blueQty)
                {
                    
                }
                column(redQty;redQty)
                {
                    
                }
                column(westQty;westQty)
                {
                    
                }
                column(eastQty;eastQty)
                {
                    
                }
                column(final_short_Qty;final_short_Qty)
                {
                    
                }
                trigger OnAfterGetRecord()
                var
                    ItemLedger: Record "Item Ledger Entry";
                begin
                    ItemLedger.Reset();
                    ItemLedger.SetRange("Item No.", ItemNo);
                    ItemLedger.SetRange("Location Code", LocCode);
                    ItemLedger.CalcSums("Remaining Quantity");
                    Inventry := ItemLedger."Remaining Quantity";

                //short quantity
                    if Quantity > Inventry then 
                    shrt_qty := Quantity-Inventry
                    else
                    shrt_qty := 0;

                //location blue availability
                    ItemLedger.Reset();
                    ItemLedger.SetRange("Item No.",ItemNo);
                    ItemLedger.SetRange("Location Code",blue);
                    ItemLedger.CalcSums("Remaining Quantity");
                    blueQty:=ItemLedger."Remaining Quantity";
                    if blueQty < 0 then
                    CurrReport.Skip();
                    if shrt_qty > blueQty then
                    final_short_Qty := shrt_qty - blueQty;

                //location red availability
                     ItemLedger.Reset();
                    ItemLedger.SetRange("Item No.",ItemNo);
                    ItemLedger.SetRange("Location Code",red);
                    ItemLedger.CalcSums("Remaining Quantity");
                    redQty:=ItemLedger."Remaining Quantity";
                    if redQty < 0 then
                    CurrReport.Skip();
                    if shrt_qty > redQty then
                    final_short_Qty := shrt_qty - redQty;

                //location east availability
                     ItemLedger.Reset();
                    ItemLedger.SetRange("Item No.",ItemNo);
                    ItemLedger.SetRange("Location Code",east);
                    ItemLedger.CalcSums("Remaining Quantity");
                    eastQty:=ItemLedger."Remaining Quantity";
                        if eastQty < 0 then
                        CurrReport.Skip();
                        if shrt_qty > eastQty then
                    final_short_Qty := shrt_qty - eastQty;


                //location west availability
                     ItemLedger.Reset();
                    ItemLedger.SetRange("Item No.",ItemNo);
                    ItemLedger.SetRange("Location Code",west);
                    ItemLedger.CalcSums("Remaining Quantity");
                    westQty:=ItemLedger."Remaining Quantity";
                    if westQty < 0 then
                    CurrReport.Skip();
                    if shrt_qty > westQty then
                    final_short_Qty := shrt_qty - westQty;
                    

                end;


            }
            trigger OnPreDataItem()
            begin
                SETRANGE("Posting Date", StartDate, EndDate);
            end;


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
                    field(StartDate; StartDate)
                    {
                        Caption = 'StartDate';
                        ApplicationArea = all;
                    }
                    field(EndDate; EndDate)
                    {
                        ApplicationArea = all;
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
        comp.CalcFields(Picture)
    end;

    var
        comp: Record "Company Information";
        ItemLedger: Record "Item Ledger Entry";
        StartDate: Date;
        EndDate: Date;
        LocCode: Code[10];
        ItemNo: code[10];
        Inventry: Decimal;
        shrt_qty:Decimal;
        blue:Code[20];
        blueQty:Decimal;
        redQty:Decimal;
        red:Code[20];
        east:Code[20];
        eastQty:Decimal;
        west:Code[20];
        westQty:Decimal;
        final_short_Qty:Decimal;

}
