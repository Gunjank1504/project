report 50041 kuber_crnote
{
    ApplicationArea = All;
    Caption = 'kuber_crnote';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'RDL/kubescr.rdl';
    dataset
    {
        dataitem(SalesCrMemoHeader; "Sales Cr.Memo Header")
        {
            column(comp_name;comp.Name)
            {
                
            }
            column(comp_add;comp.Address)
            {
                
            }
            column(comp_add2;comp."Address 2")
            {
                
            }
            column(comp_city;comp.City)
            {
                
            }
            column(comp_ph;comp."Phone No.")
            {
                
            }
            column(comp_ph2;comp."Phone No. 2")
            {
                
            }
            column(comp_mail;comp."E-Mail")
            {
                
            }
            column(comp_gst;comp."GST Registration No.")
            {
                
            }
            column(No; "No.")
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
            column(Shipment_Date;"Shipment Date")
            {
            }
            column(ExternalDocumentNo; "External Document No.")
            {
            }
            column(BilltoName; "Bill-to Name")
            {
            }
            column(BilltoAddress; "Bill-to Address")
            {
            }
            column(BilltoAddress2; "Bill-to Address 2")
            {
            }
            column(BilltoCity; "Bill-to City")
            {
            }
            column(BilltoPostCode; "Bill-to Post Code")
            {
            }
            column(BilltoCountryRegionCode; "Bill-to Country/Region Code")
            {
            }
            column(BilltoContactNo; "Bill-to Contact No.")
            {
            }
            column(TransportMethod; "Transport Method")
            {
            }
            column(Vehicle_No_;"Vehicle No.")
            {
                
            }
            column(Customer_GST_Reg__No_;"Customer GST Reg. No.")
            {
                
            }
            column(custst;custst)
            {
                
            }
            column(custstname;custstname)
            {
                
            }
            column(lrno;lrno)
            {
                
            }
            column(lrdate;lrdate)
            {
                
            }
            column(transporterN;transporterN)
            {
                
            }
            dataitem("Sales Cr.Memo Line";"Sales Cr.Memo Line")
            {
                column(SrNo;SrNo)
                {
                    
                }
                column(Description;Description)
                {
                    
                }
                column(HSN_SAC_Code;"HSN/SAC Code")
                {
                    
                }
                column(Quantity;Quantity)
                {
                    
                }
                column(Unit_Price;"Unit Price")
                {
                    
                }
                column(GSTRate;GSTRate)
                {
                    
                }
                column(Amount;Amount)
                {
                    
                }
                column(Amountinwords;Amountinwords)
                {
                    
                }
                column(grandtotal;grandtotal)
                {
                    
                }
                column(GSTAmt;GSTAmt)
                {
                    
                }
                trigger OnAfterGetRecord()
                begin
                    SrNo += 1;
                    Amount:=Quantity*"Unit Price";
                    grandtotal:= GSTAmt + Amount;

                    clear(GSTrate);
                    clear(CGSTAmt);
                    clear(CGSTRate);
                    clear(SGSTAmt);
                    Clear(SGSTRate);
                    clear(IGSTAmt);
                    Clear(IGSTRate);
                    "Sales Cr.Memo Line".Reset();
                     "Sales Cr.Memo Line".SetRange("Document No.", "No.");
                    if  "Sales Cr.Memo Line".FindFirst() then begin
                        repeat
                            taxinformation.Reset();
                            taxinformation.SetFilter("Tax Record ID", '%1',  "Sales Cr.Memo Line".RecordId);
                            taxinformation.SetFilter("Value Type", '1%', taxinformation."Value Type"::COMPONENT);
                            taxinformation.SetRange("Visible on Interface", true);
                            if taxinformation.FindFirst() then begin
                                repeat
                                    ComponentAmt := TaxTypeObjHelper.GetComponentAmountFrmTransValue(taxinformation);
                                    if taxinformation.GetAttributeColumName() = 'CGST' then begin
                                        CGSTAmt += ComponentAmt;
                                        CGSTRate := taxinformation.percent;

                                    end;
                                    if taxinformation.GetAttributeColumName() = 'SGST' then begin
                                        SGSTAmt += ComponentAmt;
                                        SGSTRate := taxinformation.percent;
                                    end;
                                    if taxinformation.GetAttributeColumName() = 'IGST' then begin
                                        IGSTAmt += ComponentAmt;
                                        IGSTRate := taxinformation.percent;
                                    end;

                                until taxinformation.Next() = 0;
                            end;
                        until  "Sales Cr.Memo Line".Next() = 0;
                    end;
                    GSTrate := Abs(SGSTRate + IGSTRate + CGSTRate);
                    GSTAmt := Abs(SGSTAmt + IGSTAmt + CGSTAmt);

                         Clear(Amountinwords);
                    InitTextVariable();
                    grandtotal:= round(grandtotal, 0.01);
                    FormatNoText(Notext1, grandtotal,  "Sales Cr.Memo Line".GetCurrencyCode());
                    Amountinwords := Notext1[1];

                end;
            }
            trigger OnAfterGetRecord()
            begin
                cust.Reset();
                cust.SetRange("No.",SalesCrMemoHeader."Bill-to Customer No.");
                st.SetRange(Code,cust."State Code");
                if cust.FindFirst() then begin
                    custst:= st."State Code (GST Reg. No.)";
                    custstname:=st.Description;
                end;
                //LRnumber and transportername
                salesinv.Reset();
                salesinv.SetRange("No.",SalesCrMemoHeader."Applies-to Doc. No.");
                if salesinv.FindFirst() then begin
                    transporterN:= salesinv."Transporter Name";
                    lrno:= salesinv."LR/RR No.";
                    lrdate:=salesinv."LR/RR Date";
                end;
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
    trigger OnInitReport()
    begin
        comp.Get();
    end;
    var
    salesinv:Record "Sales Invoice Header";
    comp:Record "Company Information";
    cust:Record Customer;
    st:Record State;
    lrno: Text[20];
    lrdate:Date;
    custstname:Text[20];
    transporterN: Text[100];
    custst:Code[20];
    SrNo:Integer;
    Amount:Decimal;
    grandtotal:Decimal;
    GSTAmt: Decimal;
        ItemGstrate: Decimal;
        CGSTAmt: Decimal;
        IGSTAmt: Decimal;
        SGSTAmt: Decimal;
        GSTRate: Decimal;
        IGSTRate: Decimal;
        SGSTRate: Decimal;
        CGSTRate: Decimal;
        taxinformation: Record "Tax Transaction Value";
        ComponentAmt: Decimal;
        TaxTypeObjHelper: Codeunit "Tax Type Object Helper";
        AmountinwordsGST: text;
        Amountinwords: Text;
        Notext1: array[2] of Text[100];
        Notext2: array[2] of Text[100];
        Text16526: Label 'ZERO';
        Text16527: Label 'HUNDRED';
        Text16528: Label 'AND';
        Text16529: Label '%1 results in a written number that is too long.';
        Text16532: Label 'ONE';
        Text16533: Label 'TWO';
        Text16534: Label 'THREE';
        Text16535: Label 'FOUR';
        Text16536: Label 'FIVE';
        Text16537: Label 'SIX';
        Text16538: Label 'SEVEN';
        Text16539: Label 'EIGHT';
        Text16540: Label 'NINE';
        Text16541: Label 'TEN';
        Text16542: Label 'ELEVEN';
        Text16543: Label 'TWELVE';
        Text16544: Label 'THIRTEEN';
        Text16545: Label 'FOURTEEN';
        Text16546: Label 'FIFTEEN';
        Text16547: Label 'SIXTEEN';
        Text16548: Label 'SEVENTEEN';
        Text16549: Label 'EIGHTEEN';
        Text16550: Label 'NINETEEN';
        Text16551: Label 'TWENTY';
        Text16552: Label 'THIRTY';
        Text16553: Label 'FORTY';
        Text16554: Label 'FIFTY';
        Text16555: Label 'SIXTY';
        Text16556: Label 'SEVENTY';
        Text16557: Label 'EIGHTY';
        Text16558: Label 'NINETY';
        Text16559: Label 'THOUSAND';
        Text16560: Label 'MILLION';
        Text16561: Label 'BILLION';
        Text16562: Label 'LAKH';
        Text16563: Label 'CRORE';
        OnesText: array[20] of Text[30];
        TensText: array[10] of Text[30];
        ExponentText: array[5] of Text[30];
        AmountInWordsCaptionLbl: Label 'Amount (in words):';



    procedure FormatNoText(var NoText: array[2] of Text[100]; No: Decimal; CurrencyCode: Code[10])
    var
        PrintExponent: Boolean;
        Ones: Integer;
        Tens: Integer;
        Hundreds: Integer;
        Exponent: Integer;
        NoTextIndex: Integer;
        Currency: Record 4;
        TensDec: Integer;
        OnesDec: Integer;
    begin
        CLEAR(NoText);
        NoTextIndex := 1;
        NoText[1] := '';

        IF No < 1 THEN
            AddToNoText(NoText, NoTextIndex, PrintExponent, Text16526)
        ELSE BEGIN
            FOR Exponent := 4 DOWNTO 1 DO BEGIN
                PrintExponent := FALSE;
                IF No > 99999 THEN BEGIN
                    Ones := No DIV (POWER(100, Exponent - 1) * 10);
                    Hundreds := 0;
                END ELSE BEGIN
                    Ones := No DIV POWER(1000, Exponent - 1);
                    Hundreds := Ones DIV 100;
                END;
                Tens := (Ones MOD 100) DIV 10;
                Ones := Ones MOD 10;
                IF Hundreds > 0 THEN BEGIN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Hundreds]);
                    AddToNoText(NoText, NoTextIndex, PrintExponent, Text16527);
                END;
                IF Tens >= 2 THEN BEGIN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[Tens]);
                    IF Ones > 0 THEN
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Ones]);
                END ELSE
                    IF (Tens * 10 + Ones) > 0 THEN
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Tens * 10 + Ones]);
                IF PrintExponent AND (Exponent > 1) THEN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, ExponentText[Exponent]);
                IF No > 99999 THEN
                    No := No - (Hundreds * 100 + Tens * 10 + Ones) * POWER(100, Exponent - 1) * 10
                ELSE
                    No := No - (Hundreds * 100 + Tens * 10 + Ones) * POWER(1000, Exponent - 1);
            END;
        END;

        IF CurrencyCode <> '' THEN BEGIN
            Currency.GET(CurrencyCode);
            AddToNoText(NoText, NoTextIndex, PrintExponent, ' ');
        END ELSE
            AddToNoText(NoText, NoTextIndex, PrintExponent, 'DOLLAR');

        AddToNoText(NoText, NoTextIndex, PrintExponent, Text16528);

        TensDec := ((No * 100) MOD 100) DIV 10;
        OnesDec := (No * 100) MOD 10;
        IF TensDec >= 2 THEN BEGIN
            AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[TensDec]);
            IF OnesDec > 0 THEN
                AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[OnesDec]);
        END ELSE
            IF (TensDec * 10 + OnesDec) > 0 THEN
                AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[TensDec * 10 + OnesDec])
            ELSE
                AddToNoText(NoText, NoTextIndex, PrintExponent, Text16526);
        IF (CurrencyCode <> '') THEN
            AddToNoText(NoText, NoTextIndex, PrintExponent, ' ' + '' + ' ONLY')
        ELSE
            AddToNoText(NoText, NoTextIndex, PrintExponent, ' PAISA ONLY');
    end;

    local procedure AddToNoText(var NoText: array[2] of Text[100]; var NoTextIndex: Integer; var PrintExponent: Boolean; AddText: Text[30])
    begin
        PrintExponent := TRUE;

        WHILE STRLEN(NoText[NoTextIndex] + ' ' + AddText) > MAXSTRLEN(NoText[1]) DO BEGIN
            NoTextIndex := NoTextIndex + 1;
            IF NoTextIndex > ARRAYLEN(NoText) THEN
                ERROR(Text16529, AddText);
        END;

        NoText[NoTextIndex] := DELCHR(NoText[NoTextIndex] + ' ' + AddText, '<');
    end;

    procedure InitTextVariable()
    begin
        OnesText[1] := Text16532;
        OnesText[2] := Text16533;
        OnesText[3] := Text16534;
        OnesText[4] := Text16535;
        OnesText[5] := Text16536;
        OnesText[6] := Text16537;
        OnesText[7] := Text16538;
        OnesText[8] := Text16539;
        OnesText[9] := Text16540;
        OnesText[10] := Text16541;
        OnesText[11] := Text16542;
        OnesText[12] := Text16543;
        OnesText[13] := Text16544;
        OnesText[14] := Text16545;
        OnesText[15] := Text16546;
        OnesText[16] := Text16547;
        OnesText[17] := Text16548;
        OnesText[18] := Text16549;
        OnesText[19] := Text16550;

        TensText[1] := '';
        TensText[2] := Text16551;
        TensText[3] := Text16552;
        TensText[4] := Text16553;
        TensText[5] := Text16554;
        TensText[6] := Text16555;
        TensText[7] := Text16556;
        TensText[8] := Text16557;
        TensText[9] := Text16558;

        ExponentText[1] := '';
        ExponentText[2] := Text16559;
        ExponentText[3] := Text16560;
        ExponentText[4] := Text16561;
    end;



}
