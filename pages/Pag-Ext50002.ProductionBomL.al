// namespace GeneratedProject.GeneratedProject;

// using Microsoft.Manufacturing.ProductionBOM;
// using Microsoft.Inventory.Item;
// using Microsoft.Inventory.Posting;

// pageextension 50276 ProdBomLines extends "Production BOM Lines"
// {
//     layout
//     {
//         addafter("Quantity per")
//         {
//             field(Shade; Rec.Shade)
//             {
//                 ApplicationArea = All;
//                 ToolTip = 'Specifies the value of the Shade field.', Comment = '%';
//             }
//             field("Stock up Qty"; Rec."Stock up Qty")
//             {
//                 ApplicationArea = All;
//                 ToolTip = 'Specifies the value of the Stock up Qty field.', Comment = '%';
//             }
//             field("Location Code"; Rec."Location Code")
//             {
//                 ApplicationArea = All;
//                 ToolTip = 'Specifies the value of the Location Code field.', Comment = '%';
//             }
//         }
//         modify("Quantity per")
//         {
//             trigger OnAfterValidate()
//             var
//                 ProdBOM: Record "Production BOM Header";
//             begin
//                 Clear(ProdBOM);
//                 ProdBOM.Get("Production BOM No.");
//                 Rec."Stock up Qty" := Rec."Quantity per" * ProdBOM."SO Qty";
//             end;
//         }
//     }
//     actions
//     {
//         addafter("&Component")
//         {
//             action("Stock UP")
//             {
//                 Promoted = true;
//                 PromotedOnly = true;
//                 PromotedCategory = Process;
//                 Image = UpdateShipment;
//                 trigger OnAction()
//                 var
//                     Itemjournl, Itemjournl2 : Record "Item Journal Line";
//                     ReserEntry, ReserEntry2 : Record "Reservation Entry";
//                     LineNo: Integer;
//                     EntryLast: Integer;
//                     BatchText: Text;
//                     ItemjouPost: Codeunit "Item Jnl.-Post";

//                     Result: Integer;
//                     ItemRec: Record Item;
//                 begin
//                     // if Confirm('Are you sure to stock up for this line ?') then begin

//                     BatchText := 'Non-BOM';

//                     Itemjournl2.Reset();
//                     Itemjournl2.SetRange("Journal Template Name", 'ITEM');
//                     Itemjournl2.SetRange("Journal Batch Name", BatchText);
//                     if Itemjournl2.FindLast() then
//                         LineNo := Itemjournl2."Line No." + 10000
//                     else
//                         LineNo := 10000;


//                     // Message(Format(LineNo));
//                     Itemjournl.Init();
//                     Itemjournl."Journal Template Name" := 'ITEM';
//                     Itemjournl."Journal Batch Name" := BatchText;
//                     Itemjournl."Line No." := LineNo;
//                     Itemjournl.Validate(Itemjournl."Entry Type", Itemjournl."Entry Type"::"Positive Adjmt.");
//                     Itemjournl.Validate(Itemjournl."Item No.", "No.");
//                     Itemjournl.Validate(Itemjournl."Posting Date", Today);
//                     Itemjournl.Validate("Document No.", 'Stockup');
//                     Itemjournl.Validate("Location Code", "Location Code");
//                     Itemjournl.Validate(Quantity, Rec."Stock up Qty");
//                     // Itemjournl.Validate(Itemjournl."Shortcut Dimension 1 Code", ItemLedEntry."Global Dimension 1 Code");
//                     Itemjournl.Insert();
//                     // Message('IJ Inserted');

//                     Clear(ItemRec);
//                     if (ItemRec.Get(rec."No.")) and (ItemRec."Item Tracking Code" <> '') then begin
//                         ReserEntry2.Reset();
//                         if ReserEntry2.FindLast() then
//                             EntryLast := ReserEntry2."Entry No.";

//                         ReserEntry.Init();
//                         ReserEntry."Entry No." := EntryLast + 1;
//                         ReserEntry.Validate("Item No.", Rec."No.");
//                         ReserEntry."Location Code" := 'KA2 P';
//                         ReserEntry."Quantity (Base)" := Rec."Quantity per";
//                         ReserEntry."Reservation Status" := ReserEntry."Reservation Status"::Prospect;
//                         ReserEntry."Creation Date" := Today;
//                         ReserEntry."Source Type" := 83;
//                         ReserEntry."Source Subtype" := 2;
//                         ReserEntry."Source ID" := 'ITEM';
//                         ReserEntry."Source Batch Name" := BatchText;
//                         ReserEntry."Source Ref. No." := LineNo;
//                         // Message(Format(LineNo) + '   ReserEntry   ' + Format(ReserEntry));

//                         ReserEntry."Expected Receipt Date" := Today;
//                         ReserEntry."Created By" := UserId;
//                         ReserEntry.Positive := true;
//                         ReserEntry.Quantity := Rec."Quantity per";
//                         ReserEntry."Qty. to Handle (Base)" := Rec."Quantity per";
//                         ReserEntry."Qty. to Invoice (Base)" := Rec."Quantity per";
//                         ReserEntry."Lot No." := 'OPEN';
//                         ReserEntry."Item Tracking" := ReserEntry."Item Tracking"::"Lot No.";
//                         ReserEntry.Insert();
//                     end;
//                     ItemjouPost.Run(Itemjournl);

//                     //Message('Inserted');
//                     //  end;
//                 end;
//             }
//         }
//     }
// }
