DECLARE

    --number of transactions per day for 1 shop
    trnPerShop INTEGER := 20;
    --

    shopQuantity INTEGER;
    TYPE varchar_array IS VARRAY(1000) OF VARCHAR(200);
    TYPE INTEGER_ARRAY IS VARRAY(1000) OF INTEGER;
    TYPE number_array IS VARRAY(1000) OF NUMBER(38,2);
    integerList INTEGER_ARRAY;
    varcharList varchar_array;
    numberList number_array;

    trnCode VARCHAR(19);
    shopsCode varchar_array;
    trnDateTime TIMESTAMP;
    trnDate VARCHAR(10);
    trnWeek NUMBER(6,0);
    transactionAmount NUMBER(19,2);
    transactionCurrency VARCHAR2(3);
    accountAmount NUMBER(19,2);
    operationType VARCHAR(2);
    panNumber VARCHAR2(19);
    authorisationCode VARCHAR2(10);
    posType VARCHAR2(2);
    accountDate DATE;
    posNo VARCHAR2(5);
    commissionAmount NUMBER(19,2);
    liquidDate DATE;
    valueDate DATE;
    additionalData VARCHAR2(89);
    interchangeFee NUMBER(19,2);
    areaCode VARCHAR2(9);
    companyCode VARCHAR2(10);
    holdingCode VARCHAR2(10);
    cardType VARCHAR2(2);
    cardNature VARCHAR2(2);
    transactionRef VARCHAR2(32);
    shortPan VARCHAR2(4);
    exchangeRate NUMBER(20,7);
    trnHour NUMBER(2,0);
    trnMin NUMBER(2,0);
    trnTime VARCHAR(4);
    accountCurrency VARCHAR2(3);
    commissionAccounting VARCHAR2(1);
    cardBrand VARCHAR2(100);

    PROCEDURE getVarcharLists (firstIndex IN INTEGER, lastIndex IN INTEGER, varcharList OUT varchar_array )
    AS
        counter INTEGER := firstIndex;
    BEGIN
        varcharList := varchar_array();
        varcharList.EXTEND(lastIndex - firstIndex + 1);
        FOR i IN 1 .. varcharList.COUNT  LOOP
            varcharList(i) := counter;
            counter := counter + 1;
        END LOOP;
    END;
    FUNCTION getTransactionIdSeq return INTEGER
    AS
    BEGIN
        return  IB_TEST2_TRANSACTION_OBJ.T_TRANSACTION_ID_SEQ.NEXTVAL;

    END;
    FUNCTION getWeekNumber (trnDate IN VARCHAR)return INTEGER
    AS
    BEGIN
        return  IB_TEST2_TRANSACTION_OBJ.GET_WEEK(TO_DATE(trnDate, 'dd/mm/yy'));

    END;
    PROCEDURE getShopDetails (shop_id IN VARCHAR,areaCode OUT VARCHAR, companyCode OUT VARCHAR, holdingCode OUT VARCHAR, posType OUT VARCHAR, posNo OUT NUMBER,
                              currency OUT VARCHAR, commissionAccounting OUT VARCHAR )
    AS
    BEGIN
        SELECT  AREA_CODE, COMPANY_CODE, HOLDING_CODE, POS_TYPE, POSNO, CURRENCIES, COMMISSION_ACCOUNTING
        INTO  areaCode, companyCode, holdingCode, posType, posNo, currency, commissionAccounting
        FROM IB_TEST2_MERCHANT_OBJ.T_SHOP
        WHERE SHOP_CODE = shop_id AND ROWNUM = 1;
        IF posType IN ('02','15') THEN posType := 'V'; ELSE posType := 'F'; END IF;
    END;
    PROCEDURE getRandomDateAndTime (trnDateTime OUT TIMESTAMP, trnDate OUT VARCHAR, trnHour OUT INTEGER, trnMin OUT INTEGER)
    AS
        day_part INTEGER;
        month_part INTEGER;
        this_month_num NUMBER:= TO_NUMBER(EXTRACT(MONTH FROM CURRENT_DATE));
        max_day_this_month NUMBER := TO_NUMBER(EXTRACT(DAY FROM CURRENT_DATE - 1));
        prev_month_num NUMBER := TO_NUMBER(EXTRACT(MONTH FROM (ADD_MONTHS(CURRENT_DATE, -1))));
        max_day_prev_month NUMBER := TO_NUMBER(EXTRACT(DAY FROM LAST_DAY(ADD_MONTHS(CURRENT_DATE, -1))));
        year_part INTEGER := TO_NUMBER(EXTRACT(YEAR FROM CURRENT_DATE));
        trnSec INTEGER;
        trn1H INTEGER;
        trn2H INTEGER;
    BEGIN
        month_part := DBMS_RANDOM.VALUE(prev_month_num, this_month_num);

        CASE month_part
            WHEN this_month_num THEN day_part := DBMS_RANDOM.VALUE(1, max_day_this_month);
            WHEN prev_month_num THEN day_part := DBMS_RANDOM.VALUE(1, max_day_prev_month);
            ELSE month_part := 0;
            END CASE;
        trnSec     := ROUND(DBMS_RANDOM.VALUE(10, 59));
        trnMin     := ROUND(DBMS_RANDOM.VALUE(10, 59));
        trn1H      := ROUND(DBMS_RANDOM.VALUE(0, 23));
        trnHour    := TO_CHAR(trn1H);
        trnDate    := TO_CHAR(day_part) || '/' || TO_CHAR(month_part) || '/' || TO_CHAR(year_part);

        trnDateTime := TO_TIMESTAMP(trnDate || ' ' || trnHour || ':' || trnMin || ':' || trnSec || '.000000000', 'dd/mm/yy HH24:MI:SS.FF');
    END;
    FUNCTION generateTransactionAmount return  NUMBER
    AS
    BEGIN
        transactionAmount := ROUND(DBMS_RANDOM.VALUE(-350.50,1200.99),2);
        IF transactionAmount = 0 THEN transactionAmount := 100.01; END IF;
        return transactionAmount;
    END;
    PROCEDURE generateAmounts (transactionAmount IN NUMBER, accountAmount OUT NUMBER, interchangeFee OUT NUMBER,commissionAmount OUT NUMBER,
                               transactionCurrency OUT VARCHAR,exchangeRate OUT NUMBER)
    AS
        TYPE currency IS VARRAY(1000) OF VARCHAR(200);
        transactionCurrency_lists currency:= currency('978', '826', '840', '756', '752', '643', '784', '682', '36', '392', '124');
    BEGIN
        IF
                transactionAmount < 0 THEN commissionAmount := ABS(ROUND(transactionAmount / 200,2));
        ELSE commissionAmount := ROUND(transactionAmount / 200,2);
        END IF;

        transactionCurrency := transactionCurrency_lists(DBMS_RANDOM.VALUE(1, transactionCurrency_lists.COUNT));
        CASE transactionCurrency
            WHEN '840' THEN interchangeFee := 1.12;
            WHEN '124' THEN interchangeFee := 1.47;
            WHEN '826' THEN interchangeFee := 0.90;
            WHEN '978' THEN interchangeFee := 1;
            WHEN '756' THEN interchangeFee := 1.11;
            WHEN '752' THEN interchangeFee := 1.22;
            WHEN '643' THEN interchangeFee := 1.33;
            WHEN '784' THEN interchangeFee := 1.44;
            WHEN '682' THEN interchangeFee := 1.55;
            WHEN '36' THEN interchangeFee := 1.66;
            WHEN '392' THEN interchangeFee := 1.77;
            END CASE;

        exchangeRate  := ROUND((interchangeFee / 300),7);

        accountAmount := ROUND(transactionAmount * exchangeRate, 2) + (transactionAmount * 2) ;

    END;
    FUNCTION generateOperationType (transactionAmount IN NUMBER, commissionAccounting IN VARCHAR, trn_date IN VARCHAR) return VARCHAR
    AS
        TYPE operation IS VARRAY(100) OF VARCHAR(50);
        operation_pozitive_list operation := operation('01','08','10','12','10','52','01','91','01','10');
        operation_negative_list operation := operation('02','04','09','11','53','54','55','90');
        operation_commisioneL_list operation := operation('50','51','56');
        last_date DATE;
    BEGIN
        last_date := LAST_DAY(TO_DATE(trn_date, 'DD/MM/YYYY'));
        IF transactionAmount >= 0 THEN  operationType := operation_pozitive_list(DBMS_RANDOM.VALUE(1, operation_pozitive_list.COUNT)); END IF;
        IF transactionAmount < 0  THEN  operationType := operation_negative_list(DBMS_RANDOM.VALUE(1, operation_negative_list.COUNT)); END IF;

        IF TO_DATE(trn_date, 'DD/MM/YYYY') = last_date AND commissionAccounting = 'L' AND transactionAmount > 0
        THEN operationType := operation_commisioneL_list(DBMS_RANDOM.VALUE(1, operation_commisioneL_list.COUNT)); END IF;
        return operationType;
    END;
    FUNCTION generatePanCard return VARCHAR
    AS
        val INTEGER;
    BEGIN
        val := ROUND(DBMS_RANDOM.VALUE(1, 3));
        IF  val = 1 THEN RETURN  ROUND(DBMS_RANDOM.VALUE(100000, 999999)) || '******'    || ROUND(DBMS_RANDOM.VALUE(1000, 9999));  END IF;
        IF  val = 2 THEN RETURN  ROUND(DBMS_RANDOM.VALUE(100000, 999999)) || '*********' || ROUND(DBMS_RANDOM.VALUE(1000, 9999));  END IF;
        IF  val = 3 THEN RETURN  ROUND(DBMS_RANDOM.VALUE(10000, 99999))     || '*********' || ROUND(DBMS_RANDOM.VALUE(1000, 9999));  END IF;
    END;
    FUNCTION getAuthorisationCode return INTEGER
    AS
    BEGIN
        return  IB_TEST2_TRANSACTION_OBJ.T_TRANSACTION_ID_SEQ.NEXTVAL;

    END;
    PROCEDURE generateDate (ACCOUNT_DATE OUT DATE, LIQUID_DATE OUT DATE, VALUE_DATE OUT DATE, TRANSACTION_DATE IN VARCHAR)
    AS
    BEGIN
        ACCOUNT_DATE := TO_DATE(TRANSACTION_DATE,'DD/MM/YYYY' ) - 1;
        LIQUID_DATE := TO_DATE(TRANSACTION_DATE, 'DD/MM/YYYY') + 1;
        VALUE_DATE := TO_DATE(TRANSACTION_DATE, 'DD/MM/YYYY') + 2;
    END;
    FUNCTION getCardType return VARCHAR
    AS
        TYPE lists IS VARRAY(1000) OF VARCHAR(200);
        cardsType lists := lists('01', '02','03','04','05','44','51','71','92','99','B','C2','D4','E6','M1','M3','M4','M5','V1','V3','V4','V5');
    BEGIN
        return cardsType(DBMS_RANDOM.VALUE(1, cardsType.COUNT));
    END;

