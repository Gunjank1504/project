namespace GeneratedProject.GeneratedProject;

using Microsoft.Finance.GeneralLedger.Journal;

report 50010 "Genjournal_report"
{
    ApplicationArea = All;
    Caption = 'Genjournal_report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'RDL/50009_Gen_report.rdl';
    dataset
    {
        dataitem(GenJournalLine; "Gen. Journal Line")
        {
            RequestFilterFields = "Account Type";
            column(Amount; Amount)
            {
            }
            column(SrNo; SrNo)
            {

            }
            column(Account_Type; "Account Type")
            {

            }
            column(AccountNo; "Account No.")
            {
            }
            column(Journal_Template_Name; "Journal Template Name")
            {

            }
            column(Bill_to_Pay_to_No_; "Bill-to/Pay-to No.")
            {

            }
            column(PostingDate; "Posting Date")
            {
            }
            column(Description; Description)
            {
            }
            column(DebitAmount; "Debit Amount")
            {
            }
            column(BalanceLCY; "Balance (LCY)")
            {
            }
            column(BalAccountType; "Bal. Account Type")
            {
            }
            column(GenPostingType; "Gen. Posting Type")
            {
            }
            column(GenBusPostingGroup; "Gen. Bus. Posting Group")
            {
            }
            column(JournalBatchName; "Journal Batch Name")
            {
            }
            column(PaymentTermsCode; "Payment Terms Code")
            {
            }
            column(DueDate; "Due Date")
            {
            }
            column(DocumentNo; "Document No.")
            {
            }
            column(DocumentType; "Document Type")
            {
            }
            trigger OnAfterGetRecord()
            begin
                SrNo += 1;
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
        SrNo: Integer;
}
