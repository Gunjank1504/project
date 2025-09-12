report 50021 function_report
{
    ApplicationArea = All;
    Caption = 'function_report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'function_report.rdl';
    dataset
    {
        dataitem(SalesHeader; "Sales Header")
        {
            column(compname; comp.Name)
            {

            }
            column(compadd; comp.Address)
            {

            }
            column(compadd2; comp."Address 2")
            {

            }
            column(compcity; comp.City)
            {

            }
            column(compsc; comp."State Code")
            {

            }
            column(comppc; comp."Post Code")
            {

            }
            column(compregion; comp."Country/Region Code")
            {

            }
            column(compgst; comp."GST Registration No.")
            {

            }
            column(compmail; comp."E-Mail")
            {

            }
            column(cname; cname)
            {

            }
            column(cadd; cadd)
            {

            }
            column(cadd2; cadd2)
            {

            }
            column(loc_name; loc_name)
            {

            }
            column(loc_add; loc_add)
            {

            }
            column(loc_add2; loc_add2)
            {

            }
            column(loc_city; loc_city)
            {

            }
            column(locsc; locsc)
            {

            }
            column(loc_regioncode; loc_regioncode)
            {

            }
            column(locpc; locpc)
            {

            }
            column(loc_contact; loc_contact)
            {

            }
            column(loc_ph; loc_ph)
            {

            }
            column(loc_email; loc_email)
            {

            }
            column(locgst; locgst)
            {

            }
            column(loctan; loctan)
            {

            }
            column(loc_tcn; loc_tcn)
            {

            }
            column(loc_fax; loc_fax)
            {

            }
            dataitem("Sales Line"; "Sales Line")
            {
                column(I_loc_name; I_loc_name)
                {

                }
                column(I_loc_add; I_loc_add)
                {
                }

                column(I_loc_add2; I_loc_add2)
                {

                }
                column(I_loc_city; I_loc_city)
                {

                }
                column(I_locsc; I_locsc)
                {

                }
                column(I_loc_regioncode; I_loc_regioncode)
                {

                }
                column(I_locpc; I_locpc)
                {

                }
                column(I_loc_contact; I_loc_contact)
                {

                }
                column(I_loc_ph; I_loc_ph)
                {

                }
                column(I_loc_email; I_loc_email)
                {

                }
                column(I_locgst; I_locgst)
                {

                }
                column(I_loctan; I_loctan)
                {

                }
                column(I_loc_tcn; I_loc_tcn)
                {

                }
                column(I_loc_fax; I_loc_fax)
                {

                }
                column(No_; "No.")
                {

                }
                column(Description; Description)
                {

                }
                column(Quantity; Quantity)
                {

                }
                column(Unit_of_Measure_Code; "Unit of Measure Code")
                {

                }
                column(Unit_Price; "Unit Price")
                {

                }
                column(Line_Amount; "Line Amount")
                {

                }
                column(Amount;Amount)
                {

                }
                column(Amountinwords; Amountinwords)
                {

                }
                column(CGSTAmt; CGSTAmt)
                {

                }
                column(IGSTAmt; IGSTAmt)
                {

                }
                column(SGSTAmt; SGSTAmt)
                {

                }
                column(GSTAmt; GSTAmt)
                {

                }
                column(total;total)
                {
                    
                }
                trigger OnAfterGetRecord()
                begin
                    loc.Reset();
                    loc.SetRange(Code, "Sales Line"."Location Code");
                    if loc.FindFirst() then begin
                        I_loc_name := loc.Name;
                        I_loc_add := loc.Address;
                        I_loc_add2 := loc."Address 2";
                        I_locgst := loc."GST Registration No.";
                        I_loctan := loc."T.A.N. No.";
                        I_locsc := loc."State Code";
                        I_loc_city := loc.City;
                        I_locpc := loc."Post Code";
                        I_loc_regioncode := loc."Country/Region Code";
                        I_loc_email := loc."E-Mail";
                        I_loc_contact := loc.Contact;
                        I_loc_ph := loc."Phone No.";
                        I_loc_tcn := loc."T.C.A.N. No.";
                        I_loc_fax := loc."Fax No.";
                    end;

                     Amount := Quantity * "Unit Price";
                     total:= Amount + GSTAmt;

                    clear(GSTrate);
                    clear(CGSTAmt);
                    clear(CGSTRate);
                    clear(SGSTAmt);
                    Clear(SGSTRate);
                    clear(IGSTAmt);
                    Clear(IGSTRate);
                    "Sales Line".Reset();
                    "Sales Line".SetRange("Document No.", "No.");
                    if "Sales Line".FindFirst() then begin
                        repeat
                            taxinformation.Reset();
                            taxinformation.SetFilter("Tax Record ID", '%1', "Sales Line".RecordId);
                            taxinformation.SetFilter("Value Type", '1%', taxinformation."Value Type"::COMPONENT);
                            taxinformation.SetRange("Visible on Interface", true);
                            if taxinformation.FindFirst() then begin
                                repeat
                                    ComponentAmt := TaxTypeObjHelper.GetComponentAmountFrmTransValue(taxinformation);
                                    if taxinformation.GetAttributeColumName() = 'CGST' then begin
                                        CGSTAmt += taxinformation.Amount;
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
                        until "Sales Line".Next() = 0;
                    end;
                    GSTrate := Abs(SGSTRate + IGSTRate + CGSTRate);
                    GSTAmt := Abs(SGSTAmt + IGSTAmt + CGSTAmt);

                    Clear(Amountinwords);
                    InitTextVariable();
                    Amount := round(Amount, 0.01);
                    FormatNoText(Notext1, Amount, "Sales Line"."Currency Code");
                    Amountinwords := Notext1[1];


                end;
            }
            trigger OnAfterGetRecord()
            begin
                cust.Reset();
                cust.SetRange("No.", SalesHeader."Sell-to Customer No.");
                if cust.FindFirst() then begin
                    cname := cust.Name;
                    cadd := cust.Address;
                    cadd2 := cust."Address 2";
                end;
                loc.Reset();
                loc.SetRange(Code, SalesHeader."Location Code");
                if loc.FindFirst() then begin
                    loc_name := loc.Name;
                    loc_add := loc.Address;
                    loc_add2 := loc."Address 2";
                    locsc := loc."State Code";
                    locgst := loc."GST Registration No.";
                    loctan := loc."T.A.N. No.";
                    loc_city := loc.City;
                    locpc := loc."Post Code";
                    loc_regioncode := loc."Country/Region Code";
                    loc_email := loc."E-Mail";
                    loc_ph := loc."Phone No.";
                    loc_contact := loc.Contact;
                    loc_tcn := loc."T.C.A.N. No.";
                    loc_fax := loc."Fax No.";
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
        comp.CalcFields(Picture);
    end;

    var
        comp: Record "Company Information";
        cust: Record Customer;
        cname: Text[50];
        total: Decimal;
        totalwGST: Decimal;
        cadd: Text[50];
        cadd2: Text[50];
        loc: Record Location;
        loc_name: Text[20];
        loc_add: Text[50];
        loc_add2: Text[50];
        locgst: Text[20];
        loctan: Text[20];
        locsc: Text[20];
        loc_city: Text[20];
        locpc: Text[20];
        loc_regioncode: Text[20];
        loc_email: Text[20];
        loc_contact: Text[20];
        loc_ph: Text[20];
        loc_tcn: Text[20];
        loc_fax: Text[20];

        I_loc_name: Text[20];
        I_loc_add: Text[50];
        I_loc_add2: Text[50];
        I_locgst: Text[20];
        I_loctan: Text[20];
        I_locsc: Text[20];
        I_loc_city: Text[20];
        I_locpc: Text[20];
        I_loc_regioncode: Text[20];
        I_loc_email: Text[20];
        I_loc_contact: Text[20];
        I_loc_ph: Text[20];
        I_loc_tcn: Text[20];
        I_loc_fax: Text[20];


        custgst: Text[50];
        SerialNo: Integer;
        Amount: Decimal;
        sales_person: Text;
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
