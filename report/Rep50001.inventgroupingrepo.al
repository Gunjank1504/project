report 50001 invent_groupingrepo
{
    ApplicationArea = All;
    Caption = 'invent_grouping';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'rdl/invent_grouping.rdl';
    dataset
    {
        dataitem(ItemLedgerEntry; "Item Ledger Entry")
        {
            column(LocationCode; "Location Code")
            {
            }
            column(InvoicedQuantity; "Invoiced Quantity")
            {
            }
            column(Item_Description; "Item Description")
            {

            }
            column(Quantity; Quantity)
            {
            }
            column(RemainingQuantity; "Remaining Quantity")
            {
            }
            column(ReservedQuantity; "Reserved Quantity")
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
            column(ItemNo; "Item No.")
            {
            }
            column(EntryType; "Entry Type")
            {
            }
            column(EntryNo; "Entry No.")
            {
            }
            column(CostAmountActual; "Cost Amount (Actual)")
            {
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
}
