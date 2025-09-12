pageextension 60203 delivery_challan2 extends "Business Manager Role Center"
{
    actions{
        addafter("Issued Finance Charge Memos")
        {
            action("deliverychallan2")
            {
                ApplicationArea = All;
                RunObject = report "Delivery challan2";
                Image = Report;


            }
        }
    }
}
