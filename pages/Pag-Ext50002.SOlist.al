pageextension 80022 "SO _list" extends "Sales Order List"
{
    layout{
        addafter(Status)
        {
            field("Who did job";Rec."Who did job")
            {
                ApplicationArea = All;
                
            }
            field("when item was picked";Rec."when item was picked")
            {
                ApplicationArea = All;
            }
            field("where repaired";Rec."where repaired")
            {
                ApplicationArea =All;
            }
            field("when invoiced";Rec."Posting Date")
            {
                ApplicationArea =All;
            }
            field("location of repaired"; rec."location of repaired")
            {
            ApplicationArea = All;
            }
        }
    }
}
