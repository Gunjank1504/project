namespace GeneratedProject.GeneratedProject;

page 50001 Merch_Ext
{
    ApplicationArea = All;
    Caption = 'Merch_Ext';
    PageType = List;
    SourceTable = Merch_detail;
    CardPageId = Merch_card;
    UsageCategory = Lists;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Client ID"; Rec."Client ID")
                {
                    ToolTip = 'Specifies the value of the Client ID field.', Comment = '%';
                    Editable=TRUE;
                }
                field("Device No"; Rec."Device No")
                {
                    ToolTip = 'Specifies the value of the Device No field.', Comment = '%';
                    Editable=TRUE;
                }
                field(IMEI; Rec.IMEI)
                {
                    ToolTip = 'Specifies the value of the IMEI field.', Comment = '%';
                    Editable=TRUE;
                }
                field("Merchant ID"; Rec."Merchant ID")
                {
                    ToolTip = 'Specifies the value of the Merchant ID field.', Comment = '%';
                    Editable=TRUE;
                }
                field("Merchant Name"; Rec."Merchant Name")
                {
                    ToolTip = 'Specifies the value of the Merchant Name field.', Comment = '%';
                    Editable=TRUE;
                }
                field("Merchant Store POS Code"; Rec."Merchant Store POS Code")
                {
                    ToolTip = 'Specifies the value of the Merchant Store POS Code field.', Comment = '%';
                    Editable=TRUE;
                }
                field("Security Token No"; Rec."Security Token No")
                {
                    ToolTip = 'Specifies the value of the Security Token No field.', Comment = '%';
                    Editable=TRUE;
                }
                field("Store ID"; Rec."Store ID")
                {
                    ToolTip = 'Specifies the value of the Store ID field.', Comment = '%';
                    Editable=TRUE;
                }
                field("Store Name"; Rec."Store Name")
                {
                    ToolTip = 'Specifies the value of the Store Name field.', Comment = '%';
                    Editable=TRUE;
                }
                // field(SystemCreatedAt; Rec.SystemCreatedAt)
                // {
                //     ToolTip = 'Specifies the value of the SystemCreatedAt field.', Comment = '%';
                //     Editable=TRUE;
                // }
                // field(SystemCreatedBy; Rec.SystemCreatedBy)
                // {
                //     ToolTip = 'Specifies the value of the SystemCreatedBy field.', Comment = '%';
                //     Editable=TRUE;
                // }
                // field(SystemId; Rec.SystemId)
                // {
                //     ToolTip = 'Specifies the value of the SystemId field.', Comment = '%';
                //     Editable=TRUE;
                // }
                // field(SystemModifiedAt; Rec.SystemModifiedAt)
                // {
                //     ToolTip = 'Specifies the value of the SystemModifiedAt field.', Comment = '%';
                //     Editable=TRUE;
                // }
                // field(SystemModifiedBy; Rec.SystemModifiedBy)
                // {
                //     ToolTip = 'Specifies the value of the SystemModifiedBy field.', Comment = '%';
                //     Editable=TRUE;
                // }
            }
        }
    }
}
