report 50500 "Posted Purchase Invoice"
{
    ApplicationArea = All;
    Caption = 'Posted Purchase Invoice';

    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'Report\50100-Posted Purchase Invoice.rdl';
    DefaultLayout = RDLC;
    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            column(Compname; Comp.Name) { }
            column(Compadd; Comp.Address) { }
            column(Compaddd2; Comp."Address 2") { }
            column(Compcity; Comp.City) { }
            column(Comppic; Comp.picture) { }

            column(Buy_from_Vendor_Name; "Buy-from Vendor Name") { }
            column(Buy_from_Address; "Buy-from Address") { }
            column(Buy_from_Address_2; "Buy-from Address 2") { }
            column(Buy_from_City; "Buy-from City") { }
            column(Buy_from_County; "Buy-from County") { }
            column(Buy_from_Country_Region_Code; "Buy-from Country/Region Code") { }
            column(BuyFrom_GST; BuyFrom_GST) { }
            column(BuyFrom_PAN; BuyFrom_PAN) { }
            column(Ship_to_Name; "Ship-to Name") { }
            column(Ship_to_Address; "Ship-to Address") { }
            column(Ship_to_Address_2; "Ship-to Address 2") { }
            column(Ship_to_City; "Ship-to City") { }
            column(Ship_to_Code; "Ship-to Code") { }
            column(Ship_to_Country_Region_Code; "Ship-to Country/Region Code") { }
            column(Vendor_Invoice_No_; "Vendor Invoice No.") { }
            column(No_; "No.") { }
            column(Posting_Date; "Posting Date") { }
            column(Order_Date; "Order Date") { }
            column(Purchase_GST; Purchase_GST) { }
            column(Purchase_PAN; Purchase_PAN) { }
            column(BankAccNo; BankAccNo) { }
            column(BankAccountName; BankAccountName) { }
            column(IFSC_Code; IFSC_Code) { }
            column(CompGST; CompGST) { }
            column(compPAN; compPAN) { }
            column(IRN_NO; IRN_NO) { }
            column(Vendor_Order_No_; "Vendor Order No.") { }


            // column(Comp;Comp.ifsc Code){}




            dataitem(PurchaseLine; "Purchase Line")
            {
                column(No; "No.")
                {
                }
                column(Description; Description)
                {
                }
                column(HSNSACCode; "HSN/SAC Code")
                {
                }
                column(Quantity; Quantity)
                {
                }
                column(UnitPriceLCY; "Unit Price (LCY)")
                {
                }
                column(UnitofMeasure; "Unit of Measure")
                {
                }
                column(Discount; Discount)
                {
                }
                column(LineDiscount; "Line Discount %")
                {
                }
                column(Amount; Amount)
                {
                }
                column(SNo; SNo) { }
                column(GSTrate; GSTrate) { }
                column(CGSTAmount; CGSTAmount) { }
                column(CGSTRate; CGSTRate) { }
                column(IGSTAmount; IGSTAmount) { }
                column(IGSTRate; IGSTRate) { }
                column(SGSTRate; SGSTRate) { }
                column(SGSTAmount; SGSTAmount) { }
                // column(SGST; SGST) { }
                // column(SGSTPer; SGSTPer) { }
                // column(CGST; CGST) { }
                // column(CGSTPer; CGSTPer) { }
                // column(IGST; IGST) { }
                // column(IGSTPer; IGSTPer) { }
                // column(TotalAmount; TotalAmount) { }
                // column(GST_per; GST_per) { }
                // column(GstAmount; GstAmount) { }
                // column(ItemGSTRate; ItemGSTRate) { }
                column(Amountinwords; Amountinwords) { }
                column(Total_Amt; Total_Amt) { }
                column(AmountinwordsGST; AmountinwordsGST) { }
                column(GstAmount; GstAmount) { }
                column(Line_Discount__; "Line Discount %") { }
                column(GST_Group_Code; "GST Group Code") { }



                trigger OnPreDataItem()
                var
                    myInt: Integer;
                begin
                    CLEAR(SNo);
                end;

                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin
                    Sno += 1;
                    clear(GSTrate);
                    clear(CGSTAmount);
                    clear(CGSTRate);
                    clear(SGSTAmount);
                    Clear(SGSTRate);
                    clear(IGSTAmount);
                    Clear(IGSTRate);
                    PurchaseLine.Reset();
                    PurchaseLine.SetRange("Document No.", "No.");
                    if PurchaseLine.FindFirst() then begin
                        repeat
                            taxinformation.Reset();
                            taxinformation.SetFilter("Tax Record ID", '%1', PurchaseLine.RecordId);
                            taxinformation.SetFilter("Value Type", '1%', taxinformation."Value Type"::COMPONENT);
                            taxinformation.SetRange("Visible on Interface", true);
                            if taxinformation.FindFirst() then begin
                                repeat
                                    ComponentAmt := TaxTypeObjHelper.GetComponentAmountFrmTransValue(taxinformation);
                                    if taxinformation.GetAttributeColumName() = 'CGST' then begin
                                        CGSTAmount += ComponentAmt;
                                        CGSTRate := taxinformation.percent;

                                    end;
                                    if taxinformation.GetAttributeColumName() = 'SGST' then begin
                                        SGSTAmount += ComponentAmt;
                                        SGSTRate := taxinformation.percent;
                                    end;
                                    if taxinformation.GetAttributeColumName() = 'IGST' then begin
                                        IGSTAmount += ComponentAmt;
                                        IGSTRate := taxinformation.percent;
                                    end;

                                until taxinformation.Next() = 0;
                            end;
                        until PurchaseLine.Next() = 0;
                    end;
                    GSTrate := Abs("SGSTAmount" + "IGSTAmount" + "CGSTAmount");

                end;

            }

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                // Total_Amt := 0;
                // PurchaseLine.reset;
                // PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
                // PurchaseLine.CalcSums(Amount);
                // Total_Amt := PurchaseLine.Amount;
                // Clear(Amountinwords);
                // InitTextVariable();
                // TotalAmount := round(Amount, 0.01);
                // FormatNoText(Notext1, TotalAmount, "Purchase Header"."Currency Code");
                // Amountinwords := Notext1[1];




                // Clear(BankAccountName);
                // Clear(BankAccNo);
                // Clear(IFSC_Code);
                // Vendor_rec.Reset();
                // Vendor_rec.SetRange("No.", BankAccount."Bank Account No.");
                // if Vendor_rec.FindFirst() then begin
                //     BankAccNo := BankAccount."Bank Account No.";
                //     BankAccountName := BankAccount."Name";
                //     IFSC_Code := BankAccount."IFSC Code";

                // end;













                Vendor_rec.Reset();
                Vendor_rec.SetRange("No.", "Purchase Header"."Buy-from Vendor No.");
                if Vendor_rec.FindFirst() then begin
                    Purchase_PAN := Vendor_rec."P.A.N. No.";
                    Purchase_GST := Vendor_rec."GST Registration No.";
                    BankAccNo := BankAccount."Bank Account No.";
                    BankAccountName := BankAccount."Name";
                    IFSC_Code := BankAccount."IFSC Code";
                end;

                Total_Amt := 0;
                PurchaseLine.reset;
                PurchaseLine.SetRange("Document No.", "Purchase Header"."No.");
                PurchaseLine.CalcSums(Amount);
                Total_Amt := PurchaseLine.Amount;


                Clear(Amountinwords);
                InitTextVariable();
                TotalAmount := round(Amount, 0.01);
                FormatNoText(Notext1, Total_Amt, "Purchase Header"."Currency Code");
                Amountinwords := Notext1[1];

                // //TRIAL GST IN WORDS(TK)
                // Clear(AmountinwordsGST);
                // InitTextVariable();
                // GstAmount := round(GSTrate, 0.01);
                // FormatNoText(Notext1, GSTrate, "Purchase Header"."Currency Code");
                // AmountinwordsGST := Notext1[1];

                // Clear(AmountinwordsGST);
                // InitTextVariable();
                // TotalAmount := round(Amount, 0.01);
                // FormatNoText(Notext1, Total_Amt, "Purchase Header"."Currency Code");
                // AmountinwordsGST := Notext1[1];


                clear(AmountinwordsGST);
                InitTextVariable();
                GstAmount := Round(GSTrate, 0.01);
                FormatNoText(Notext1, GSTrate, "Purchase Header"."Currency Code");
                AmountinwordsGST := Notext1[1];





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
    var
        myInt: Integer;
    begin
        Comp.get();
        Comp.CalcFields(Picture);
        CompGST := Comp."GST Registration No.";
        compPAN := Comp."P.A.N. No.";
    end;

    var
        IRN_NO: Code[50];
        AmountinwordsGST: text;
        TaxTypeObjHelper: Codeunit "Tax Type Object Helper";
        ComponentAmt: Decimal;
        taxinformation: Record "Tax Transaction Value";
        LineGSTRate: Decimal;
        BankAccount: Record "Bank Account";
        BankAccountName: text;
        BankAccNo: code[100];
        IFSC_Code: code[100];
        Purchase_GST: code[100];
        compPAN: code[100];
        CompGST: code[100];
        Comp: Record "Company Information";
        BuyFrom_GST: code[100];
        BuyFrom_PAN: Code[100];
        // CGST: Decimal;
        // IGST: decimal;
        // SGST: Decimal;
        // CGSTPer: Decimal;
        Purchase_PAN: Code[100];
        // SGSTPer: Decimal;
        // IGSTPer: decimal;
        GSTrate: decimal;
        CGSTAmount: decimal;
        CGSTRate: decimal;
        SGSTAmount: decimal;
        SGSTRate: decimal;
        IGSTAmount: decimal;
        IGSTRate: decimal;


        Vendor_rec: Record "Vendor";
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";

        TRANSFERLINE: Record "Transfer Line";
        GstAmount: Decimal;
        ItemGSTRate: Decimal;
        TotalAmount: decimal;
        GST_per: Decimal;
        PurchaseHeader: record "Purchase Header";
        SNo: Decimal;
        Amountinwords: Text;
        Total_Amt: Decimal;
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
            AddToNoText(NoText, NoTextIndex, PrintExponent, 'RUPEES');

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
        ExponentText[3] := Text16562;
        ExponentText[4] := Text16563;
    end;





}
