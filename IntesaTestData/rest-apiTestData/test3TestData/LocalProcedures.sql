grant all on IB_TEST3_MERCHANT_OBJ.T_SHOP to IB_TEST3_TRANSACTION_OBJ;

--------------------------------------------------------
--  File created - Monday-August-09-2019
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure CREATE_TEST_SHOPS_AUTOMATION
--------------------------------------------------------
set define off;

CREATE OR REPLACE EDITIONABLE PROCEDURE "IB_TEST3_MERCHANT_OBJ"."CREATE_TEST_SHOPS_AUTOMATION"

    IS
    gr_id1 varchar(9):= '50'; -- ristorante
    gr_id2 varchar(9):= '60'; -- pizza
    start_shop_id varchar(9) := 110090000;
    TYPE post_type IS VARRAY(50) OF VARCHAR(2);
    post_type_list post_type := post_type('02','15','10','05');
    TYPE hold_array IS VARRAY(50) OF VARCHAR(9);
    hold_array_list hold_array := hold_array('01','02','110090050','04','110090100','06','07','110090300','09','110090500','011','110091000', '110091100');
    TYPE subgr_type IS VARRAY(50) OF VARCHAR(9);
    subgr_type_list subgr_type := subgr_type('100','200','300','400','001','002','003','004','005','006','007','008');
    post_type_counter int := 1;
    mcc_id varchar(5);
    post_id varchar(2);

BEGIN
    FOR i IN 0 .. 70 LOOP
        SELECT MCC INTO mcc_id FROM ( SELECT MCC FROM T_MCC_CATEGORY WHERE MCC = '03722' ) ;
        IF post_type_counter = 5 THEN post_type_counter := 1; END IF;
        IF post_type_counter <= 4 THEN post_id := post_type_list(post_type_counter);  END IF;
        INSERT INTO t_shop (shop_code, holding_code, company_code, area_code, is_area_main_shop, pos_type,  mcc, address, name, shop_alias, company_name, fiscal_code, vat_number, produce_ec)
        VALUES (start_shop_id + i * 10,   gr_id1 , '9999999999' , '000000000' , 0, post_id,  mcc_id, i || ' Milan, Viale Ergisto Bezzi '|| i, 'ristorante_shop_' || i, 'ristorante_shop_' || i, 'company_name_' || i, 'fisc_code_' || i, 'VAT_' || i, 'Y');
        post_type_counter := post_type_counter + 1;
    END LOOP;

    FOR i IN  71 .. 117 LOOP
        SELECT MCC INTO mcc_id FROM ( SELECT MCC FROM T_MCC_CATEGORY WHERE MCC = '03681' );
        IF post_type_counter = 5 THEN post_type_counter := 1; END IF;
        IF post_type_counter <= 4 THEN post_id := post_type_list(post_type_counter);  END IF;
        INSERT INTO t_shop (shop_code, holding_code, company_code, area_code, is_area_main_shop, pos_type,  mcc, address, name, shop_alias, company_name, fiscal_code, vat_number, produce_ec)
        VALUES (start_shop_id + i * 10,   gr_id2 , '9999999999' , '000000000' , 0, post_id,  mcc_id, 'Milan, Via Giuseppe Verde ' || i, 'pizza_shop_' || i, 'pizza_shop_' || i, 'company_name_' || i, 'fisc_code_' || i, 'VAT_' || i, 'Y');
        post_type_counter := post_type_counter + 1;
    END LOOP;

--SET area for shop
    UPDATE T_SHOP SET area_code = hold_array_list(1)  WHERE SHOP_CODE = start_shop_id + 0;                 				         UPDATE T_shop SET is_area_main_shop = 1 WHERE shop_code = hold_array_list(1);
    UPDATE T_SHOP SET area_code = hold_array_list(2)  WHERE SHOP_CODE BETWEEN start_shop_id +   10 AND start_shop_id +   20;     UPDATE T_shop SET is_area_main_shop = 1 WHERE shop_code = hold_array_list(2);
    UPDATE T_SHOP SET area_code = hold_array_list(3)  WHERE SHOP_CODE BETWEEN start_shop_id +   30 AND start_shop_id +   50;     UPDATE T_shop SET is_area_main_shop = 1 WHERE shop_code = hold_array_list(3);
    UPDATE T_SHOP SET area_code = hold_array_list(4)  WHERE SHOP_CODE BETWEEN start_shop_id +   60 AND start_shop_id +   90;     UPDATE T_shop SET is_area_main_shop = 1 WHERE shop_code = hold_array_list(4);
    UPDATE T_SHOP SET area_code = hold_array_list(5)  WHERE SHOP_CODE BETWEEN start_shop_id +  100 AND start_shop_id +  140;     UPDATE T_shop SET is_area_main_shop = 1 WHERE shop_code = hold_array_list(5);
    UPDATE T_SHOP SET area_code = hold_array_list(6)  WHERE SHOP_CODE BETWEEN start_shop_id +  150 AND start_shop_id +  200;     UPDATE T_shop SET is_area_main_shop = 1 WHERE shop_code = hold_array_list(6);
    UPDATE T_SHOP SET area_code = hold_array_list(7)  WHERE SHOP_CODE BETWEEN start_shop_id +  210 AND start_shop_id +  270;     UPDATE T_shop SET is_area_main_shop = 1 WHERE shop_code = hold_array_list(7);
    UPDATE T_SHOP SET area_code = hold_array_list(8)  WHERE SHOP_CODE BETWEEN start_shop_id +  280 AND start_shop_id +  350;     UPDATE T_shop SET is_area_main_shop = 1 WHERE shop_code = hold_array_list(8);
    UPDATE T_SHOP SET area_code = hold_array_list(9)  WHERE SHOP_CODE BETWEEN start_shop_id +  360 AND start_shop_id +  440;     UPDATE T_shop SET is_area_main_shop = 1 WHERE shop_code = hold_array_list(9);
    UPDATE T_SHOP SET area_code = hold_array_list(10) WHERE SHOP_CODE BETWEEN start_shop_id +  450 AND start_shop_id +  540;     UPDATE T_shop SET is_area_main_shop = 1 WHERE shop_code = hold_array_list(10);
    UPDATE T_SHOP SET area_code = hold_array_list(11) WHERE SHOP_CODE BETWEEN start_shop_id +  550 AND start_shop_id +  650;     UPDATE T_shop SET is_area_main_shop = 1 WHERE shop_code = hold_array_list(11);
    UPDATE T_SHOP SET area_code = hold_array_list(12) WHERE SHOP_CODE BETWEEN start_shop_id +  960 AND start_shop_id + 1010;     UPDATE T_shop SET is_area_main_shop = 1 WHERE shop_code = hold_array_list(12);
    UPDATE T_SHOP SET area_code = hold_array_list(13) WHERE SHOP_CODE BETWEEN start_shop_id + 1090 AND start_shop_id + 1160;     UPDATE T_shop SET is_area_main_shop = 1 WHERE shop_code = hold_array_list(13);

--SET company for shops
    UPDATE T_SHOP SET company_code = subgr_type_list(1) WHERE SHOP_CODE IN (start_shop_id ,start_shop_id +50,start_shop_id +60, start_shop_id + 180, start_shop_id + 190,
                                                                            start_shop_id + 300, start_shop_id + 310, start_shop_id + 320, start_shop_id + 330, start_shop_id + 350, start_shop_id + 400, start_shop_id + 410, start_shop_id + 420,
                                                                            start_shop_id + 560, start_shop_id + 570, start_shop_id + 580, start_shop_id + 590, start_shop_id + 600, start_shop_id + 660, start_shop_id + 670, start_shop_id + 680, start_shop_id + 690);
    UPDATE T_SHOP SET company_code = subgr_type_list(2)
    WHERE SHOP_CODE IN (start_shop_id + 700,start_shop_id + 710,start_shop_id + 720,start_shop_id + 730,start_shop_id + 740,
                        start_shop_id +10,start_shop_id +20,start_shop_id +30,start_shop_id +70,start_shop_id +80,start_shop_id +360,
                        start_shop_id +370,start_shop_id +380,start_shop_id +390,start_shop_id +540,
                        start_shop_id +550,start_shop_id +640,start_shop_id +650,start_shop_id +790);
    UPDATE T_SHOP SET company_code = subgr_type_list(3) WHERE SHOP_CODE IN (start_shop_id +40,start_shop_id +100,start_shop_id +200,
                                                                            start_shop_id +210,start_shop_id +220,start_shop_id +230,start_shop_id +240,start_shop_id +250,start_shop_id +260
        ,start_shop_id +270,start_shop_id +430,start_shop_id +440,start_shop_id +450,
                                                                            start_shop_id +530,start_shop_id +610,start_shop_id +750,start_shop_id +760);
    UPDATE T_SHOP SET company_code = subgr_type_list(4) WHERE SHOP_CODE IN (start_shop_id +110,start_shop_id +120,
                                                                            start_shop_id +130,start_shop_id +140,start_shop_id +150,start_shop_id +160,start_shop_id +290,start_shop_id +460,start_shop_id +470,start_shop_id +490,
                                                                            start_shop_id +500,start_shop_id +510,start_shop_id +620,start_shop_id +630);
    UPDATE T_SHOP SET company_code = subgr_type_list(5) WHERE SHOP_CODE IN (start_shop_id +810);
    UPDATE T_SHOP SET company_code = subgr_type_list(6) WHERE SHOP_CODE IN (start_shop_id +820, start_shop_id +830);
    UPDATE T_SHOP SET company_code = subgr_type_list(7) WHERE SHOP_CODE IN (start_shop_id +840, start_shop_id +850, start_shop_id +860);
    UPDATE T_SHOP SET company_code = subgr_type_list(8) WHERE SHOP_CODE IN (start_shop_id +870, start_shop_id +880, start_shop_id +890, start_shop_id +900);
    UPDATE T_SHOP SET company_code = subgr_type_list(9) WHERE SHOP_CODE IN (start_shop_id +910, start_shop_id +920, start_shop_id +930, start_shop_id +940, start_shop_id +950);
    UPDATE T_SHOP SET company_code = subgr_type_list(10) WHERE SHOP_CODE IN (start_shop_id +960, start_shop_id +970, start_shop_id +980,
                                                                             start_shop_id +990,start_shop_id +1000,start_shop_id +1010);
    UPDATE T_SHOP SET company_code = subgr_type_list(11) WHERE SHOP_CODE IN (start_shop_id +1020,start_shop_id +1030,start_shop_id +1040,start_shop_id +1050,start_shop_id +1060,
                                                                             start_shop_id +1070,start_shop_id +1080);
    UPDATE T_SHOP SET company_code = subgr_type_list(12) WHERE SHOP_CODE IN (start_shop_id +1090,start_shop_id +1100,start_shop_id +1110,start_shop_id +1120,start_shop_id +1130,
                                                                             start_shop_id +1140,start_shop_id +1150,start_shop_id +1160,start_shop_id +1170);

    --reset gr1 for some shops
    UPDATE T_SHOP SET holding_code = gr_id1 WHERE SHOP_CODE  BETWEEN start_shop_id + 1120 AND start_shop_id + 1150;
    UPDATE T_SHOP SET holding_code = gr_id1 WHERE SHOP_CODE  BETWEEN start_shop_id + 1030 AND start_shop_id + 1060;

    --SET default holding for specific shops
    UPDATE T_SHOP SET holding_code = '9999999999'  WHERE SHOP_CODE IN (start_shop_id +170,start_shop_id +340,start_shop_id +90,start_shop_id +520,start_shop_id +280,
                                                                       start_shop_id +480,start_shop_id +800,start_shop_id +770,start_shop_id +780,start_shop_id +1180,start_shop_id +1190);
    UPDATE T_SHOP SET name = 'shop_without_holding' WHERE SHOP_CODE IN (start_shop_id +170,start_shop_id +340,start_shop_id +90,start_shop_id +520,start_shop_id +280,
                                                                        start_shop_id +48,start_shop_id +800,start_shop_id +770,start_shop_id +780,start_shop_id +1180,start_shop_id +1190) and holding_code = '9999999999';
    --set commission accounting = 'L' for shop 110090090
    UPDATE T_SHOP SET COMMISSION_ACCOUNTING = 'L' WHERE SHOP_CODE = '110090090';
