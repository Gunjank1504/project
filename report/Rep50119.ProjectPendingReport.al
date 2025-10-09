// report 50120 Project_Pending_Report
// {
//     ApplicationArea = All;
//     Caption = 'Project Pending Report';
//     UsageCategory = ReportsAndAnalysis;
//     DefaultLayout = RDLC;
//     RDLCLayout = 'Project_Pending_Report.rdl';

//     dataset
//     {
//         dataitem(SalesHeader; "Sales Header")
//         {
//             column(SalesOrderNo; "No.") { }
//             column(Project_Name; "Project Name") { }
//             column(Project_Location; "Ship-to City") { }

//             dataitem(SalesLine; "Sales Line")
//             {
//                 DataItemLink = "Document No." = FIELD("No.");

//                 column(FinishedItemNo; "No.") { }
//                 column(FinishedItemDescription; Description) { }
//                 column(Location_Code; "Location Code") { }

//                 dataitem(BOMLine; "Production BOM Line")
//                 {
//                     DataItemTableView = SORTING("Production BOM No.", "Line No.");

//                     column(ComponentItemNo; "No.") { }
//                     column(ComponentDescription; Description) { }
//                     column(TotalQuantity; TotalQuantity) { }
//                     column(QuantityPacked; QuantityPacked) { }
//                     column(Size; Size) { }
//                     column(Shade; Shade) { }
//                     column(PendingForDispatch; PendingForDispatch) { }
//                     column(LoadingVerifiedQty; LoadingVerifiedQty) { }
//                     column(ProductionVerifiedQty; ProductionVerifiedQty) { }


//                     trigger OnPreDataItem()
//                     var
//                         ItemRec: Record Item;
//                     begin
//                         if ItemRec.Get(SalesLine."No.") then begin
//                             if ItemRec."Production BOM No." <> '' then
//                                 SetRange("Production BOM No.", ItemRec."Production BOM No.")
//                             else
//                                 CurrReport.BREAK;
//                         end else
//                             CurrReport.BREAK;
//                     end;

//                     trigger OnAfterGetRecord()
//                     var
//                         PackingEntry: Record "Packing Entry";
//                         StoreEntry: Record "Store Entry";
//                     begin
//                         Clear(TotalQuantity);
//                         Clear(QuantityPacked);
//                         Clear(Size);
//                         Clear(Shade);
//                         TotalQuantity := SalesLine.Quantity * BOMLine."Quantity per";
//                         PackingEntry.Reset();
//                         PackingEntry.SetRange("Item No.", BOMLine."No.");
//                         PackingEntry.SetRange("O.C Number", SalesHeader."No.");
//                         if PackingEntry.FindFirst() then begin
//                             Size := PackingEntry.Size;
//                             Shade := PackingEntry.Shade;
//                             TotalQuantity := PackingEntry."Total Quantity";
//                         end;
//                         if PackingEntry.FindSet() then
//                             repeat
//                                 StoreEntry.Reset();
//                                 StoreEntry.SetRange("Packing No.", PackingEntry."Packing No.");
//                                 StoreEntry.SetRange("QR Generated", true);

//                                 if StoreEntry.FindSet() then
//                                     repeat
//                                         QuantityPacked += StoreEntry.Quantity;
//                                         LoadingVerifiedQty += StoreEntry.Loaded;
//                                         ProductionVerifiedQty += StoreEntry."Production Completed";
//                                     until StoreEntry.Next() = 0;
//                             until PackingEntry.Next() = 0;
//                             PendingForDispatch := TotalQuantity - LoadingVerifiedQty;
//                     end;
//                 }
//             }
//             trigger OnPreDataItem()
//             var
//                 ItemRec: Record Item;
//             begin
//                 SetRange("Document Type", "Document Type"::Order);
//                 if SalesOrderFilter <> '' then
//                     SetRange("No.", SalesOrderFilter);
//             end;


//         }
//     }

//     requestpage
//     {
//         layout
//         {
//             area(Content)
//             {
//                 group(FilterGroup)
//                 {
//                     field(SalesOrderFilter; SalesOrderFilter)
//                     {
//                         ApplicationArea = All;
//                         Caption = 'Sales Order No.';
//                     }
//                 }
//             }
//         }
//     }

//     var
//         SalesOrderFilter: Code[100];
//         TotalQuantity: Decimal;
//         QuantityPacked: Decimal;
//         "Loading Verification Date & Time": DateTime;
//         Shade: Text[100];
//         LoadingVerifiedQty: Decimal;
//         ProductionVerifiedQty: Decimal;
//         PendingForDispatch: Decimal;
// }