BEGIN

    -- HERE WE CAN SET TO COUNT SPECIFIC SHOPS TO INSERT TRANSACTIONS
    SELECT shop_code BULK COLLECT INTO shopsCode FROM IB_TEST2_MERCHANT_OBJ.T_SHOP
    WHERE NAME IN('Bologna 1','Bologna 2','Pisa 1','Pisa 2','Pisa 3','Pisa 4','Pisa 5','Pisa 6','Pisa 7','Pisa 8','Pisa 9','Pisa 10','Pisa 11','Florence 1',
                  'Florence 2','Florence 3','Malmo 1','Malmo 2','Hansa 1','Hansa 2','Stokholm 1','Stokholm 2','Malaga 1','Malaga 2','Murcia 1','Murcia 2',
                  'Seville 1','Seville 2','Montreal 1','Montreal 2','Montreal 3','Montreal 4','Montreal 5', 'Montreal 6','Montreal 7','Montreal 8',
                  'Montreal 9','Montreal 10','Montreal 11','Toronto 1','Toronto 2','Quebec 1','Quebec 2','Quebec 3','Osaka 1','Osaka 2','Tokyo 1','Tokyo 2',
                  'Kobe 1','Kobe 2','Rotterdam 1','Rotterdam 2','Amsterdam 1','Amsterdam 2','Haarlem 1','Haarlem 2','Haarlem 3','Haarlem 4');

    FOR i IN 1.. shopsCode.COUNT LOOP

        getShopDetails(shopsCode(i), areaCode, companyCode, holdingCode, posType, posNo, accountCurrency, commissionAccounting);

        FOR k IN 1.. trnPerShop LOOP


            trnCode := getTransactionIdSeq();
            getRandomDateAndTime(trnDateTime, trnDate, trnHour, trnMin );
            trnWeek := getWeekNumber(trnDate);
            transactionAmount := generateTransactionAmount();
            generateAmounts(transactionAmount, accountAmount, interchangeFee, commissionAmount, transactionCurrency, exchangeRate);
            operationType := generateOperationType(transactionAmount, commissionAccounting, trnDate);
            panNumber := generatePanCard();
            shortPan := SUBSTR(panNumber, LENGTH(panNumber) - 3, 4);

            authorisationCode := getAuthorisationCode();
            generateDate(accountDate, liquidDate, valueDate, trnDate);
            additionalData := null;
            cardType := getCardType();
            cardNature := cardType;
            transactionRef := null;
            trnTime  := trnHour || trnMin;
            SELECT card_type into cardBrand FROM IB_TEST2_TRANSACTION_OBJ.T_CARD_TYPE WHERE CARD_TYPE_ID = cardtype;

            INSERT INTO IB_TEST2_TRANSACTION_OBJ.T_TRANSACTION
            (TRANSACTION_CODE,SHOP_CODE,TRANSACTION_DATETIME,TRANSACTION_DATE,TRANSACTION_WEEK,TRANSACTION_AMOUNT,TRANSACTION_CURRENCY,ACCOUNT_AMOUNT,
             OPERATION_TYPE,PAN,AUTHORIZATION_CODE,POS_TYPE,ACCOUNT_DATE,POS_NO,COMMISSION_AMOUNT,LIQUID_DATE,VALUE_DATE,ADDITIONAL_DATA,INTERCHANGE_FEE,
             AREA_CODE,COMPANY_CODE,HOLDING_CODE,CARD_TYPE,  --INSERT_DATETIME,MODIFY_DATETIME,
             CARD_NATURE,TRANSACTION_REF,SHORT_PAN,EXCHANGE_RATE,TRANSACTION_TIME,ACCOUNT_CURRENCY, CARD_BRAND)
            VALUES
            (trnCode,
             shopsCode(i),
             trnDateTime,
             TO_DATE(trnDate,'DD/MM/YYYY'),
             trnWeek,
             transactionAmount,
             transactionCurrency,
             accountAmount,
             operationType,
             panNumber,
             authorisationCode,
             posType,
             accountDate,
             posNo,
             commissionAmount,
             liquidDate,
             valueDate,
             additionalData,
             interchangeFee,
             areaCode,
             companyCode,
             holdingCode,
             cardType,
                --INSERT_DATETIME,
                --MODIFY_DATETIME,
             cardNature,
             transactionRef,
             shortPan,
             exchangeRate,
             trnTime,
             accountCurrency,
             cardBrand);

        END LOOP;
    END LOOP;
END ;

--DELETE FROM IB_TEST2_TRANSACTION_OBJ.T_TRANSACTION WHERE SHOP_CODE BETWEEN 113000010 AND 113000580;