END;

/
--------------------------------------------------------
--  DDL for Procedure CREATE_TEST_USERS_AUTOMATION
--------------------------------------------------------
set define off;

CREATE OR REPLACE EDITIONABLE PROCEDURE "IB_TEST3_MERCHANT_OBJ"."CREATE_TEST_USERS_AUTOMATION"
    IS
    TYPE subgr_type IS VARRAY(50) OF VARCHAR(9);
    subgr_type_list subgr_type := subgr_type('100','200','300','400','001','002','003','004','005','006','007','008');
    TYPE hold_array IS VARRAY(50) OF VARCHAR(9);
    hold_array_list hold_array := hold_array('01','02','110090050','04','110090100','06','07','110090300','09','110090500','011','110091000', '110091100');
    gr_id1 varchar(9):= '50'; -- ristorante
    gr_id2 varchar(9):= '60'; -- pizza
    gr1_name varchar(255):= 'ristorante';
    gr2_name varchar(255):= 'pizza';
    shop_id1 integer:= 110091180;
    shop_id2 integer:= 110091190;
BEGIN

    -- ADD Users type AREA      hold_ || hold_type(i) || '@gmail.com'
    FOR i iN 1 .. 11 LOOP
        INSERT INTO T_USER (USERNAME, PASSWORD, FIRST_NAME, LAST_NAME, STATUS, EMAIL, USER_LEVEL, LANGUAGE, TERMS_AND_CONDITIONS)
        VALUES ('hold_' || hold_array_list(i) || '@gmail.com' ,'1c98decf10a5c1ce3737a5bdd84eec316775e6dc4c03bc6b4178c9e57c7b9e44710763940e31e4be',
                'hold_first_name' || hold_array_list(i) ,'hold_last_name' || hold_array_list(i),'ENABLED','endava.ib@gmail.com','L3','it_IT',1);
        INSERT INTO t_user_grant (user_id, code, code_type) VALUES ((SELECT ID FROM t_user WHERE username = 'hold_' || hold_array_list(i) || '@gmail.com' ), hold_array_list(i) , 'AREA');
        INSERT INTO T_SEC_USER_GROUP (USER_ID, GROUP_ID)
        VALUES ((SELECT ID FROM t_user WHERE username = 'hold_' || hold_array_list(i) || '@gmail.com' ),2);
    END LOOP;

    -- user subgroup_ + subgr_type_list(1) +@gmail.com   with group_code = gr_id and subgroup_name = gr1_name || '_' || subgr_type_list(1) || ' subgroup'

    INSERT INTO T_USER (USERNAME, PASSWORD, FIRST_NAME, LAST_NAME, STATUS, EMAIL, USER_LEVEL, LANGUAGE, TERMS_AND_CONDITIONS)
    VALUES (gr1_name || '_subgroup_' || subgr_type_list(1)||'@gmail.com' ,'1c98decf10a5c1ce3737a5bdd84eec316775e6dc4c03bc6b4178c9e57c7b9e44710763940e31e4be',
            subgr_type_list(1) || 'subgroup_first_name' , subgr_type_list(1) || 'subgroup_last_name','ENABLED','endava.ib@gmail.com','L2','it_IT',1);
    INSERT INTO T_USER_GRANT (user_id, code, code2, code_type)
    VALUES ( (SELECT ID FROM t_user WHERE username = gr1_name || '_subgroup_' || subgr_type_list(1)||'@gmail.com'), subgr_type_list(1) ,gr_id1, 'COMPANY');
    INSERT INTO T_COMPANY (COMPANY_CODE, HOLDING_CODE, NAME)
    VALUES (subgr_type_list(1), gr_id1, gr1_name || '_' || subgr_type_list(1) || ' subgroup');
    INSERT INTO T_SEC_USER_GROUP (USER_ID, GROUP_ID)
    VALUES ((SELECT ID FROM t_user WHERE username = gr1_name || '_subgroup_' || subgr_type_list(1)||'@gmail.com'),2);

    -- add 2 user for  subgr_type_list(2), one with gr_id1 and one with gr_id2
    INSERT INTO T_USER (USERNAME, PASSWORD, FIRST_NAME, LAST_NAME, STATUS, EMAIL, USER_LEVEL, LANGUAGE, TERMS_AND_CONDITIONS)
    VALUES ( gr1_name || '_subgroup_' || subgr_type_list(2)||'@gmail.com' ,'1c98decf10a5c1ce3737a5bdd84eec316775e6dc4c03bc6b4178c9e57c7b9e44710763940e31e4be',
             subgr_type_list(2) || 'subgroup_first_name' , subgr_type_list(2) || 'subgroup_last_name','ENABLED','endava.ib@gmail.com','L2','it_IT',1);
    INSERT INTO T_USER_GRANT (user_id, code, code2, code_type)
    VALUES ( (SELECT ID FROM t_user WHERE username = gr1_name || '_subgroup_' || subgr_type_list(2)||'@gmail.com'), subgr_type_list(2) ,gr_id1, 'COMPANY');
    INSERT INTO T_COMPANY (COMPANY_CODE, HOLDING_CODE, NAME)
    VALUES (subgr_type_list(2), gr_id1, gr1_name || '_' || subgr_type_list(2) || ' subgroup');
    INSERT INTO T_SEC_USER_GROUP (USER_ID, GROUP_ID)
    VALUES ((SELECT ID FROM t_user WHERE username = gr1_name || '_subgroup_' || subgr_type_list(2)||'@gmail.com'),2);

    INSERT INTO T_USER (USERNAME, PASSWORD, FIRST_NAME, LAST_NAME, STATUS, EMAIL, USER_LEVEL, LANGUAGE, TERMS_AND_CONDITIONS)
    VALUES (gr2_name || '_subgroup_' || subgr_type_list(2)||'@gmail.com' ,'1c98decf10a5c1ce3737a5bdd84eec316775e6dc4c03bc6b4178c9e57c7b9e44710763940e31e4be',
            subgr_type_list(2) || ' subgroup_first_name' , subgr_type_list(2) || ' subgroup_last_name','ENABLED','endava.ib@gmail.com','L2','it_IT',1);
    INSERT INTO T_USER_GRANT (user_id, code, code2, code_type)
    VALUES ( (SELECT ID FROM t_user WHERE username = gr2_name || '_subgroup_' || subgr_type_list(2)||'@gmail.com'), subgr_type_list(2) ,gr_id2, 'COMPANY');
    INSERT INTO T_COMPANY (COMPANY_CODE, HOLDING_CODE, NAME)
    VALUES (subgr_type_list(2), gr_id2, gr2_name || '_' || subgr_type_list(2) || ' subgroup');
    INSERT INTO T_SEC_USER_GROUP (USER_ID, GROUP_ID)
    VALUES ((SELECT ID FROM t_user WHERE username = gr2_name || '_subgroup_' || subgr_type_list(2)||'@gmail.com'),2);

    -- add 2 user for  subgr_type_list(3), one with gr_id1 and one with gr_id2
    INSERT INTO T_USER (USERNAME, PASSWORD, FIRST_NAME, LAST_NAME, STATUS, EMAIL, USER_LEVEL, LANGUAGE, TERMS_AND_CONDITIONS)
    VALUES ( gr1_name || '_subgroup_' || subgr_type_list(3)||'@gmail.com' ,'1c98decf10a5c1ce3737a5bdd84eec316775e6dc4c03bc6b4178c9e57c7b9e44710763940e31e4be',
             subgr_type_list(3) || 'subgroup_first_name' , subgr_type_list(3) || 'subgroup_last_name','ENABLED','endava.ib@gmail.com','L2','it_IT',1);
    INSERT INTO T_USER_GRANT (user_id, code, code2, code_type)
    VALUES ( (SELECT ID FROM t_user WHERE username = gr1_name || '_subgroup_' || subgr_type_list(3)||'@gmail.com'), subgr_type_list(3) ,gr_id1, 'COMPANY');
    INSERT INTO T_COMPANY (COMPANY_CODE, HOLDING_CODE, NAME)
    VALUES (subgr_type_list(3), gr_id1, gr1_name || '_' || subgr_type_list(3) || ' subgroup');
    INSERT INTO T_SEC_USER_GROUP (USER_ID, GROUP_ID)
    VALUES ((SELECT ID FROM t_user WHERE username = gr1_name || '_subgroup_' || subgr_type_list(3)||'@gmail.com'),2);

    INSERT INTO T_USER (USERNAME, PASSWORD, FIRST_NAME, LAST_NAME, STATUS, EMAIL, USER_LEVEL, LANGUAGE, TERMS_AND_CONDITIONS)
    VALUES (gr2_name || '_subgroup_' || subgr_type_list(3)||'@gmail.com' ,'1c98decf10a5c1ce3737a5bdd84eec316775e6dc4c03bc6b4178c9e57c7b9e44710763940e31e4be',
            subgr_type_list(3) || ' subgroup_first_name' , subgr_type_list(3) || ' subgroup_last_name','ENABLED','endava.ib@gmail.com','L2','it_IT',1);
    INSERT INTO T_USER_GRANT (user_id, code, code2, code_type)
    VALUES ( (SELECT ID FROM t_user WHERE username = gr2_name || '_subgroup_' || subgr_type_list(3)||'@gmail.com'), subgr_type_list(3) ,gr_id2, 'COMPANY');
    INSERT INTO T_COMPANY (COMPANY_CODE, HOLDING_CODE, NAME)
    VALUES (subgr_type_list(3), gr_id2, gr2_name || '_' || subgr_type_list(3) || ' subgroup');
    INSERT INTO T_SEC_USER_GROUP (USER_ID, GROUP_ID)
    VALUES ((SELECT ID FROM t_user WHERE username = gr2_name || '_subgroup_' || subgr_type_list(3)||'@gmail.com'),2);

    -- add 2 user for  subgr_type_list(4), one with gr_id1 and one with gr_id2
    INSERT INTO T_USER (USERNAME, PASSWORD, FIRST_NAME, LAST_NAME, STATUS, EMAIL, USER_LEVEL, LANGUAGE, TERMS_AND_CONDITIONS)
    VALUES ( gr1_name || '_subgroup_' || subgr_type_list(4)||'@gmail.com' ,'1c98decf10a5c1ce3737a5bdd84eec316775e6dc4c03bc6b4178c9e57c7b9e44710763940e31e4be',
             subgr_type_list(4) || 'subgroup_first_name' , subgr_type_list(4) || 'subgroup_last_name','ENABLED','endava.ib@gmail.com','L2','it_IT',1);
    INSERT INTO T_USER_GRANT (user_id, code, code2, code_type)
    VALUES ( (SELECT ID FROM t_user WHERE username = gr1_name || '_subgroup_' || subgr_type_list(4)||'@gmail.com'), subgr_type_list(4) ,gr_id1, 'COMPANY');
    INSERT INTO T_COMPANY (COMPANY_CODE, HOLDING_CODE, NAME)
    VALUES (subgr_type_list(4), gr_id1, gr1_name || '_' || subgr_type_list(4) || ' subgroup');
    INSERT INTO T_SEC_USER_GROUP (USER_ID, GROUP_ID)
    VALUES ((SELECT ID FROM t_user WHERE username = gr1_name || '_subgroup_' || subgr_type_list(4)||'@gmail.com'),2);

    INSERT INTO T_USER (USERNAME, PASSWORD, FIRST_NAME, LAST_NAME, STATUS, EMAIL, USER_LEVEL, LANGUAGE, TERMS_AND_CONDITIONS)
    VALUES (gr2_name || '_subgroup_' || subgr_type_list(4)||'@gmail.com' ,'1c98decf10a5c1ce3737a5bdd84eec316775e6dc4c03bc6b4178c9e57c7b9e44710763940e31e4be',
            subgr_type_list(4) || ' subgroup_first_name' , subgr_type_list(4) || ' subgroup_last_name','ENABLED','endava.ib@gmail.com','L2','it_IT',1);
    INSERT INTO T_USER_GRANT (user_id, code, code2, code_type)
    VALUES ( (SELECT ID FROM t_user WHERE username = gr2_name || '_subgroup_' || subgr_type_list(4)||'@gmail.com'), subgr_type_list(4) ,gr_id2, 'COMPANY');
    INSERT INTO T_COMPANY (COMPANY_CODE, HOLDING_CODE, NAME)
    VALUES (subgr_type_list(4), gr_id2, gr2_name || '_' || subgr_type_list(4) || ' subgroup');
    INSERT INTO T_SEC_USER_GROUP (USER_ID, GROUP_ID)
    VALUES ((SELECT ID FROM t_user WHERE username = gr2_name || '_subgroup_' || subgr_type_list(4)||'@gmail.com'),2);

    -- user subgroup_ + subgr_type_list(5) +@gmail.com   with group_code = gr_id and subgroup_name = gr1_name || '_' || subgr_type_list(1) || ' subgroup'
    INSERT INTO T_USER (USERNAME, PASSWORD, FIRST_NAME, LAST_NAME, STATUS, EMAIL, USER_LEVEL, LANGUAGE, TERMS_AND_CONDITIONS)
    VALUES (gr2_name || '_subgroup_' || subgr_type_list(5)||'@gmail.com' ,'1c98decf10a5c1ce3737a5bdd84eec316775e6dc4c03bc6b4178c9e57c7b9e44710763940e31e4be',
            subgr_type_list(5) || ' subgroup_first_name' , subgr_type_list(5) || ' subgroup_last_name','ENABLED','endava.ib@gmail.com','L2','it_IT',1);
    INSERT INTO T_USER_GRANT (user_id, code, code2, code_type)
    VALUES ( (SELECT ID FROM t_user WHERE username = gr2_name || '_subgroup_' || subgr_type_list(5)||'@gmail.com'), subgr_type_list(5) ,gr_id2, 'COMPANY');
    INSERT INTO T_COMPANY (COMPANY_CODE, HOLDING_CODE, NAME)
    VALUES (subgr_type_list(5), gr_id2, gr2_name || '_' || subgr_type_list(5) || ' subgroup');
    INSERT INTO T_SEC_USER_GROUP (USER_ID, GROUP_ID)
    VALUES ((SELECT ID FROM t_user WHERE username = gr2_name || '_subgroup_' || subgr_type_list(5)||'@gmail.com'),2);

    -- user subgroup_ + subgr_type_list(6) +@gmail.com   with group_code = gr_id and subgroup_name = gr1_name || '_' || subgr_type_list(1) || ' subgroup'
    INSERT INTO T_USER (USERNAME, PASSWORD, FIRST_NAME, LAST_NAME, STATUS, EMAIL, USER_LEVEL, LANGUAGE, TERMS_AND_CONDITIONS)
    VALUES (gr2_name || '_subgroup_' || subgr_type_list(6)||'@gmail.com' ,'1c98decf10a5c1ce3737a5bdd84eec316775e6dc4c03bc6b4178c9e57c7b9e44710763940e31e4be',
            subgr_type_list(6) || ' subgroup_first_name' , subgr_type_list(6) || ' subgroup_last_name','ENABLED','endava.ib@gmail.com','L2','it_IT',1);
    INSERT INTO T_USER_GRANT (user_id, code, code2, code_type)
    VALUES ( (SELECT ID FROM t_user WHERE username = gr2_name || '_subgroup_' || subgr_type_list(6)||'@gmail.com'), subgr_type_list(6) ,gr_id2, 'COMPANY');
    INSERT INTO T_COMPANY (COMPANY_CODE, HOLDING_CODE, NAME)
    VALUES (subgr_type_list(6), gr_id2, gr2_name || '_' || subgr_type_list(6) || ' subgroup');
    INSERT INTO T_SEC_USER_GROUP (USER_ID, GROUP_ID)
    VALUES ((SELECT ID FROM t_user WHERE username = gr2_name || '_subgroup_' || subgr_type_list(6)||'@gmail.com'),2);

    -- user subgroup_ + subgr_type_list(7) +@gmail.com   with group_code = gr_id and subgroup_name = gr1_name || '_' || subgr_type_list(1) || ' subgroup'
    INSERT INTO T_USER (USERNAME, PASSWORD, FIRST_NAME, LAST_NAME, STATUS, EMAIL, USER_LEVEL, LANGUAGE, TERMS_AND_CONDITIONS)
    VALUES (gr2_name || '_subgroup_' || subgr_type_list(7)||'@gmail.com' ,'1c98decf10a5c1ce3737a5bdd84eec316775e6dc4c03bc6b4178c9e57c7b9e44710763940e31e4be',
            subgr_type_list(7) || ' subgroup_first_name' , subgr_type_list(7) || ' subgroup_last_name','ENABLED','endava.ib@gmail.com','L2','it_IT',1);
    INSERT INTO T_USER_GRANT (user_id, code, code2, code_type)
    VALUES ( (SELECT ID FROM t_user WHERE username = gr2_name || '_subgroup_' || subgr_type_list(7)||'@gmail.com'), subgr_type_list(7) ,gr_id2, 'COMPANY');
    INSERT INTO T_COMPANY (COMPANY_CODE, HOLDING_CODE, NAME)
    VALUES (subgr_type_list(7), gr_id2, gr2_name || '_' || subgr_type_list(7) || ' subgroup');
    INSERT INTO T_SEC_USER_GROUP (USER_ID, GROUP_ID)
    VALUES ((SELECT ID FROM t_user WHERE username = gr2_name || '_subgroup_' || subgr_type_list(7)||'@gmail.com'),2);

    -- user subgroup_ + subgr_type_list(8) +@gmail.com   with group_code = gr_id and subgroup_name = gr1_name || '_' || subgr_type_list(9) || ' subgroup'
    INSERT INTO T_USER (USERNAME, PASSWORD, FIRST_NAME, LAST_NAME, STATUS, EMAIL, USER_LEVEL, LANGUAGE, TERMS_AND_CONDITIONS)
    VALUES (gr2_name || '_subgroup_' || subgr_type_list(8)||'@gmail.com' ,'1c98decf10a5c1ce3737a5bdd84eec316775e6dc4c03bc6b4178c9e57c7b9e44710763940e31e4be',
            subgr_type_list(8) || ' subgroup_first_name' , subgr_type_list(8) || ' subgroup_last_name','ENABLED','endava.ib@gmail.com','L2','it_IT',1);
    INSERT INTO T_USER_GRANT (user_id, code, code2, code_type)
    VALUES ( (SELECT ID FROM t_user WHERE username = gr2_name || '_subgroup_' || subgr_type_list(8)||'@gmail.com'), subgr_type_list(8) ,gr_id2, 'COMPANY');
    INSERT INTO T_COMPANY (COMPANY_CODE, HOLDING_CODE, NAME)
    VALUES (subgr_type_list(8), gr_id2, gr2_name || '_' || subgr_type_list(8) || ' subgroup');
    INSERT INTO T_SEC_USER_GROUP (USER_ID, GROUP_ID)
    VALUES ((SELECT ID FROM t_user WHERE username = gr2_name || '_subgroup_' || subgr_type_list(8)||'@gmail.com'),2);

    -- user subgroup_ + subgr_type_list(9) +@gmail.com   with group_code = gr_id and subgroup_name = gr1_name || '_' || subgr_type_list(1) || ' subgroup'
    INSERT INTO T_USER (USERNAME, PASSWORD, FIRST_NAME, LAST_NAME, STATUS, EMAIL, USER_LEVEL, LANGUAGE, TERMS_AND_CONDITIONS)
    VALUES (gr2_name || '_subgroup_' || subgr_type_list(9)||'@gmail.com' ,'1c98decf10a5c1ce3737a5bdd84eec316775e6dc4c03bc6b4178c9e57c7b9e44710763940e31e4be',
            subgr_type_list(9) || ' subgroup_first_name' , subgr_type_list(9) || ' subgroup_last_name','ENABLED','endava.ib@gmail.com','L2','it_IT',1);
    INSERT INTO T_USER_GRANT (user_id, code, code2, code_type)
    VALUES ( (SELECT ID FROM t_user WHERE username = gr2_name || '_subgroup_' || subgr_type_list(9)||'@gmail.com'), subgr_type_list(9) ,gr_id2, 'COMPANY');
    INSERT INTO T_COMPANY (COMPANY_CODE, HOLDING_CODE, NAME)
    VALUES (subgr_type_list(9), gr_id2, gr2_name || '_' || subgr_type_list(9) || ' subgroup');
    INSERT INTO T_SEC_USER_GROUP (USER_ID, GROUP_ID)
    VALUES ((SELECT ID FROM t_user WHERE username = gr2_name || '_subgroup_' || subgr_type_list(9)||'@gmail.com'),2);

    -- user subgroup_ + subgr_type_list(10) +@gmail.com   with group_code = gr_id and subgroup_name = gr1_name || '_' || subgr_type_list(10) || ' subgroup'
    INSERT INTO T_USER (USERNAME, PASSWORD, FIRST_NAME, LAST_NAME, STATUS, EMAIL, USER_LEVEL, LANGUAGE, TERMS_AND_CONDITIONS)
    VALUES (gr2_name || '_subgroup_' || subgr_type_list(10)||'@gmail.com' ,'1c108decf10a5c1ce3737a5bdd84eec316775e6dc4c03bc6b4178c10e57c7b10e447107631040e31e4be',
            subgr_type_list(10) || ' subgroup_first_name' , subgr_type_list(10) || ' subgroup_last_name','ENABLED','endava.ib@gmail.com','L2','it_IT',1);
    INSERT INTO T_USER_GRANT (user_id, code, code2, code_type)
    VALUES ( (SELECT ID FROM t_user WHERE username = gr2_name || '_subgroup_' || subgr_type_list(10)||'@gmail.com'), subgr_type_list(10) ,gr_id2, 'COMPANY');
    INSERT INTO T_COMPANY (COMPANY_CODE, HOLDING_CODE, NAME)
    VALUES (subgr_type_list(10), gr_id2, gr2_name || '_' || subgr_type_list(10) || ' subgroup');
    INSERT INTO T_SEC_USER_GROUP (USER_ID, GROUP_ID)
    VALUES ((SELECT ID FROM t_user WHERE username = gr2_name || '_subgroup_' || subgr_type_list(10)||'@gmail.com'),2);

    -- user subgroup_ + subgr_type_list(11) +@gmail.com   with group_code = gr_id and subgroup_name = gr1_name || '_' || subgr_type_list(11) || ' subgroup'
    INSERT INTO T_USER (USERNAME, PASSWORD, FIRST_NAME, LAST_NAME, STATUS, EMAIL, USER_LEVEL, LANGUAGE, TERMS_AND_CONDITIONS)
    VALUES (gr2_name || '_subgroup_' || subgr_type_list(11)||'@gmail.com' ,'1c118decf11a5c1ce3737a5bdd84eec316775e6dc4c03bc6b4178c11e57c7b11e447117631140e31e4be',
            subgr_type_list(11) || ' subgroup_first_name' , subgr_type_list(11) || ' subgroup_last_name','ENABLED','endava.ib@gmail.com','L2','it_IT',1);
    INSERT INTO T_USER_GRANT (user_id, code, code2, code_type)
    VALUES ( (SELECT ID FROM t_user WHERE username = gr2_name || '_subgroup_' || subgr_type_list(11)||'@gmail.com'), subgr_type_list(11) ,gr_id2, 'COMPANY');
    INSERT INTO T_COMPANY (COMPANY_CODE, HOLDING_CODE, NAME)
    VALUES (subgr_type_list(11), gr_id2, gr2_name || '_' || subgr_type_list(11) || ' subgroup');
    INSERT INTO T_SEC_USER_GROUP (USER_ID, GROUP_ID)
    VALUES ((SELECT ID FROM t_user WHERE username = gr2_name || '_subgroup_' || subgr_type_list(11)||'@gmail.com'),2);

    -- user subgroup_ + subgr_type_list(12) +@gmail.com   with group_code = gr_id and subgroup_name = gr1_name || '_' || subgr_type_list(12) || ' subgroup'
    INSERT INTO T_USER (USERNAME, PASSWORD, FIRST_NAME, LAST_NAME, STATUS, EMAIL, USER_LEVEL, LANGUAGE, TERMS_AND_CONDITIONS)
    VALUES (gr2_name || '_subgroup_' || subgr_type_list(12)||'@gmail.com' ,'1c128decf12a5c1ce3737a5bdd84eec316775e6dc4c03bc6b4178c12e57c7b12e447127631240e31e4be',
            subgr_type_list(12) || ' subgroup_first_name' , subgr_type_list(12) || ' subgroup_last_name','ENABLED','endava.ib@gmail.com','L2','it_IT',1);
    INSERT INTO T_USER_GRANT (user_id, code, code2, code_type)
    VALUES ( (SELECT ID FROM t_user WHERE username = gr2_name || '_subgroup_' || subgr_type_list(12)||'@gmail.com'), subgr_type_list(12) ,gr_id2, 'COMPANY');
    INSERT INTO T_COMPANY (COMPANY_CODE, HOLDING_CODE, NAME)
    VALUES (subgr_type_list(12), gr_id2, gr2_name || '_' || subgr_type_list(12) || ' subgroup');
    INSERT INTO T_SEC_USER_GROUP (USER_ID, GROUP_ID)
    VALUES ((SELECT ID FROM t_user WHERE username = gr2_name || '_subgroup_' || subgr_type_list(12)||'@gmail.com'),2);


    --ADD USER LEVEL HOLDING gr_id1
    INSERT INTO T_USER (USERNAME, PASSWORD, FIRST_NAME, LAST_NAME, STATUS, EMAIL, USER_LEVEL, LANGUAGE, TERMS_AND_CONDITIONS)
    VALUES ('group_' || gr_id1 || '@gmail.com' ,'1c98decf10a5c1ce3737a5bdd84eec316775e6dc4c03bc6b4178c9e57c7b9e44710763940e31e4be',
            gr_id1 || 'first_name' ,gr_id1 || 'last_name','ENABLED','endava.ib@gmail.com','L1','it_IT',1);
    INSERT INTO T_SEC_USER_GROUP (USER_ID, GROUP_ID)
    VALUES ((SELECT ID FROM t_user WHERE username = 'group_' || gr_id1 || '@gmail.com'),2);
    INSERT INTO T_USER_GRANT (user_id, code, code_type)
    VALUES ((SELECT ID FROM t_user WHERE username = 'group_' || gr_id1 || '@gmail.com'), gr_id1, 'HOLDING');
    INSERT INTO T_HOLDING ( HOLDING_CODE, NAME)
    VALUES (gr_id1, gr1_name || ' group');

    --ADD USER LEVEL HOLDING gr_id2
    INSERT INTO T_USER (USERNAME, PASSWORD, FIRST_NAME, LAST_NAME, STATUS, EMAIL, USER_LEVEL, LANGUAGE, TERMS_AND_CONDITIONS)
    VALUES ('group_' || gr_id2 || '@gmail.com' ,'1c98decf10a5c1ce3737a5bdd84eec316775e6dc4c03bc6b4178c9e57c7b9e44710763940e31e4be',
            gr_id2 || 'first_name' ,gr_id2 || 'last_name','ENABLED','endava.ib@gmail.com','L1','it_IT',1);
    INSERT INTO T_SEC_USER_GROUP (USER_ID, GROUP_ID)
    VALUES ((SELECT ID FROM t_user WHERE username = 'group_' || gr_id2 || '@gmail.com'),2);
    INSERT INTO T_USER_GRANT (user_id, code, code_type)
    VALUES ((SELECT ID FROM t_user WHERE username = 'group_' || gr_id2 || '@gmail.com'), gr_id2, 'HOLDING');
    INSERT INTO T_HOLDING ( HOLDING_CODE, NAME)
    VALUES (gr_id2, gr2_name || ' group');

