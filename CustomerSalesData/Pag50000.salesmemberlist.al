page 50020 "sales team members list "
{
    ApplicationArea = All;
    Caption = 'sales team member list';
    PageType = List;
    SourceTable = "sales Member";
    UsageCategory = Administration;
    CardPageId =  "sales team member card1";
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
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
                     field(Address2;Rec.Address2)
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
             
             
           
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.', Comment = '%';
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.', Comment = '%';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.', Comment = '%';
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.', Comment = '%';
                }
            }
        }
    }
}
