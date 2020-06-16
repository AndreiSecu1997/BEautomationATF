ALTER SESSION SET CURRENT_SCHEMA = IB_TEST2_MERCHANT_OBJ;
/
SET SERVEROUTPUT ON;
/
DECLARE
    TYPE type_list is VARRAY(1000) OF VARCHAR2(100);
    user_id_list type_list;
    shop_id_list type_list;
    user_name VARCHAR2(255);
    shop_code_v VARCHAR2(255);
    holding_id VARCHAR2(9);
    subgroup_id VARCHAR2(10);
    gr_id VARCHAR2(10);
    us_level VARCHAR2(10);
    shop_name VARCHAR2(255);

BEGIN
    SELECT DISTINCT USER_ID BULK COLLECT INTO user_id_list FROM V_USER_SHOP
    WHERE USER_ID IS NOT NULL;

    FOR i in 1 .. user_id_list.count LOOP
        DBMS_OUTPUT.PUT_LINE('-----------------------------------------------------------------------------------');
        SELECT USERNAME INTO user_name FROM T_USER WHERE T_USER.ID = user_id_list(i);
        SELECT user_level INTO us_level FROM T_USER WHERE T_USER.ID = user_id_list(i);
        DBMS_OUTPUT.PUT_LINE('ID  ' || user_id_list(i) || '     USERNAME ' || user_name || '  user level: ' || us_level);

        SELECT DISTINCT SHOP_ID BULK COLLECT INTO shop_id_list FROM V_USER_SHOP WHERE V_USER_SHOP.USER_ID = user_id_list(i);

        FOR s in 1 .. shop_id_list.count LOOP
            SELECT SHOP_CODE INTO shop_code_v FROM T_SHOP WHERE ID = shop_id_list(s);
            SELECT NAME INTO shop_name FROM T_SHOP WHERE ID = shop_id_list(s);
            SELECT area_code INTO holding_id FROM T_SHOP WHERE ID = shop_id_list(s);
            SELECT company_code INTO subgroup_id FROM T_SHOP WHERE ID = shop_id_list(s);
            SELECT holding_code INTO gr_id FROM T_SHOP WHERE T_SHOP.ID = shop_id_list(s);

            DBMS_OUTPUT.PUT('      SHOP_NAME ' || shop_name );
            DBMS_OUTPUT.PUT('      AREA_CODE  ' || holding_id ); DBMS_OUTPUT.PUT( '  SHOP_CODE    ' || shop_code_v );
            DBMS_OUTPUT.PUT('      COMPANY_CODE  ' || subgroup_id ); DBMS_OUTPUT.PUT('   HOLDING_CODE   '  || gr_id);
            DBMS_OUTPUT.PUT_LINE('');
        END LOOP;
    END LOOP;
END;
/