END;

/
--------------------------------------------------------
--  DDL for Procedure DELETE_TEST_USERS_AUTOMATION
--------------------------------------------------------
set define off;

CREATE OR REPLACE EDITIONABLE PROCEDURE "IB_TEST3_MERCHANT_OBJ"."DELETE_TEST_USERS_AUTOMATION"

-- set start shop id, holdings and group and subgroup

    IS
    TYPE subgr_type IS VARRAY(50) OF VARCHAR(9);
    subgr_type_list subgr_type := subgr_type('100','200','300','400','001','002','003','004','005','006','007','008');
    TYPE hold_array IS VARRAY(50) OF VARCHAR(9);
    hold_array_list hold_array := hold_array('01','02','110090050','04','110090100','06','07','110090300','09','110090500','011','110091000', '110091100');
    gr_id1 varchar(9):= '50'; -- ristorante
    gr_id2 varchar(9):= '60'; -- pizza
    start_shop_id varchar(9) := 110090000;
    gr1_name varchar(255):= 'ristorante';
    gr2_name varchar(255):= 'pizza';

BEGIN


    -- DELETE User type AREAS
    FOR i iN 1 .. hold_array_list.COUNT LOOP
        DELETE FROM T_USER_GRANT WHERE USER_ID = ((SELECT ID FROM t_user WHERE username = 'hold_' || hold_array_list(i) || '@gmail.com')) ;
        DELETE FROM T_SEC_USER_GROUP WHERE USER_ID = (SELECT ID FROM T_USER WHERE USERNAME = 'hold_' || hold_array_list(i) || '@gmail.com');
        DELETE FROM T_USER WHERE USERNAME = 'hold_' || hold_array_list(i) || '@gmail.com';
    END LOOP;

    -- DELETE Users type subgroup
    FOR I IN 1 .. subgr_type_list.COUNT LOOP
        DELETE FROM T_COMPANY WHERE COMPANY_CODE = subgr_type_list(i);

        DELETE FROM T_USER_GRANT WHERE user_id = (SELECT ID FROM t_user WHERE username = gr2_name || '_subgroup_' || subgr_type_list(i)||'@gmail.com');
        DELETE FROM T_SEC_USER_GROUP WHERE USER_ID = (SELECT ID FROM T_USER WHERE USERNAME = gr2_name || '_subgroup_' || subgr_type_list(i)||'@gmail.com');
        DELETE FROM T_USER  WHERE  username = gr2_name || '_subgroup_' || subgr_type_list(i)||'@gmail.com';

        DELETE FROM T_USER_GRANT WHERE user_id = (SELECT ID FROM t_user WHERE username = gr1_name || '_subgroup_' || subgr_type_list(i)||'@gmail.com');
        DELETE FROM T_SEC_USER_GROUP WHERE USER_ID = (SELECT ID FROM T_USER WHERE USERNAME = gr1_name || '_subgroup_' || subgr_type_list(i)||'@gmail.com');
        DELETE FROM T_USER  WHERE  username = gr1_name || '_subgroup_' || subgr_type_list(i)||'@gmail.com';
    END LOOP;

