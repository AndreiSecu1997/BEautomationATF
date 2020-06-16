DECLARE
    --
    transactionPerEachType INTEGER := 20;
    --
    TYPE varchar_array IS VARRAY(1000) OF VARCHAR(200);
    shopsCode varchar_array;
    terminalCode VARCHAR(2);
    merchantSiaCode VARCHAR(7);
    branchSiaCode VARCHAR(5);
    posNo VARCHAR(3);
    panNumber VARCHAR(19);
    transactionDate VARCHAR(20);
    transactionTime INTEGER;
    transactionDateTime TIMESTAMP;
    fiNumber VARCHAR(4);
    signValue NUMBER;
    transactionAmount NUMBER;
    transactionCurrency VARCHAR(3);
    rrnCode VARCHAR(12);
    authorizationCode VARCHAR(6);
    receiptCode VARCHAR(3);
    resultCode VARCHAR(3);
    terminalID VARCHAR(8);
    shortShopCode VARCHAR(7);
    shortPan VARCHAR(4);
    operationType VARCHAR(20);
    cardType VARCHAR(50);
    additionalData VARCHAR(104);
    posType VARCHAR(1);


    PROCEDURE getShopDetails (shopCode IN VARCHAR, merchantSiaCode OUT VARCHAR, branchSiaCode OUT VARCHAR, posType OUT VARCHAR )
    AS
        temp VARCHAR(2);
    BEGIN
        SELECT  MERCHANT_SIA_CODE, BRANCH_SIA_CODE, POS_TYPE
        INTO  merchantSiaCode, branchSiaCode, temp
        FROM IB_TEST2_MERCHANT_OBJ.T_SHOP
        WHERE SHOP_CODE = shopCode  AND ROWNUM = 1;
        IF temp IN ('02','15') THEN posType := 'V'; ELSE posType := 'F'; END IF;
        IF merchantSiaCode is null THEN merchantSiaCode := 'MSC'; END IF;
        IF branchSiaCode is null THEN branchSiaCode := 'BSC'; END IF;
    END;
    FUNCTION generateRandomInteger (integerLength IN INTEGER) return INTEGER
    AS
        return_var INT;
    BEGIN
        SELECT CAST(RPAD(SUBSTR(ROUND(DBMS_RANDOM.value(1,1000000000)),1,integerLength),integerLength,0)as NUMBER)
        INTO return_var
        FROM dual ;
        RETURN return_var;
    END;
    FUNCTION generateRandomString (stringLength IN INTEGER) return VARCHAR
    AS
        val VARCHAR(50);
    BEGIN
        val := DBMS_RANDOM.STRING('U',stringLength);
        RETURN     val;
    END;
    FUNCTION generatePan return VARCHAR
    AS
        val INTEGER;
    BEGIN
        val := ROUND(DBMS_RANDOM.VALUE(1, 3));
        IF  val = 1 THEN RETURN  ROUND(DBMS_RANDOM.VALUE(100000, 999999)) || '******'    || ROUND(DBMS_RANDOM.VALUE(1000, 9999));  END IF;
        IF  val = 2 THEN RETURN  ROUND(DBMS_RANDOM.VALUE(100000, 999999)) || '*********' || ROUND(DBMS_RANDOM.VALUE(1000, 9999));  END IF;
        IF  val = 3 THEN RETURN  ROUND(DBMS_RANDOM.VALUE(10000, 99999))   || '*********' || ROUND(DBMS_RANDOM.VALUE(1000, 9999));  END IF;
    END;
    PROCEDURE getRandomDateAndTime (trnDateTime OUT TIMESTAMP, trnDate OUT VARCHAR, trnTime OUT INTEGER)
    AS
        day_part INTEGER;
        month_part INTEGER;
        this_month_num NUMBER:= TO_NUMBER(EXTRACT(MONTH FROM CURRENT_DATE));
        max_day_this_month NUMBER := TO_NUMBER(EXTRACT(DAY FROM CURRENT_DATE - 1));
        prev_month_num NUMBER := TO_NUMBER(EXTRACT(MONTH FROM (ADD_MONTHS(CURRENT_DATE, -1))));
        max_day_prev_month NUMBER := TO_NUMBER(EXTRACT(DAY FROM LAST_DAY(ADD_MONTHS(CURRENT_DATE, -1))));
        year_part INTEGER := TO_NUMBER(EXTRACT(YEAR FROM CURRENT_DATE));
        trnSec INTEGER;
        trnMin INTEGER;
        trnHour INTEGER;
        trn1H INTEGER;
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
        trnTime    := trnHour || trnMin || trnSec;
        trnDateTime := TO_TIMESTAMP(trnDate || ' ' || trnHour || ':' || trnMin || ':' || trnSec || '.000000000', 'dd/mm/yy HH24:MI:SS.FF');
    END;
    PROCEDURE getCardTypeAndFI (fi OUT VARCHAR, cardType OUT VARCHAR)
    AS
    BEGIN
        SELECT FI_NUMBER, DESCRIPTION
        INTO fi, cardType
        FROM (SELECT FI_NUMBER,DESCRIPTION  FROM IB_TEST2_TRANSACTION_OBJ.T_AUTHORIZED_FI_NUMBER JOIN IB_TEST2_TRANSACTION_OBJ.T_CARD_TYPE
            ON T_AUTHORIZED_FI_NUMBER.CARD_TYPE_ID =  T_CARD_TYPE.CARD_TYPE_ID ORDER BY DBMS_RANDOM.VALUE)
        WHERE ROWNUM = 1;
    END;
    PROCEDURE generateAmountAndOperationType (signValue OUT NUMBER, transactionAmount OUT VARCHAR, transactionCurrency OUT VARCHAR, operationType OUT VARCHAR)
    AS
        TYPE currency IS VARRAY(1000) OF VARCHAR(200);
        transactionCurrency_lists currency:= currency('978', '826', '840', '756', '752', '643', '784', '682', '36', '392', '124');
    BEGIN
        transactionAmount := ROUND(DBMS_RANDOM.VALUE(-650.50,1200.99),2);
        IF transactionAmount = 0 THEN transactionAmount := 100.01; END IF;

        transactionCurrency := transactionCurrency_lists(DBMS_RANDOM.VALUE(1, transactionCurrency_lists.COUNT));
        IF transactionCurrency = '048'  THEN transactionAmount := ROUND(DBMS_RANDOM.VALUE(-650.501,1200.999),3); END IF;
        IF transactionCurrency = '108'  THEN transactionAmount := ROUND(DBMS_RANDOM.VALUE(-650.50,1200.99),0); END IF;
        IF transactionCurrency = '990'  THEN transactionAmount := ROUND(DBMS_RANDOM.VALUE(-650.5001,1200.9999),4); END IF;

        IF  transactionAmount < 0 THEN signValue := -1 ; ELSE signValue :=  1 ; END IF;
        IF  transactionAmount < 0 THEN  operationType := '04' ; ELSE  operationType := '01' ; END IF;
    END;

