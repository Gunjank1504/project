pageextension 61002 customerlistext extends "Customer List"
{

    actions
    {
        addafter("Bank Accounts")
        {
            action("sales team members list")
            {
                ApplicationArea = All;
                PromotedCategory = Process;
                Promoted = true;
                PromotedOnly = true;
                RunObject = page "sales team members list ";
                // RunPageView = where ("Customer No." = const ('10000'));
                RunPageLink = "Customer No." = field("No.");


            }
        }
    }
}