--DELETE user gr_id1
    DELETE FROM T_HOLDING WHERE HOLDING_CODE = gr_id1;
    DELETE FROM T_USER_GRANT WHERE user_id = (SELECT ID FROM t_user WHERE username =  'group_' || gr_id1 || '@gmail.com');
    DELETE FROM T_SEC_USER_GROUP WHERE USER_ID = (SELECT ID FROM T_USER WHERE USERNAME = 'group_' || gr_id1 || '@gmail.com');
    DELETE FROM T_USER WHERE  username =  'group_' || gr_id1 || '@gmail.com';

--DELETE user gr_id2
    DELETE FROM T_HOLDING WHERE HOLDING_CODE = gr_id2;
    DELETE FROM T_USER_GRANT WHERE user_id = (SELECT ID FROM t_user WHERE username = 'group_' || gr_id2 || '@gmail.com');
    DELETE FROM T_SEC_USER_GROUP WHERE USER_ID = (SELECT ID FROM T_USER WHERE USERNAME = 'group_' || gr_id2 || '@gmail.com');
    DELETE FROM T_USER WHERE  username =  'group_' || gr_id2 || '@gmail.com';

--DELETE ALL SHOP with specific group
    DELETE FROM T_SHOP
    WHERE SHOP_CODE IN
          ('110090000','110090010','110090020','110090030','110090040','110090050','110090060','110090070','110090080','110090090',
           '110090100','110090110','110090120','110090130','110090140','110090150','110090160','110090170','110090180','110090190','110090200','110090210',
           '110090220','110090230','110090240','110090250','110090260','110090270','110090280','110090290','110090300','110090310','110090320','110090330',
           '110090340','110090350','110090360','110090370','110090380','110090390','110090400','110090410','110090420','110090430','110090440','110090450',
           '110090460','110090470','110090480','110090490','110090500','110090510','110090520','110090530','110090540','110090550','110090560','110090570',
           '110090580','110090590','110090600','110090610','110090620','110090630','110090640','110090650','110090660','110090670','110090680','110090690',
           '110090700','110090710','110090720','110090730','110090740','110090750','110090760','110090770','110090780','110090790','110090800','110090810',
           '110090820','110090830','110090840','110090850','110090860','110090870','110090880','110090890','110090900','110090910','110090920','110090930',
           '110090940','110090950','110090960','110090970','110090980','110090990','110091000','110091010','110091020','110091030','110091040','110091050',
           '110091060','110091070','110091080','110091090','110091100','110091110','110091120','110091130','110091140','110091150','110091160','110091170');
END;

/
--------------------------------------------------------
--  DDL for Procedure ADD_1_TRANSACTION_AUTOMATION
--------------------------------------------------------
set define off;

CREATE OR REPLACE EDITIONABLE PROCEDURE "IB_TEST3_TRANSACTION_OBJ"."ADD_1_TRANSACTION_AUTOMATION" (

    shop_id  VARCHAR,     -- 9004
    trn_date VARCHAR,   --:= '28/05/19';
    trn_amount NUMBER,  --  := 1032;
    commision NUMBER,   -- := 4.44;
    fee NUMBER,      -- := 2.22;
    shortPan VARCHAR,       --(4) := 7890;
    currency VARCHAR,        --(3) := '978';
    cardtype VARCHAR2,      --(2) := '01';
    trn_type VARCHAR2,        --(2) := '10';
    trn_hour VARCHAR2,
    trn_min VARCHAR2
)
    IS
    holdingCode VARCHAR(10);     -- 9005
    subgroupCode VARCHAR(10);     -- 300
    groupCode VARCHAR(10);      --50
    channelType VARCHAR(2);     --02
    autCod INTEGER;
    cardBrand VARCHAR2(30);