BEGIN
    SELECT shop_code BULK COLLECT INTO shopsCode FROM IB_TEST2_MERCHANT_OBJ.T_SHOP
    WHERE NAME IN ('Bologna 1','Bologna 2','Pisa 1','Pisa 2','Pisa 3','Pisa 4','Pisa 5','Pisa 6','Pisa 7','Pisa 8','Pisa 9','Pisa 10','Pisa 11',
                   'Florence 1','Florence 2','Florence 3','Malmo 1','Malmo 2','Hansa 1','Hansa 2','Stokholm 1','Stokholm 2','Malaga 1','Malaga 2',
                   'Murcia 1','Murcia 2','Seville 1','Seville 2','Montreal 1','Montreal 2','Montreal 3','Montreal 4','Montreal 5','Montreal 6',
                   'Montreal 7','Montreal 8','Montreal 9','Montreal 10','Montreal 11','Toronto 1','Toronto 2','Quebec 1','Quebec 2','Quebec 3',
                   'Osaka 1','Osaka 2','Tokyo 1','Tokyo 2','Kobe 1','Kobe 2','Rotterdam 1','Rotterdam 2','Amsterdam 1','Amsterdam 2','Haarlem 1',
                   'Haarlem 2','Haarlem 3','Haarlem 4');

    FOR k in 1.. transactionPereachType LOOP

        FOR i IN 1.. shopsCode.COUNT LOOP

            getShopDetails(shopsCode(i), merchantSiaCode, branchSiaCode, posType );
            getRandomDateAndTime(transactionDateTime, transactionDate, transactionTime);
            generateAmountAndOperationType(signValue, transactionAmount, transactionCurrency, operationType );
            getCardTypeAndFI(fiNumber, cardType);

            terminalCode      := generateRandomInteger(2);
            posNo             := generateRandomInteger(3);
            panNumber         := generatePan();
            rrnCode           := generateRandomInteger(12);
            receiptCode       := null;
            authorizationCode := generateRandomInteger(6);
            resultCode        := generateRandomString(3);
            terminalID        := generateRandomInteger(8);
            shortShopCode     := SUBSTR(shopsCode(i),2,7);
            shortPan          := SUBSTR(panNumber, LENGTH(panNumber) - 3, 4);
            additionalData    := null;

            INSERT INTO IB_TEST2_TRANSACTION_OBJ.T_AUTHORIZED_TRANSACTION (MESSAGE_TYPE,SHOP_CODE,TERMINAL_CODE,MERCHANT_SIA_CODE,BRANCH_SIA_CODE,POS_NO,PAN,
                                                                           TRANSACTION_DATE,TRANSACTION_TIME,TRANSACTION_DATETIME,FI_NUMBER,SIGN,TRANSACTION_AMOUNT,
                                                                           TRANSACTION_CURRENCY,RRN,RECEIPT,AUTHORIZATION_CODE,RESULT_CODE,TERMINAL_ID,
                                                                           SHORT_SHOP_CODE,SHORT_PAN,OPERATION_TYPE,CARD_BRAND,ADDITIONAL_DATA,POS_TYPE)

            VALUES ('MAP', shopsCode(i), terminalCode, merchantSiaCode, branchSiaCode, posNo, panNumber, TO_DATE(transactionDate,'DD/MM/YYYY'),
                    transactionTime, transactionDateTime,fiNumber, signValue, transactionAmount, transactionCurrency, rrnCode, receiptCode, authorizationCode,
                    resultCode, terminalID, shortShopCode, shortPan, operationType, cardType, additionalData, posType  );
        END LOOP;


        FOR n IN 1.. shopsCode.COUNT LOOP

            getShopDetails(shopsCode(n), merchantSiaCode, branchSiaCode, posType );
            generateAmountAndOperationType(signValue, transactionAmount, transactionCurrency, operationType );
            getRandomDateAndTime(transactionDateTime, transactionDate, transactionTime);
            getCardTypeAndFI(fiNumber, cardType);

            transactionCurrency := '978';
            terminalCode        := null;
            rrnCode             := '000000000000';
            receiptCode         := generateRandomInteger(3);
            posNo               := generateRandomInteger(3);
            panNumber           := generatePan();
            authorizationCode   := generateRandomInteger(6);
            resultCode          := null;
            terminalID          := generateRandomInteger(8);
            shortShopCode       := SUBSTR(shopsCode(n),2,7);
            shortPan            := SUBSTR(panNumber, LENGTH(panNumber) - 3, 4);
            additionalData      := null;

            INSERT INTO IB_TEST2_TRANSACTION_OBJ.T_AUTHORIZED_TRANSACTION (MESSAGE_TYPE,SHOP_CODE,TERMINAL_CODE,MERCHANT_SIA_CODE,BRANCH_SIA_CODE,POS_NO,PAN,
                                                                           TRANSACTION_DATE,TRANSACTION_TIME,TRANSACTION_DATETIME,FI_NUMBER,SIGN,TRANSACTION_AMOUNT,
                                                                           TRANSACTION_CURRENCY,RRN,RECEIPT,AUTHORIZATION_CODE,RESULT_CODE,TERMINAL_ID,
                                                                           SHORT_SHOP_CODE,SHORT_PAN,OPERATION_TYPE,CARD_BRAND,ADDITIONAL_DATA,POS_TYPE)

            VALUES ('PNZ', shopsCode(n), terminalCode, merchantSiaCode, branchSiaCode, posNo, panNumber, TO_DATE(transactionDate,'DD/MM/YYYY'), transactionTime,
                    transactionDateTime,fiNumber, signValue, transactionAmount, transactionCurrency, rrnCode, receiptCode, authorizationCode, resultCode,
                    terminalID, shortShopCode,shortPan, operationType, cardType, additionalData, posType  );
        END LOOP;
    END LOOP;


END;
--DELETE FROM IB_TEST2_TRANSACTION_OBJ.T_AUTHORIZED_TRANSACTION WHERE SHOP_CODE BETWEEN 113000010 AND 113000580;
