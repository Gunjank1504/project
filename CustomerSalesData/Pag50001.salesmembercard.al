page 50201 "sales team member card1"
{
    ApplicationArea = All;
    Caption = 'sales team member card';
    PageType = Card;
    SourceTable = "sales Member";
    
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Customer No. field.', Comment = '%';
                }
                field("Sales Member No"; Rec."Sales Member No")
                {
                    ToolTip = 'Specifies the value of the Sales Member No field.', Comment = '%';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                }
                field(Address; Rec.Address)
                {
                    ToolTip = 'Specifies the value of the Address field.', Comment = '%';
                }
                field(Address2; Rec.Address2)
                {
                    ToolTip = 'specifies the value of the Address2 field.', Comment = '%';
                }
                field("Mobile No"; Rec."Mobile No")
                {
                    ToolTip = 'Specifies the value of the Mobile No field.', Comment = '%';
                }
                field("Date of Joining"; Rec."Date of Joining")
                {
                    ToolTip = 'Specifies the value of the Date of Joining field.', Comment = '%';
                }
            }
        }
    }
}