BEGIN

    SELECT AUTHORIZATION_CODE INTO autCod FROM IB_TEST3_TRANSACTION_OBJ.T_TRANSACTION order by AUTHORIZATION_CODE desc fetch first 1 row only  ;
    IF autCod is null THEN autCod := 11; END IF;
    autCod := autCod + 1;
    SELECT AREA_CODE, COMPANY_CODE, HOLDING_CODE, POS_TYPE
    INTO holdingCode, subgroupCode, groupCode, channelType FROM IB_TEST3_MERCHANT_OBJ.T_SHOP WHERE SHOP_CODE = shop_id AND ROWNUM = 1;

    IF channelType IN ('02','15') THEN channelType:= 'V'; ELSE channelType:= 'F'; END IF;

    SELECT card_type into cardBrand FROM IB_TEST3_TRANSACTION_OBJ.T_CARD_TYPE WHERE CARD_TYPE_ID = cardtype;

    INSERT INTO IB_TEST3_TRANSACTION_OBJ.T_TRANSACTION
    (TRANSACTION_CODE, SHOP_CODE, TRANSACTION_DATETIME, TRANSACTION_DATE, TRANSACTION_WEEK, TRANSACTION_AMOUNT, TRANSACTION_CURRENCY, ACCOUNT_AMOUNT,
     OPERATION_TYPE, PAN, AUTHORIZATION_CODE, POS_TYPE, ACCOUNT_DATE, TRANSACTION_TIME, POS_NO, COMMISSION_AMOUNT, LIQUID_DATE, VALUE_DATE, ADDITIONAL_DATA,
     INTERCHANGE_FEE, AREA_CODE, COMPANY_CODE, HOLDING_CODE, CARD_TYPE, SHORT_PAN, EXCHANGE_RATE, CARD_NATURE, ACCOUNT_CURRENCY,CARD_BRAND)
    VALUES
    (IB_TEST3_TRANSACTION_OBJ.T_TRANSACTION_ID_SEQ.NEXTVAL,
     shop_id,
     TO_TIMESTAMP(trn_date || ' ' || trn_hour || ':' || trn_min || ':24.000000000', 'dd/mm/yy HH24:MI:SS.FF'),
     TO_DATE(trn_date, 'dd/mm/yy'),
     IB_TEST3_TRANSACTION_OBJ.GET_WEEK(TO_DATE(trn_date, 'dd/mm/yy')),
     trn_amount,
     currency,
     trn_amount,
     trn_type,
     '************' || shortPan,
     autCod,
     channelType,
     TO_DATE(trn_date, 'dd/mm/yyyy') + 1,
     trn_hour || trn_min,
     '0000'|| ROUND(DBMS_RANDOM.VALUE(1, 3)),
     commision,
     TO_DATE(trn_date, 'dd/mm/yyyy') + 2,
     TO_DATE(trn_date, 'dd/mm/yyyy') + 3,
     'Additional data',
     fee,
     holdingCode,
     subgroupCode,
     groupCode,
     cardtype,
     shortPan,
     1.1,
     cardtype,
     currency,
     cardBrand);
END ADD_1_TRANSACTION_AUTOMATION;

/
--------------------------------------------------------
--  DDL for Procedure ADD_AUTH_TRANSACTIONS_AUTOMATION
--------------------------------------------------------
set define off;

CREATE OR REPLACE NONEDITIONABLE PROCEDURE "IB_TEST3_TRANSACTION_OBJ"."ADD_AUTH_TRANSACTIONS_AUTOMATION"

    IS
--
    transactionPereachType INTEGER := 10;
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
    operationType VARCHAR(2);
    cardType VARCHAR(100);
    additionalData VARCHAR(104);
    posType VARCHAR(1);

    PROCEDURE getShopDetails (shopCode IN VARCHAR, merchantSiaCode OUT VARCHAR, branchSiaCode OUT VARCHAR, posType OUT VARCHAR )
    AS
        temp VARCHAR(2);
    BEGIN
        SELECT  MERCHANT_SIA_CODE, BRANCH_SIA_CODE, POS_TYPE
        INTO  merchantSiaCode, branchSiaCode, temp
        FROM IB_TEST3_MERCHANT_OBJ.T_SHOP
        WHERE SHOP_CODE = shopCode  AND ROWNUM = 1;
        IF temp IN ('02','15') THEN posType := 'V'; ELSE posType := 'F'; END IF;
        IF merchantSiaCode is null THEN merchantSiaCode := 'M'; END IF;
        IF branchSiaCode is null THEN branchSiaCode := 'B'; END IF;
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
    BEGIN
        month_part := DBMS_RANDOM.VALUE(prev_month_num, this_month_num);

        CASE month_part
            WHEN this_month_num THEN day_part := DBMS_RANDOM.VALUE(1, max_day_this_month);
            WHEN prev_month_num THEN day_part := DBMS_RANDOM.VALUE(1, max_day_prev_month);
            ELSE month_part := 0;
        END CASE;
        trnSec     := ROUND(DBMS_RANDOM.VALUE(10, 59));
        trnMin     := ROUND(DBMS_RANDOM.VALUE(10, 59));
        trnHour    := ROUND(DBMS_RANDOM.VALUE(10, 23));
        trnDate    := TO_CHAR(day_part) || '/' || TO_CHAR(month_part) || '/' || TO_CHAR(year_part);
        trnTime    := trnHour || trnMin || trnSec;
        trnDateTime := TO_TIMESTAMP(trnDate || ' ' || trnHour || ':' || trnMin || ':' || trnSec || '.000000000', 'dd/mm/yy HH24:MI:SS.FF');
    END;
    PROCEDURE getCardTypeAndFI (fi OUT VARCHAR, cardType OUT VARCHAR)
    AS
    BEGIN
        SELECT FI_NUMBER, DESCRIPTION
        INTO fi, cardType
        FROM (SELECT FI_NUMBER,DESCRIPTION  FROM IB_TEST3_TRANSACTION_OBJ.T_AUTHORIZED_FI_NUMBER JOIN IB_TEST3_TRANSACTION_OBJ.T_CARD_TYPE ON T_AUTHORIZED_FI_NUMBER.CARD_TYPE_ID =
        T_CARD_TYPE.CARD_TYPE_ID ORDER BY DBMS_RANDOM.VALUE)
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

        IF transactionAmount < 0 THEN signValue := -1 ; ELSE signValue :=  1 ;END IF;
        IF transactionAmount < 0 THEN  operationType := '04' ; ELSE  operationType := '01' ; END IF;
    END;

