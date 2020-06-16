DECLARE

    TYPE varchar_array IS VARRAY(1000) OF VARCHAR(200);
    holdingCodes varchar_array;
    userAdmin VARCHAR (50):= 'end.intesatest+admin@gmail.com';
BEGIN
    --CREATE BACKOFFICE USER
    INSERT INTO LC_MERCHANT_OBJ.T_USER (USERNAME, PASSWORD, FIRST_NAME, LAST_NAME, STATUS, EMAIL, USER_LEVEL, LANGUAGE, TERMS_AND_CONDITIONS)
    VALUES ( userAdmin ,'1c98decf10a5c1ce3737a5bdd84eec316775e6dc4c03bc6b4178c9e57c7b9e44710763940e31e4be',
             ' Admin first name' , 'Admin lastname','ENABLED','end.intesatest@gmail.com','L0','it_IT',1);
    INSERT INTO LC_MERCHANT_OBJ.T_SEC_USER_GROUP (USER_ID, GROUP_ID)
    VALUES ((SELECT ID FROM LC_MERCHANT_OBJ.T_USER WHERE username = userAdmin),1);

    SELECT DISTINCT(holding_code) BULK COLLECT INTO holdingCodes FROM LC_MERCHANT_OBJ.T_HOLDING;

    FOR i IN 1.. holdingCodes.COUNT LOOP
        INSERT INTO LC_MERCHANT_OBJ.T_USER_GRANT (user_id, code, code_type)
        VALUES ((SELECT ID FROM LC_MERCHANT_OBJ.T_USER WHERE username = userAdmin), holdingCodes(i), 'HOLDING');
    END LOOP;

    --DELETE BACKOFFICE USER
--    DELETE FROM LC_MERCHANT_OBJ.T_SEC_USER_GROUP WHERE USER_ID = (SELECT ID FROM LC_MERCHANT_OBJ.T_USER WHERE username = userAdmin);
--    DELETE FROM LC_MERCHANT_OBJ.T_USER_GRANT WHERE USER_ID = (SELECT ID FROM LC_MERCHANT_OBJ.T_USER WHERE username = userAdmin);
--    DELETE FROM LC_MERCHANT_OBJ.T_USER WHERE username = userAdmin;
END;




SELECT U.USERNAME, COUNT (DISTINCT S.SHOP_CODE) FROM LC_MERCHANT_OBJ.V_USER_SHOP S
                                                         INNER JOIN  LC_MERCHANT_OBJ.T_USER U
                                                                     ON S.USER_ID = U.ID
                                                         INNER JOIN LC_MERCHANT_OBJ.T_SEC_USER_GROUP G
                                                                    ON U.ID = G.USER_ID
WHERE G.GROUP_ID = 1
GROUP BY U.USERNAME;

SELECT COUNT(DISTINCT SHOP_CODE) FROM LC_MERCHANT_OBJ.T_SHOP;