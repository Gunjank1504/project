// codeunit 50000 transporter
// {
//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"", 'OnAfterInsertCrMemoHeader', '', false, false)]
//     local procedure CopyTransporterNameToCrMemo(SalesHeader: Record "Sales Header";  var SalesCrMemoHeader: Record "Sales Cr.Memo Header")
//     begin
//         SalesCrMemoHeader."Transporter Name" := SalesHeader."Transporter Name";
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterInsertCrMemoHeader', '', false, false)]
//     local procedure CopyTransporterNameToPostedCrMemo(SalesHeader: Record "Sales Header"; var SalesCrMemoHeader: Record "Sales Cr.Memo Header")
//     begin
//         SalesCrMemoHeader."Transporter Name" := SalesHeader."Transporter Name";
//     end;
    
// }