BEGIN
    SELECT shop_code BULK COLLECT INTO shopsCode FROM IB_TEST3_MERCHANT_OBJ.T_SHOP
    WHERE shop_code IN
          ('110090000','110090010','110090020','110090030','110090040','110090050','110090060','110090070','110090080','110090090',
           '110090100','110090110','110090120','110090130','110090140','110090150','110090160','110090170','110090180','110090190','110090200','110090210',
           '110090220','110090230','110090240','110090250','110090260','110090270','110090280','110090290','110090300','110090310','110090320','110090330',
           '110090340','110090350','110090360','110090370','110090380','110090390','110090400','110090410','110090420','110090430','110090440','110090450',
           '110090460','110090470','110090480','110090490','110090500','110090510','110090520','110090530','110090540','110090550','110090560','110090570',
           '110090580','110090590','110090600','110090610','110090620','110090630','110090640','110090650','110090660','110090670','110090680','110090690',
           '110090700','110090710','110090720','110090730','110090740','110090750','110090760','110090770','110090780','110090790','110090800','110090810',
           '110090820','110090830','110090840','110090850','110090860','110090870','110090880','110090890','110090900','110090910','110090920','110090930',
           '110090940','110090950','110090960','110090970','110090980','110090990','110091000','110091010','110091020','110091030','110091040','110091050',
           '110091060','110091070','110091080','110091090','110091100','110091110','110091120','110091130','110091140','110091150','110091160','110091170');

    FOR k in 1.. transactionPereachType LOOP



        FOR i IN 1.. shopsCode.COUNT LOOP

            getShopDetails(shopsCode(i), merchantSiaCode, branchSiaCode, posType );
            getRandomDateAndTime(transactionDateTime, transactionDate, transactionTime);
            generateAmountAndOperationType(signValue, transactionAmount, transactionCurrency, operationType );
            getCardTypeAndFI(fiNumber, cardType);

            terminalCode      := generateRandomInteger(2);
            posNo             := generateRandomInteger(3);
            panNumber         := generatePan();
            rrnCode           := generateRandomString(12);
            receiptCode       := null;
            authorizationCode := generateRandomInteger(6);
            resultCode        := generateRandomInteger(3);
            terminalID        := generateRandomInteger(8);
            shortShopCode     := SUBSTR(shopsCode(i),2,7);
            shortPan          := SUBSTR(panNumber, LENGTH(panNumber) - 3, 4);
            additionalData    := null;

            INSERT INTO IB_TEST3_TRANSACTION_OBJ.T_AUTHORIZED_TRANSACTION (MESSAGE_TYPE,SHOP_CODE,TERMINAL_CODE,MERCHANT_SIA_CODE,BRANCH_SIA_CODE,POS_NO,PAN,TRANSACTION_DATE,TRANSACTION_TIME,TRANSACTION_DATETIME,
                        FI_NUMBER,SIGN,TRANSACTION_AMOUNT,TRANSACTION_CURRENCY,RRN,RECEIPT,AUTHORIZATION_CODE,RESULT_CODE,TERMINAL_ID,SHORT_SHOP_CODE
                        ,SHORT_PAN,OPERATION_TYPE,CARD_BRAND,ADDITIONAL_DATA,POS_TYPE)

            VALUES ('MAP', shopsCode(i), terminalCode, merchantSiaCode, branchSiaCode, posNo, panNumber, TO_DATE(transactionDate,'DD/MM/YYYY'), transactionTime, transactionDateTime,
                    fiNumber, signValue, transactionAmount, transactionCurrency, rrnCode, receiptCode, authorizationCode, resultCode, terminalID, shortShopCode,
                    shortPan, operationType, cardType, additionalData, posType  );

        END LOOP;


        FOR n IN 1.. shopsCode.COUNT LOOP

            getShopDetails(shopsCode(n), merchantSiaCode, branchSiaCode, posType );
            generateAmountAndOperationType(signValue, transactionAmount, transactionCurrency, operationType );
            getRandomDateAndTime(transactionDateTime, transactionDate, transactionTime);
            getCardTypeAndFI(fiNumber, cardType);

            transactionCurrency := '978';
            terminalCode        := null;
            rrnCode             := '000000000000';
            receiptCode         := generateRandomString(3);
            posNo               := generateRandomInteger(3);
            panNumber           := generatePan();
            authorizationCode   := generateRandomString(6);
            resultCode          := null;
            terminalID          := generateRandomString(8);
            shortShopCode       := SUBSTR(shopsCode(n),2,7);
            shortPan            := SUBSTR(panNumber, LENGTH(panNumber) - 3, 4);
            additionalData      := null;

            INSERT INTO IB_TEST3_TRANSACTION_OBJ.T_AUTHORIZED_TRANSACTION (MESSAGE_TYPE,SHOP_CODE,TERMINAL_CODE,MERCHANT_SIA_CODE,BRANCH_SIA_CODE,POS_NO,PAN,TRANSACTION_DATE,TRANSACTION_TIME,TRANSACTION_DATETIME,
                                                                     FI_NUMBER,SIGN,TRANSACTION_AMOUNT,TRANSACTION_CURRENCY,RRN,RECEIPT,AUTHORIZATION_CODE,RESULT_CODE,TERMINAL_ID,SHORT_SHOP_CODE
                ,SHORT_PAN,OPERATION_TYPE,CARD_BRAND,ADDITIONAL_DATA,POS_TYPE)

            VALUES ('PNZ', shopsCode(n), terminalCode, merchantSiaCode, branchSiaCode, posNo, panNumber, TO_DATE(transactionDate,'DD/MM/YYYY'), transactionTime, transactionDateTime,
                    fiNumber, signValue, ABS(transactionAmount), transactionCurrency, rrnCode, receiptCode, authorizationCode, resultCode, terminalID, shortShopCode,
                    shortPan, operationType, cardType, additionalData, posType  );
        END LOOP;
    END LOOP;

    INSERT INTO IB_TEST3_TRANSACTION_OBJ.T_AUTHORIZED_TRANSACTION (MESSAGE_TYPE,SHOP_CODE,TERMINAL_CODE,MERCHANT_SIA_CODE,BRANCH_SIA_CODE,POS_NO,PAN,TRANSACTION_DATE,TRANSACTION_TIME,TRANSACTION_DATETIME,FI_NUMBER,SIGN,
                                                             TRANSACTION_AMOUNT,TRANSACTION_CURRENCY,RRN,RECEIPT,AUTHORIZATION_CODE,RESULT_CODE,TERMINAL_ID,SHORT_SHOP_CODE,SHORT_PAN,OPERATION_TYPE,CARD_BRAND,ADDITIONAL_DATA,POS_TYPE)
    VALUES ('MAP','110090050','11','3554443','07770','370','913091*********1055',to_date('04-AUG-19','DD-MON-RR'),143520,to_timestamp('04-AUG-19 02.35.20.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),
            '1777',1,1001.01,'978','1W1W1W1W1W1W',null,'998877','RES','SINGLE','1009005','1055','01','PAGOBANCOMAT',null,'V');

    INSERT INTO IB_TEST3_TRANSACTION_OBJ.T_AUTHORIZED_TRANSACTION (MESSAGE_TYPE,SHOP_CODE,TERMINAL_CODE,MERCHANT_SIA_CODE,BRANCH_SIA_CODE,POS_NO,PAN,TRANSACTION_DATE,TRANSACTION_TIME,TRANSACTION_DATETIME,FI_NUMBER,SIGN,
                                                             TRANSACTION_AMOUNT,TRANSACTION_CURRENCY,RRN,RECEIPT,AUTHORIZATION_CODE,RESULT_CODE,TERMINAL_ID,SHORT_SHOP_CODE,SHORT_PAN,OPERATION_TYPE,CARD_BRAND,ADDITIONAL_DATA,POS_TYPE)
    VALUES ('MAP','110090050','11','3554443','07770','370','913091*********1892',to_date('03-AUG-19','DD-MON-RR'),143520,to_timestamp('03-AUG-19 02.35.20.000000000 PM',
        'DD-MON-RR HH.MI.SSXFF AM'),'1777',1,1001.01,'978','1A1A1A1A',null,'112233','RES','DATETR','1009005','1055','01','PAGOBANCOMAT',null,'V');

    INSERT INTO IB_TEST3_TRANSACTION_OBJ.T_AUTHORIZED_TRANSACTION (MESSAGE_TYPE,SHOP_CODE,TERMINAL_CODE,MERCHANT_SIA_CODE,BRANCH_SIA_CODE,POS_NO,PAN,TRANSACTION_DATE,TRANSACTION_TIME,TRANSACTION_DATETIME,FI_NUMBER,SIGN,
                                                             TRANSACTION_AMOUNT,TRANSACTION_CURRENCY,RRN,RECEIPT,AUTHORIZATION_CODE,RESULT_CODE,TERMINAL_ID,SHORT_SHOP_CODE,SHORT_PAN,OPERATION_TYPE,CARD_BRAND,ADDITIONAL_DATA,POS_TYPE)
    VALUES ('PNZ','110090050',null,'3554443','07770','370','262189*********7250',to_date('01-AUG-19','DD-MON-RR'),000020,to_timestamp('01-AUG-19 12.00.20.000000000 AM',
        'DD-MON-RR HH.MI.SSXFF AM'),'1777',-1,-260.95,'840','000000000000','YYY','998877',null,'MULTIPLE','1009005','7250','04','PAGOBANCOMAT',null,'V');

    INSERT INTO IB_TEST3_TRANSACTION_OBJ.T_AUTHORIZED_TRANSACTION (MESSAGE_TYPE,SHOP_CODE,TERMINAL_CODE,MERCHANT_SIA_CODE,BRANCH_SIA_CODE,POS_NO,PAN,TRANSACTION_DATE,TRANSACTION_TIME,TRANSACTION_DATETIME,FI_NUMBER,SIGN,
                                                             TRANSACTION_AMOUNT,TRANSACTION_CURRENCY,RRN,RECEIPT,AUTHORIZATION_CODE,RESULT_CODE,TERMINAL_ID,SHORT_SHOP_CODE,SHORT_PAN,OPERATION_TYPE,CARD_BRAND,ADDITIONAL_DATA,POS_TYPE)
    VALUES ('MAP','110090050','11','3554443','07770','370','913091*********5005',to_date('08-AUG-19','DD-MON-RR'),163520,to_timestamp('08-AUG-19 04.35.20.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),
            '1777',1,1001.01,'978','1W1W1W1W1W1W',null,'998877','RES','MULTIPLE','1009005','5005','01','JCB',null,'V');

END;

/
--------------------------------------------------------
--  DDL for Procedure ADD_TRANSACTIONS_AUTOMATION
--------------------------------------------------------
set define off;

CREATE OR REPLACE EDITIONABLE PROCEDURE "IB_TEST3_TRANSACTION_OBJ"."ADD_TRANSACTIONS_AUTOMATION"

    IS
    currency VARCHAR(5) := '840';
    TYPE lists IS VARRAY(50) OF VARCHAR(10);
    tr_type lists := lists('01', '10', '12', '50', '51', '52', '53', '54', '55', '56', '90', '91'); -- total count list = 12
    refound lists := lists ('02', '04', '11');
    card_type lists := lists ('01', '02','03','04','05','44','51','71','92','99','B','C2','D4','E6','M1','M3','M4','M5','V1','V3','V4','V5'); --total 23 --fist 14 number
    shop_list lists := lists('110090030', '110090040', '110090050');

    current_month_date VARCHAR2(10) := TO_CHAR(CURRENT_DATE - 1, 'dd/mm/yy');
    prev_month_date VARCHAR2(10) := TO_CHAR(ADD_MONTHS(CURRENT_DATE - 1, -1), 'dd/mm/yy');

BEGIN

    FOR i IN 1 .. shop_list.count LOOP
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '29/05/19',  150.55  , 10.50  , 5.78  , 1478  , currency, card_type(1),  tr_type(1)   ,  00   , 00 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '29/05/19',  -20.78  , 10.50  , 5.78  , 7890  , currency, card_type(22), refound(1)   ,  01   , 01 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '29/05/19',  328.42  , 10.50  , 5.78  , 4569  , currency, card_type(15), tr_type(2)   ,  20   , 02 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '29/05/19',   78.22  , 10.50  , 5.78  , 7890  , currency, card_type(3),  tr_type(3)   ,  22   , 22 );

        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '28/05/19', 1057.48  , 10.50  , 6.25  , 1234  , currency, card_type(1),  tr_type(1)   ,  03   , 13 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '28/05/19',  227.48  , 10.50  , 6.25  , 4596  , currency, card_type(15), tr_type(2)   ,  04   , 10 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '28/05/19',   77.48  , 10.50  , 6.25  , 2345  , currency, card_type(4),  tr_type(4)   ,  16   , 43 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '28/05/19', -227.48  , 10.50  , 6.25  , 2345  , currency, card_type(22), refound(2)   ,  11   , 10 );

        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '27/05/19', 2024.73  , 11.50  , 5.25  , 1234  , currency, card_type(1),  tr_type(1)   ,  02   , 00 );

        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '26/05/19',  124.73  , 11.50  , 5.25  , 1596  , currency, card_type(16), tr_type(2)   ,  05   , 50 );

        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '25/05/19',   24.73  , 11.50  , 5.25  , 8254  , currency, card_type(5),  tr_type(5)   ,  06   , 15 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '25/05/19', -147.73  , 11.50  , 5.25  , 9735  , currency, card_type(21), refound(3)   ,  07   , 59 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '25/05/19', 1727.48  , 11.50  , 5.25  , 1973  , currency, card_type(6),  tr_type(1)   ,  08   , 33 );

        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '24/05/19',   24.73  , 11.50  , 5.25  , 4347  , currency, card_type(7),  tr_type(6)   ,  09   , 46 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '24/05/19', 1057.48  , 10.50  , 6.25  , 1239  , currency, card_type(8),  tr_type(1)   ,  10   , 24 );

        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '23/05/19',  124.73  , 11.50  , 5.25  , 1596  , currency, card_type(16), tr_type(2)   ,  11   , 13 );

        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '22/05/19',  4952.96 ,  25.47 , 62.34 , 7990  , currency, card_type(6), tr_type(2)   ,  12   , 05 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '22/05/19',  -408.31 ,  3.93  , 56.43 , 6903  , currency, card_type(7), refound(3)   ,  13   , 17 );

        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '21/05/19',  8637.69 ,  63.67 , 15.19 , 5496  , currency,  card_type(8), tr_type(1)   ,  14   , 23 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '21/05/19',  8069.13 ,  22.43 , 58.32 , 4256  , currency,  card_type(9), tr_type(10)   ,  15   , 51 );

        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '20/05/19',  2484.47 ,  72.72 , 6.82  , 5501  , currency, card_type(8),  tr_type(2)   ,  16   , 27 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '20/05/19',  -415.14 ,  64.47 , 11.43 , 5954  , currency, card_type(10), refound(1)   ,  17   , 06 );

        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '19/05/19',  -19.26  ,  21.57 , 35.04 , 1800  , currency, card_type(11), refound(2)   ,  18   , 34 );

        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '18/05/19',  8837.33 ,  56.26 , 41.61 , 3010  , currency, card_type(12),  tr_type(2)   ,  19   , 26 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '18/05/19',  2390.41 ,  10.09 , 78.40 , 6543  , currency, card_type(13),  tr_type(9)   ,  20   , 50 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '18/05/19',  1892.47 ,  68.82 , 71.66 , 6697  , currency, card_type(14),  tr_type(8)   ,  21   , 37 );

        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '17/05/19',  1755.57 ,  22.52 , 38.82 , 7830  , currency, card_type(15),  tr_type(7)   ,  22   , 48 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '17/05/19',  2388.51 ,  84.89 , 16.97 , 3670  , currency, card_type(16),  refound(2)   ,  23   , 58 );


        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '16/05/19',  3273.87 ,  86.04 , 20.01 , 3646  , currency, card_type(17),  tr_type(1)   ,  00   , 00 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '16/05/19',  5911.04 ,  76.99 , 16.11 , 7120  , currency, card_type(18),  tr_type(2)   ,  01   , 10 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '16/05/19',  -195.63 ,  6.31  , 69.28 , 1993  , currency, card_type(19),  refound(2)   ,  02   , 23 );

        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '15/05/19',  1144.24 ,  17.07 , 78.01 , 9565  , currency, card_type(20),  tr_type(1)   ,  03   , 34 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '15/05/19',  -305.97 ,  52.64 , 99.82 , 9115  , currency, card_type(21),  refound(2)   ,  04   , 48 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '15/05/19',  7090.68 ,  67.11 , 49.50 , 5034  , currency, card_type(22),  tr_type(6)   ,  05   , 18 );

        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '14/05/19',  2527.94 ,  79.23 , 14.99 , 7734  , currency,  card_type(22) ,  tr_type(2)   ,  00   , 00 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '14/05/19',  -1569.50,  64.98 , 96.75 , 5351  , currency,  card_type(19) ,  refound(1)   ,  00   , 00 );

        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '13/05/19',  8247.69 ,  73.17 , 92.36 , 3449  , currency,  card_type(20),  tr_type(1)   ,  00   , 00 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '13/05/19',  9057.06 ,  3.32  , 37.61 , 6316  , currency,  card_type(9) ,  tr_type(11)   ,  00   , 00 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '13/05/19',  2274.83 ,  77.19 , 76.86 , 1903  , currency,  card_type(8) ,  tr_type(2)   ,  00   , 00 );

        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '12/05/19',  -120.27 ,  45.03 , 66.86 , 8391  , currency,  card_type(19),  refound(1)   ,  00   , 00 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '12/05/19',  1713.65 ,  87.07 , 56.81 , 2353  , currency,  card_type(18),  tr_type(8)   ,  00   , 00 );

        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '11/05/19',  -711.57 ,  12.84 , 27.35 , 4575  , currency,  card_type(17),  refound(2)   ,  00   , 00 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '11/05/19',  1708.72 ,  96.95 , 26.54 , 1714  , currency,  card_type(16),  tr_type(2)   ,  00   , 00 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '11/05/19',  9519.88 ,  61.57 , 7.36  , 1366  , currency,  card_type(15),  tr_type(7)   ,  00   , 00 );

        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '10/05/19',  8848.03 ,  93.68 , 8.30  , 1529  , currency,  card_type(14),  tr_type(8)   ,  00   , 00 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '10/05/19',  1725.47 ,  97.45 , 30.62 , 9245  , currency,  card_type(15),  tr_type(7)   ,  00   , 00 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '10/05/19',  -736.64 ,  6.41  , 56.27 , 1025  , currency,  card_type(16),  refound(3)   ,  00   , 00 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '10/05/19',  3829.72 ,  89.19 , 17.07 , 8143  , currency,  card_type(17),  tr_type(1)   ,  00   , 00 );

        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '09/05/19',  9251.79 ,  23.51 , 31.44 , 1592  , currency,  card_type(22),  tr_type(2)   ,  00   , 00 );

        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '08/05/19',  -387.57 ,  27.31 , 99.97 , 8596  , currency,  card_type(19),  refound(2)   ,  00   , 00 );

        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '07/05/19',  5841.08 ,  5.49  , 11.47 , 8371  , currency,  card_type(20),  tr_type(1)   ,  00   , 00 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '07/05/19',  -28.01  ,  55.24 , 61.43 , 9352  , currency,  card_type(1) ,  refound(2)   ,  00   , 00 );

        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '06/05/19',  1713.65 ,  87.07 , 56.81 , 2353  , currency,  card_type(5) ,  tr_type(1)   ,  00   , 00 );

        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '05/05/19',	7228.07  ,  36.43 , 94.36 , 3152  ,  currency,  card_type(6) ,  tr_type(2)   ,  00   , 00 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '05/05/19',	-232.99  ,  6.94  , 85.94 , 4360  ,  currency,  card_type(2) ,  refound(3)   ,  00   , 00 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '05/05/19',	486.93   ,  50.97 , 96.24 , 2008  ,  currency,  card_type(3) ,  tr_type(1)   ,  00   , 00 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '05/05/19',	1104.31  ,  38.38 , 46.78 , 2826  ,  currency,  card_type(4) ,  tr_type(12)   ,  00   , 00 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '05/05/19', 4689.77   ,  62.18 , 59.74 , 1400  ,  currency,  card_type(1) ,  tr_type(6)   ,  00   , 00 );

        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '04/05/19', 5371.75  ,  6.62  , 83.59 , 4632  ,  currency,  card_type(10),  tr_type(1)   ,  00   , 00 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '04/05/19', -750.93  ,  39.19 , 48.26 , 6150  ,  currency,  card_type(11),  refound(2)   ,  00   , 00 );

        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '03/05/19', 7559.99  ,  89.59 , 61.52 , 5184  ,  currency,  card_type(12),  tr_type(2)   ,  00   , 00 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '03/05/19', 4847.92  ,  54.63 , 88.32 , 8407  ,  currency,  card_type(13),  tr_type(5)   ,  00   , 00 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '03/05/19', 3158.21  ,  17.42 , 10.56 , 9722  ,  currency,  card_type(14),  tr_type(4)   ,  00   , 00 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '03/05/19', 6032.95  ,  51.16 , 84.32 , 3458  ,  currency,  card_type(15),  tr_type(3)   ,  00   , 00 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '03/05/19', -169.01  ,  73.57 , 61.09 , 1850  ,  currency,  card_type(16),  refound(3)   ,  00   , 00 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '03/05/19',  997.85  ,  29.34 , 95.93 , 8348  ,  currency,  card_type(17),  tr_type(1)   ,  00   , 00 );

        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '01/05/19', 1775.82  ,  99.94 , 34.27 , 1821  ,  currency,  card_type(18),  tr_type(8)   ,  00   , 00 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '01/05/19', -677.83  ,  48.70 , 14.99 , 4021  ,  currency,  card_type(19),  refound(2)   ,  00   , 00 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '01/05/19', 2492.40  ,  21.99 , 96.75 , 7977  ,  currency,  card_type(22),  tr_type(1)   ,  00   , 00 );

--04 month

        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '30/04/19',  328.42  , 10.50  , 5.78  , 4569  , currency, card_type(15), tr_type(2)   ,  00   , 00 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '30/04/19',   78.22  , 10.50  , 5.78  , 7890  , currency, card_type(3),  tr_type(3)   ,  00   , 00 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '30/04/19', 1057.48  , 10.50  , 6.25  , 1234  , currency, card_type(1),  tr_type(1)   ,  00   , 00 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '30/04/19',  227.48  , 10.50  , 6.25  , 4596  , currency, card_type(15), tr_type(2)   ,  00   , 00 );

        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '29/04/19',  150.55  , 10.50  , 5.78  , 1478  , currency, card_type(1) ,  tr_type(1)   ,  00   , 00 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '29/04/19',  -20.78  , 10.50  , 5.78  , 7890  , currency, card_type(21), refound(1)   ,  00   , 00 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '29/04/19',  328.42  , 10.50  , 5.78  , 4569  , currency, card_type(15), tr_type(2)   ,  00   , 00 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '29/04/19',   78.22  , 10.50  , 5.78  , 7890  , currency, card_type(3) ,  tr_type(3)   ,  00   , 00 );

        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '28/04/19', 1057.48  , 10.50  , 6.25  , 1234  , currency, card_type(1) ,  tr_type(1)   ,  00   , 00 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '28/04/19',  227.48  , 10.50  , 6.25  , 4596  , currency, card_type(15), tr_type(2)   ,  00   , 00 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '28/04/19',   77.48  , 10.50  , 6.25  , 2345  , currency, card_type(4) ,  tr_type(4)   ,  00   , 00 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '28/04/19', -227.48  , 10.50  , 6.25  , 2345  , currency, card_type(20), refound(2)   ,  00   , 00 );

        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '27/04/19', 2024.73  , 11.50  , 5.25  , 1234  , currency, card_type(1) ,  tr_type(1)   ,  00   , 00 );

        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '26/04/19',  124.73  , 11.50  , 5.25  , 1596  , currency, card_type(16), tr_type(2)   ,  00   , 00 );

        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '25/04/19',   24.73  , 11.50  , 5.25  , 8254  , currency, card_type(5) ,  tr_type(5)   ,  00   , 00 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '25/04/19', -147.73  , 11.50  , 5.25  , 9735  , currency, card_type(19), refound(3)   ,  00   , 00 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '25/04/19', 1727.48  , 11.50  , 5.25  , 1973  , currency, card_type(6) ,  tr_type(1)   ,  00   , 00 );

        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '24/04/19',   24.73  , 11.50  , 5.25  , 4347  , currency, card_type(7) ,  tr_type(6)   ,  00   , 00 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '24/04/19', 1057.48  , 10.50  , 6.25  , 1239  , currency, card_type(8) ,  tr_type(1)   ,  00   , 00 );

        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '23/04/19',  124.73  , 11.50  , 5.25  , 1596  , currency, card_type(16), tr_type(2)   ,  00   , 00 );

        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '22/04/19',  4952.96 ,  25.47 , 62.34 , 7990  , currency, card_type(6) , tr_type(2)   ,  00   , 00 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '22/04/19',  -408.31 ,  3.93  , 56.43 , 6903  , currency, card_type(7) , refound(3)   ,  00   , 00 );

        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '21/04/19',  8637.69 ,  63.67 , 15.19 , 5496  , currency,  card_type(8), tr_type(1)   ,  00   , 00 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '21/04/19',  8069.13 ,  22.43 , 58.32 , 4256  , currency,  card_type(9), tr_type(10)   ,  00   , 00 );

        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '20/04/19',  2484.47 ,  72.72 , 6.82  , 5501  , currency, card_type(8) ,  tr_type(2)   ,  00   , 00 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '20/04/19',  -415.14 ,  64.47 , 11.43 , 5954  , currency, card_type(10), refound(1)   ,  00   , 00 );

        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '19/04/19',  -19.26  ,  21.57 , 35.04 , 1800  , currency, card_type(11), refound(2)   ,  00   , 00 );

        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '18/04/19',  8837.33 ,  56.26 , 41.61 , 3010  , currency,  card_type(12),  tr_type(2)   ,  00   , 00 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '18/04/19',  2390.41 ,  10.09 , 78.40 , 6543  , currency,  card_type(13),  tr_type(9)   ,  00   , 00 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '18/04/19',  1892.47 ,  68.82 , 71.66 , 6697  , currency,  card_type(14),  tr_type(8)   ,  00   , 00 );

        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '17/04/19',  1755.57 ,  22.52 , 38.82 , 7830  , currency, card_type(15),  tr_type(7)   ,  00   , 00 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '17/04/19',  2388.51 ,  84.89 , 16.97 , 3670  , currency, card_type(16),  refound(2)   ,  00   , 00 );


        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '16/04/19',  3273.87 ,  86.04 , 20.01 , 3646  , currency, card_type(17),  tr_type(1)   ,  00   , 00 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '16/04/19',  5911.04 ,  76.99 , 16.11 , 7120  , currency, card_type(18),  tr_type(2)   ,  00   , 00 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '16/04/19',  -195.63 ,  6.31  , 69.28 , 1993  , currency, card_type(19),  refound(2)   ,  00   , 00 );

        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '15/04/19',  1144.24 ,  17.07 , 78.01 , 9565  , currency, card_type(20),  tr_type(1)   ,  00   , 00 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '15/04/19',  -305.97 ,  52.64 , 99.82 , 9115  , currency, card_type(21),  refound(2)   ,  00   , 00 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '15/04/19',  7090.68 ,  67.11 , 49.50 , 5034  , currency, card_type(22),  tr_type(6)   ,  00   , 00 );

        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '14/04/19',  2527.94 ,  79.23 , 14.99 , 7734  , currency,  card_type(22) ,  tr_type(2)   ,  00   , 00 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '14/04/19',  -1569.50,  64.98 , 96.75 , 5351  , currency,  card_type(22) ,  refound(1)   ,  00   , 00 );

        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '13/04/19',  8247.69 ,  73.17 , 92.36 , 3449  , currency,  card_type(20),  tr_type(1)   ,  00   , 00 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '13/04/19',  9057.06 ,  3.32  , 37.61 , 6316  , currency,  card_type(9) ,  tr_type(11)   ,  00   , 00 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '13/04/19',  2274.83 ,  77.19 , 76.86 , 1903  , currency,  card_type(8) ,  tr_type(2)   ,  00   , 00 );

        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '12/04/19',  -120.27 ,  45.03 , 66.86 , 8391  , currency,  card_type(19),  refound(1)   ,  00   , 00 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '12/04/19',  1713.65 ,  87.07 , 56.81 , 2353  , currency,  card_type(11),  tr_type(8)   ,  00   , 00 );

        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '11/04/19',  -711.57 ,  12.84 , 27.35 , 4575  , currency,  card_type(12),  refound(2)   ,  00   , 00 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '11/04/19',  1708.72 ,  96.95 , 26.54 , 1714  , currency,  card_type(13),  tr_type(2)   ,  00   , 00 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '11/04/19',  9519.88 ,  61.57 , 7.36  , 1366  , currency,  card_type(14),  tr_type(7)   ,  00   , 00 );

        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '10/04/19',  8848.03 ,  93.68 , 8.30  , 1529  , currency,  card_type(14),  tr_type(12)   ,  00   , 00 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '10/04/19',  1725.47 ,  97.45 , 30.62 , 9245  , currency,  card_type(15),  tr_type(7)   ,  00   , 00 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '10/04/19',  -736.64 ,  6.41  , 56.27 , 1025  , currency,  card_type(16),  refound(3)   ,  00   , 00 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '10/04/19',  3829.72 ,  89.19 , 17.07 , 8143  , currency,  card_type(17),  tr_type(1)   ,  00   , 00 );

        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '09/04/19',  9251.79 ,  23.51 , 31.44 , 1592  , currency,  card_type(22),  tr_type(2)   ,  00   , 00 );

        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '08/04/19',  -387.57 ,  27.31 , 99.97 , 8596  , currency,  card_type(19),  refound(2)   ,  00   , 00 );

        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '07/04/19',  5841.08 ,  5.49  , 11.47 , 8371  , currency,  card_type(20),  tr_type(1)   ,  00   , 00 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '07/04/19',  -28.01  ,  55.24 , 61.43 , 9352  , currency,  card_type(1) ,  refound(2)   ,  00   , 00 );

        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '06/04/19',  1713.65 ,  87.07 , 56.81 , 2353  , currency,  card_type(5) ,  tr_type(1)   ,  00   , 00 );

        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '05/04/19',	7228.07  ,  36.43 , 94.36 , 3152  ,  currency,  card_type(6) ,  tr_type(2)   ,  00   , 00 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '05/04/19',	-232.99  ,  6.94  , 85.94 , 4360  ,  currency,  card_type(2) ,  refound(3)   ,  00   , 00 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '05/04/19',	486.93   ,  50.97 , 96.24 , 2008  ,  currency,  card_type(3) ,  tr_type(1)   ,  00   , 00 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '05/04/19',	1104.31  ,  38.38 , 46.78 , 2826  ,  currency,  card_type(4) ,  tr_type(7)   ,  00   , 00 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '05/04/19', 4689.77  ,  62.18 , 59.74 , 1400  ,  currency,  card_type(1) ,  tr_type(6)   ,  00   , 00 );

        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '04/04/19', 5371.75  ,  6.62  , 83.59 , 4632  ,  currency,  card_type(10),  tr_type(1)   ,  00   , 00 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '04/04/19', -750.93  ,  39.19 , 48.26 , 6150  ,  currency,  card_type(11),  refound(2)   ,  00   , 00 );

        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '03/04/19', 7559.99  ,  89.59 , 61.52 , 5184  ,  currency,  card_type(12),  tr_type(2)   ,  00   , 00 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '03/04/19', 4847.92  ,  54.63 , 88.32 , 8407  ,  currency,  card_type(13),  tr_type(5)   ,  00   , 00 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '03/04/19', 3158.21  ,  17.42 , 10.56 , 9722  ,  currency,  card_type(14),  tr_type(4)   ,  00   , 00 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '03/04/19', 6032.95  ,  51.16 , 84.32 , 3458  ,  currency,  card_type(15),  tr_type(3)   ,  00   , 00 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '03/04/19', -169.01  ,  73.57 , 61.09 , 1850  ,  currency,  card_type(16),  refound(3)   ,  00   , 00 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '03/04/19',  997.85  ,  29.34 , 95.93 , 8348  ,  currency,  card_type(17),  tr_type(1)   ,  00   , 00 );

        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '01/04/19', 1775.82  ,  99.94 , 34.27 , 1821  ,  currency,  card_type(18),  tr_type(8)   ,  00   , 00 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '01/04/19', -677.83  ,  48.70 , 14.99 , 4021  ,  currency,  card_type(19),  refound(2)   ,  00   , 00 );
        IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (shop_list(i), '01/04/19', 2492.40  ,  21.99 , 96.75 , 7977  ,  currency,  card_type(22),  tr_type(1)   ,  00   , 00 );

    END LOOP;

-- positive increase for amount and negative for card used vs previous month shop 9006
    IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (110090060, current_month_date   , 775.82    ,  0.94 , 0.27 , 1888  ,  currency,  card_type(18),  '01'   ,  00   , 00 );
    IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (110090060, current_month_date   , 75.82     ,  0.94 , 0.27 , 1888  ,  currency,  card_type(18),  '10'   ,  00   , 00 );
    IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (110090060, current_month_date   , 5.82      ,  0.94 , 0.27 , 1118  ,  currency,  card_type(18),  '90'   ,  00   , 00 );
    IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (110090060, prev_month_date      , -100.83   ,  0.70 , 0.99 , 4021  ,  currency,  card_type(19),  '02'   ,  00   , 00 );
    IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (110090060, prev_month_date      , -10.83    ,  0.70 , 0.99 , 1118  ,  currency,  card_type(19),  '04'   ,  00   , 00 );
    IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (110090060, prev_month_date      , -10.83    ,  0.70 , 0.99 , 4021  ,  currency,  card_type(19),  '11'   ,  00   , 00 );
    IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (110090060, prev_month_date      ,  10.83    ,  0.70 , 0.99 , 4021  ,  currency,  card_type(19),  '01'   ,  00   , 00 );
    IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (110090060, prev_month_date      ,  10.83    ,  0.70 , 0.99 , 1888  ,  currency,  card_type(19),  '01'   ,  00   , 00 );

-- positive increase for card used and negative for amount vs previous month shop 9007
    IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (110090070, prev_month_date         , 775.82    ,  0.94 , 0.27 , 1888  ,  currency,  card_type(18),  '01'   ,  00   , 00 );
    IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (110090070, prev_month_date         , 75.82     ,  0.94 , 0.27 , 1888  ,  currency,  card_type(18),  '10'   ,  00   , 00 );
    IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (110090070, prev_month_date         , 5.82      ,  0.94 , 0.27 , 1118  ,  currency,  card_type(18),  '90'   ,  00   , 00 );
    IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (110090070, current_month_date      , -100.83   ,  0.70 , 0.99 , 4021  ,  currency,  card_type(19),  '02'   ,  00   , 00 );
    IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (110090070, current_month_date      , -10.83    ,  0.70 , 0.99 , 1118  ,  currency,  card_type(19),  '04'   ,  00   , 00 );
    IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (110090070, current_month_date      , -10.83    ,  0.70 , 0.99 , 4021  ,  currency,  card_type(19),  '11'   ,  00   , 00 );
    IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (110090070, current_month_date      ,  10.83    ,  0.70 , 0.99 , 3021  ,  currency,  card_type(19),  '01'   ,  00   , 00 );
    IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (110090070, current_month_date      ,  10.83    ,  0.70 , 0.99 , 1888  ,  currency,  card_type(19),  '01'   ,  00   , 00 );

-- no increase for both amount and card used vs previous month shop 9008
    IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (110090080, current_month_date   , 775.82    ,  0.94 , 0.27 , 1888  ,  currency,  card_type(18),  '01'   ,  00   , 00 );
    IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (110090080, current_month_date   , -75.82    ,  0.94 , 0.27 , 1188  ,  currency,  card_type(18),  '11'   ,  00   , 00 );
    IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (110090080, prev_month_date      , 775.82    ,  0.70 , 0.99 , 1188  ,  currency,  card_type(19),  '01'   ,  00   , 00 );
    IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION (110090080, prev_month_date      , -75.82    ,  0.70 , 0.99 , 1118  ,  currency,  card_type(19),  '11'   ,  00   , 00 );

    --add transactions for test commission account L for shop 9009
    IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION ('110090090', '31/05/19',   79.13  ,  10.22  , 58.32 , 1256  , 978,  '01', '56'  ,  00   , 01 );
    IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION ('110090090', '30/05/19',   150.52 ,   2.43  ,  8.32 , 4212  , 978,  '01', '01'  ,  00   , 10 );
    IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION ('110090090', '29/05/19',   49.49  ,    2.43 ,  8.32 , 4212  , 978,  '01', '01'  ,  00   , 10 );

    IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION ('110090090', '30/06/19',   79.13  ,  17.33  , 58.32 , 1256  , 978,  '01', '56'  ,  00   , 01 );
    IB_TEST3_TRANSACTION_OBJ.ADD_1_TRANSACTION_AUTOMATION ('110090090', '29/06/19',   250.52 ,   2.43  ,  8.32 , 4212  , 978,  '01', '01'  ,  00   , 10 );
END;

/
--------------------------------------------------------
--  DDL for Procedure DELETE_TRANSACTIONS_AUTOMATION
--------------------------------------------------------
set define off;

CREATE OR REPLACE EDITIONABLE PROCEDURE "IB_TEST3_TRANSACTION_OBJ"."DELETE_TRANSACTIONS_AUTOMATION"

    IS
BEGIN
    DELETE FROM IB_TEST3_TRANSACTION_OBJ.T_TRANSACTION WHERE shop_code IN
    ('110090000','110090010','110090020','110090030','110090040','110090050','110090060','110090070','110090080','110090090',
     '110090100','110090110','110090120','110090130','110090140','110090150','110090160','110090170','110090180','110090190','110090200','110090210',
     '110090220','110090230','110090240','110090250','110090260','110090270','110090280','110090290','110090300','110090310','110090320','110090330',
     '110090340','110090350','110090360','110090370','110090380','110090390','110090400','110090410','110090420','110090430','110090440','110090450',
     '110090460','110090470','110090480','110090490','110090500','110090510','110090520','110090530','110090540','110090550','110090560','110090570',
     '110090580','110090590','110090600','110090610','110090620','110090630','110090640','110090650','110090660','110090670','110090680','110090690',
     '110090700','110090710','110090720','110090730','110090740','110090750','110090760','110090770','110090780','110090790','110090800','110090810',
     '110090820','110090830','110090840','110090850','110090860','110090870','110090880','110090890','110090900','110090910','110090920','110090930',
     '110090940','110090950','110090960','110090970','110090980','110090990','110091000','110091010','110091020','110091030','110091040','110091050',
     '110091060','110091070','110091080','110091090','110091100','110091110','110091120','110091130','110091140','110091150','110091160','110091170');
    DELETE FROM IB_TEST3_TRANSACTION_OBJ.T_AUTHORIZED_TRANSACTION WHERE shop_code IN
     ('110090000','110090010','110090020','110090030','110090040','110090050','110090060','110090070','110090080','110090090',
     '110090100','110090110','110090120','110090130','110090140','110090150','110090160','110090170','110090180','110090190','110090200','110090210',
      '110090220','110090230','110090240','110090250','110090260','110090270','110090280','110090290','110090300','110090310','110090320','110090330',
      '110090340','110090350','110090360','110090370','110090380','110090390','110090400','110090410','110090420','110090430','110090440','110090450',
      '110090460','110090470','110090480','110090490','110090500','110090510','110090520','110090530','110090540','110090550','110090560','110090570',
      '110090580','110090590','110090600','110090610','110090620','110090630','110090640','110090650','110090660','110090670','110090680','110090690',
      '110090700','110090710','110090720','110090730','110090740','110090750','110090760','110090770','110090780','110090790','110090800','110090810',
      '110090820','110090830','110090840','110090850','110090860','110090870','110090880','110090890','110090900','110090910','110090920','110090930',
      '110090940','110090950','110090960','110090970','110090980','110090990','110091000','110091010','110091020','110091030','110091040','110091050',
      '110091060','110091070','110091080','110091090','110091100','110091110','110091120','110091130','110091140','110091150','110091160','110091170');
END;

/
