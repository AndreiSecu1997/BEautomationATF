DECLARE
  TYPE user_name IS VARRAY(50) OF VARCHAR(50); -- 31 users
  user_name_list user_name := user_name('h_ikea_c3a9s28', 'h_mcdon_c3a9s30', 'c_ikeait_a3s16', 'c_ikeaswd_a3s6', 'c_ikeasp_a3s6', 'c_mcdonca_a3s16',
                                        'c_mcdonjp_a3s6', 'c_mcdonnd_a3s6','a_bologna_s2', 'a_pisa_s11', 'a_malmo_s2', 'a_hansa_s2', 'a_stokholm_s2',
                                        'a_malaga_s2', 'a_murcia_s2', 'a_seville_s2', 'a_montreal_s11', 'a_toronto_s2', 'a_quebec_s3','a_osaka_s2',
                                        'a_tokyo_s2','a_boke_s2', 'a_rotterdam_s2', 'a_amsterdam_s2', 'a_haarlem_s4', 's_bologna_n', 's_bologna_l',
                                        's_pisa_l', 's_pisa_n', 's_florence_l', 's_florence_n' );

  TYPE shop_name IS VARRAY(100) OF VARCHAR(50);
  shop_name_list shop_name:= shop_name('Bologna 1','Bologna 2','Pisa 1','Pisa 2','Pisa 3','Pisa 4','Pisa 5','Pisa 6','Pisa 7','Pisa 8','Pisa 9','Pisa 10',
                                        'Pisa 11','Florence 1','Florence 2','Florence 3','Malmo 1','Malmo 2','Hansa 1','Hansa 2','Stokholm 1','Stokholm 2',
                                        'Malaga 1','Malaga 2','Murcia 1','Murcia 2','Seville 1','Seville 2','Montreal 1','Montreal 2','Montreal 3',
                                        'Montreal 4','Montreal 5','Montreal 6','Montreal 7','Montreal 8','Montreal 9','Montreal 10','Montreal 11',
                                        'Toronto 1','Toronto 2','Quebec 1','Quebec 2','Quebec 3','Osaka 1','Osaka 2','Tokyo 1','Tokyo 2','Kobe 1','Kobe 2',
                                        'Rotterdam 1','Rotterdam 2','Amsterdam 1','Amsterdam 2','Haarlem 1','Haarlem 2','Haarlem 3','Haarlem 4');

  TYPE holding IS VARRAY(50) OF VARCHAR(50);
  holding_list holding := holding ('105','106','9999999999');
  holding_names holding:= holding ('IKEA', 'Mcdonalds', 'SENZA HOLDING');

  TYPE currencie IS VARRAY(50) OF NUMBER;
  currencie_list currencie := currencie ('978', '826', '840', '756', '752', '643', '784', '682', '36', '392', '124');

  TYPE company IS VARRAY(50) OF VARCHAR(50);
  company_list company := company ('1001','2002','3003','4004','5005','6006','9999999999');
  company_names company := company ('IKEA Italy', 'IKEA Sweden', 'IKEA Spain', 'McDonalds Canada', 'McDonalds Japan', 'McDonalds Netherlands', 'SENZA HOLDING');

  TYPE area IS VARRAY(50) OF VARCHAR(50);
  area_list area := area('113000010', '113000050', '000000000', '113000170', '010101010', '113000210', '113000230', '020202020', '113000270', '113000310', '030303030', '113000420',
                         '113000450', '040404040', '113000490', '113000510', '050505050', '113000550' );

  TYPE carpet_type IS VARRAY(50) OF VARCHAR(2);
  carpet_type_list carpet_type := carpet_type ('SI','ST', 'GO');
  TYPE shopProvince IS VARRAY(50) OF VARCHAR(3);
  shopProvinceList shopProvince := shopProvince ('TO','AO','CN','BI','AT','GE','SV','IM','MI','SCV','VA','CO','SO','LC','BG','BS','CR');
  TYPE postIndex IS VARRAY(50) OF VARCHAR(10);
  postIndexList postIndex := postIndex ('30121','37142','43100','81100','40141','20162');

  main_shop INTEGER;
  fiscal_id VARCHAR(16);
  vat_id VARCHAR(14);
  abi_code VARCHAR(5);
  cab_code VARCHAR(5);
  posno_code NUMBER;
  legal NUMBER;
  hold_accredit NUMBER;
  first_name VARCHAR(20);
  last_name VARCHAR(20);
  birthday DATE;
  place VARCHAR(24);
  sex VARCHAR(1);
  shop_address VARCHAR(32);
  shop_location VARCHAR(24);
  shop_post_index VARCHAR(10);
  shop_province VARCHAR(3);
  u_nationality VARCHAR(3);
  merchant_sia VARCHAR(7);
  pos_type VARCHAR(2);
  branch_sia VARCHAR(5);
  auth_transactions  NUMBER;
  shop_mcc  VARCHAR(5);
  pos_issued VARCHAR(5);
  additional NUMBER;
  ec VARCHAR(1);
  deleted NUMBER;

  shop_currencies NUMBER;
  commissionAccounting VARCHAR(1);
  shop_email VARCHAR(60);
  shop_landline_phone VARCHAR(17);
  shop_mobile_phone VARCHAR(17);
  carpet_start_date DATE;
  carpet_end_date DATE;
  carpet_propriety VARCHAR(1);
  carpet_merchant_category VARCHAR(3);
  carpet_dedicated_phone VARCHAR(22);
  user_level VARCHAR(2);
  u_last_name VARCHAR(20);
  u_first_name VARCHAR(20);


  FUNCTION generateRandomString (stringLength IN INTEGER) return VARCHAR
  AS
    val VARCHAR(50);
  BEGIN
    val := DBMS_RANDOM.STRING('U',stringLength);
    RETURN     val;
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
  FUNCTION generateFirstName  return VARCHAR
  AS
    TYPE names IS VARRAY(50) OF VARCHAR(30);
    names_list names := names('Gregorio', 'Lorenzo', 'Marco', 'Mario', 'Martino', 'Massimo', 'Matteo', 'Maurizio', 'Mauro',
                              'Nevio', 'Norberto', 'Fabrizia', 'Federica', 'Francesca', 'Gabriella', 'Gianna', 'Giovanna');
    val VARCHAR(100);
  BEGIN
    val := names_list(DBMS_RANDOM.VALUE(1, names_list.COUNT));
    return val;
  END;
  FUNCTION generateLastName  return VARCHAR
  AS
    TYPE names IS VARRAY(50) OF VARCHAR(30);
    lastName_list names := names('Russo','Ferrari','Cancio','Bianchi','Alfonsi','Romano','Colombo','Ricci','Marino','Greco','Bruno','Gallo',
                                 'Conti','Luca', 'Mancini', 'Costa', 'Giordano', 'Rizzo', 'Lombardi', 'Moretti');
    val VARCHAR(100);
  BEGIN
    val := lastName_list(DBMS_RANDOM.VALUE(1, lastName_list.COUNT));
    return val;
  END;
  FUNCTION generatePlace  return VARCHAR
  AS
    TYPE names IS VARRAY(50) OF VARCHAR(30);
    place_list names := names ( 'Rome', 'Lazio', 'Piemonte', 'Valle d’Aosta', 'Liguria', 'Lombardy', 'Venice', 'Tuscany', 'Umbria', 'Le Marche', 'Sicily', 'Sardinia');
    val VARCHAR(50);
  BEGIN
    val := place_list(DBMS_RANDOM.VALUE(1, place_list.COUNT));
    return val;
  END;
  FUNCTION generateShopAddress return VARCHAR
  AS
    TYPE names IS VARRAY(50) OF VARCHAR(30);
    place_list names := names ( 'Rome', 'Lazio', 'Piemonte', 'Valle d’Aosta', 'Liguria', 'Lombardy', 'Venice', 'Tuscany', 'Umbria', 'Le Marche', 'Sicily', 'Sardinia');
    val VARCHAR(50);
  BEGIN
    val := 'Via ' || place_list(ROUND(DBMS_RANDOM.VALUE(1, place_list.COUNT))) || '  ' || TO_CHAR(ROUND(DBMS_RANDOM.VALUE(100, 999)));
    return val;
  END;
  FUNCTION generateShopLocation return VARCHAR
  AS
    TYPE names IS VARRAY(50) OF VARCHAR(30);
    place_list names := names ( 'Rome', 'Lazio', 'Piemonte', 'Valle d’Aosta', 'Liguria', 'Lombardy', 'Venice', 'Tuscany', 'Umbria', 'Le Marche', 'Sicily', 'Sardinia');
    val VARCHAR(50);
  BEGIN
    val := 'Regioni ' || place_list(ROUND(DBMS_RANDOM.VALUE(1, place_list.COUNT)));
    return val;
  END;
  FUNCTION generateNationality return VARCHAR
  AS
    TYPE names IS VARRAY(50) OF VARCHAR(30);
    nationality_names names := names('FR','DE','MD','IT','RO','RU');
    val VARCHAR(50);
  BEGIN
    val :=  nationality_names(DBMS_RANDOM.VALUE(1, nationality_names.COUNT));
    return val;
  END;
  FUNCTION generateMcc return VARCHAR
  AS
    TYPE names IS VARRAY(100) OF VARCHAR(50);
    val VARCHAR(50);
  BEGIN
    SELECT MCC INTO val
    FROM (SELECT MCC  FROM IB_TEST2_MERCHANT_OBJ.T_MCC_CATEGORY ORDER BY DBMS_RANDOM.VALUE)
    WHERE ROWNUM = 1;
    return val;
  END;
  FUNCTION generateCurrencie (currencie_list IN currencie) return VARCHAR
  AS
    val VARCHAR(50);
  BEGIN
    val :=  currencie_list(DBMS_RANDOM.VALUE(1, currencie_list.COUNT));
    return val;
  END;
    FUNCTION generateProvince return VARCHAR
    AS
        val VARCHAR(50);
    BEGIN
        val :=  shopProvinceList(DBMS_RANDOM.VALUE(1, shopProvinceList.COUNT));
        return val;
    END;
    FUNCTION generatePostIndex return VARCHAR
    AS
        val VARCHAR(50);
    BEGIN
        val :=  postIndexList(DBMS_RANDOM.VALUE(1, postIndexList.COUNT));
        return val;
    END;
  PROCEDURE setHoldingCode (holding_list IN holding, holding_names IN holding )
  AS
  BEGIN
    --SET HOLDINGS for SHOPS
    UPDATE IB_TEST2_MERCHANT_OBJ.T_SHOP SET HOLDING_CODE = holding_list(1) WHERE SHOP_CODE BETWEEN 113000010 AND 113000280;
    UPDATE IB_TEST2_MERCHANT_OBJ.T_SHOP SET HOLDING_CODE = holding_list(2) WHERE SHOP_CODE BETWEEN 113000280 AND 113000560;
    UPDATE IB_TEST2_MERCHANT_OBJ.T_SHOP SET HOLDING_CODE = holding_list(3) WHERE SHOP_CODE BETWEEN 113000570 AND 113000580;
  END;
  PROCEDURE setCompanyAndRedCarpetProperty (company_list IN company, company_names IN company, carpet_type_list IN carpet_type)
  AS
  BEGIN
    --SET COMPANY_CODE, COMPANY_NAME and RED_CARPET PROPRIETY
    UPDATE IB_TEST2_MERCHANT_OBJ.T_SHOP SET COMPANY_CODE = company_list(1), COMPANY_NAME = company_names(1), RED_CARPET_PROPRIETY = 'N'
    WHERE SHOP_CODE BETWEEN 113000010 AND 113000160;
    UPDATE IB_TEST2_MERCHANT_OBJ.T_SHOP SET COMPANY_CODE = company_list(2), COMPANY_NAME = company_names(2), RED_CARPET_PROPRIETY = 'T'
    WHERE SHOP_CODE BETWEEN 113000170 AND 113000220;
    UPDATE IB_TEST2_MERCHANT_OBJ.T_SHOP SET COMPANY_CODE = company_list(3), COMPANY_NAME = company_names(3), RED_CARPET_PROPRIETY = 'N'
    WHERE SHOP_CODE BETWEEN 113000230 AND 113000280;
    UPDATE IB_TEST2_MERCHANT_OBJ.T_SHOP SET COMPANY_CODE = company_list(4), COMPANY_NAME = company_names(4), RED_CARPET_PROPRIETY = 'T'
    WHERE SHOP_CODE BETWEEN 113000290 AND 113000440;
    UPDATE IB_TEST2_MERCHANT_OBJ.T_SHOP SET COMPANY_CODE = company_list(5), COMPANY_NAME = company_names(5), RED_CARPET_PROPRIETY = 'N'
    WHERE SHOP_CODE BETWEEN 113000450 AND 113000500;
    UPDATE IB_TEST2_MERCHANT_OBJ.T_SHOP SET COMPANY_CODE = company_list(6), COMPANY_NAME = company_names(6), RED_CARPET_PROPRIETY = 'T'
    WHERE SHOP_CODE BETWEEN 113000510 AND 113000560;
    UPDATE IB_TEST2_MERCHANT_OBJ.T_SHOP SET COMPANY_CODE = company_list(7), COMPANY_NAME = company_names(7), RED_CARPET_PROPRIETY = 'N'
    WHERE SHOP_CODE BETWEEN 113000570 AND 113000580;
  END;
  PROCEDURE setAreaCodeCurrencieRedCarpetType (area_list IN area, currencie_list IN currencie)
  AS
  BEGIN
    --SET AREA _CODE, CURRENCIES, RED_CARPET_TYPE
    UPDATE IB_TEST2_MERCHANT_OBJ.T_SHOP SET AREA_CODE = area_list(1), CURRENCIES = currencie_list(1) , RED_CARPET_TYPE = carpet_type_list(1)
    WHERE SHOP_CODE IN (113000010,113000020);
    UPDATE IB_TEST2_MERCHANT_OBJ.T_SHOP SET AREA_CODE = area_list(2), CURRENCIES = currencie_list(2) , RED_CARPET_TYPE = carpet_type_list(2)
    WHERE SHOP_CODE BETWEEN 113000030 AND 113000130 ;
    UPDATE IB_TEST2_MERCHANT_OBJ.T_SHOP SET AREA_CODE = area_list(3), CURRENCIES = currencie_list(3) , RED_CARPET_TYPE = carpet_type_list(3)
    WHERE SHOP_CODE BETWEEN 113000140 AND 113000160 ;
    UPDATE IB_TEST2_MERCHANT_OBJ.T_SHOP SET AREA_CODE = area_list(4), CURRENCIES = currencie_list(4) , RED_CARPET_TYPE = carpet_type_list(1)
    WHERE SHOP_CODE BETWEEN 113000170 AND 113000180 ;
    UPDATE IB_TEST2_MERCHANT_OBJ.T_SHOP SET AREA_CODE = area_list(5), CURRENCIES = currencie_list(5) , RED_CARPET_TYPE = carpet_type_list(2)
    WHERE SHOP_CODE BETWEEN 113000190 AND 113000200 ;
    UPDATE IB_TEST2_MERCHANT_OBJ.T_SHOP SET AREA_CODE = area_list(6), CURRENCIES = currencie_list(6) , RED_CARPET_TYPE = carpet_type_list(3)
    WHERE SHOP_CODE BETWEEN 113000210 AND 113000220 ;
    UPDATE IB_TEST2_MERCHANT_OBJ.T_SHOP SET AREA_CODE = area_list(7), CURRENCIES = currencie_list(7) , RED_CARPET_TYPE = carpet_type_list(1)
    WHERE SHOP_CODE BETWEEN 113000230 AND 113000240 ;
    UPDATE IB_TEST2_MERCHANT_OBJ.T_SHOP SET AREA_CODE = area_list(8), CURRENCIES = currencie_list(8) , RED_CARPET_TYPE = carpet_type_list(2)
    WHERE SHOP_CODE BETWEEN 113000250 AND 113000260 ;
    UPDATE IB_TEST2_MERCHANT_OBJ.T_SHOP SET AREA_CODE = area_list(9), CURRENCIES = currencie_list(9) , RED_CARPET_TYPE = carpet_type_list(3)
    WHERE SHOP_CODE BETWEEN 113000270 AND 113000280 ;
    UPDATE IB_TEST2_MERCHANT_OBJ.T_SHOP SET AREA_CODE = area_list(10), CURRENCIES = currencie_list(10) , RED_CARPET_TYPE = carpet_type_list(1)
    WHERE SHOP_CODE BETWEEN 113000290 AND 113000390 ;
    UPDATE IB_TEST2_MERCHANT_OBJ.T_SHOP SET AREA_CODE = area_list(11), CURRENCIES = currencie_list(11) , RED_CARPET_TYPE = carpet_type_list(2)
    WHERE SHOP_CODE BETWEEN 113000400 AND 113000410 ;
    UPDATE IB_TEST2_MERCHANT_OBJ.T_SHOP SET AREA_CODE = area_list(12), CURRENCIES = currencie_list(1) , RED_CARPET_TYPE = carpet_type_list(3)
    WHERE SHOP_CODE BETWEEN 113000420 AND 113000440 ;
    UPDATE IB_TEST2_MERCHANT_OBJ.T_SHOP SET AREA_CODE = area_list(13), CURRENCIES = currencie_list(2) , RED_CARPET_TYPE = carpet_type_list(1)
    WHERE SHOP_CODE BETWEEN 113000450 AND 113000460 ;
    UPDATE IB_TEST2_MERCHANT_OBJ.T_SHOP SET AREA_CODE = area_list(14), CURRENCIES = currencie_list(3) , RED_CARPET_TYPE = carpet_type_list(2)
    WHERE SHOP_CODE BETWEEN 113000470 AND 113000480 ;
    UPDATE IB_TEST2_MERCHANT_OBJ.T_SHOP SET AREA_CODE = area_list(15), CURRENCIES = currencie_list(4) , RED_CARPET_TYPE = carpet_type_list(3)
    WHERE SHOP_CODE BETWEEN 113000490 AND 113000500 ;
    UPDATE IB_TEST2_MERCHANT_OBJ.T_SHOP SET AREA_CODE = area_list(16), CURRENCIES = currencie_list(5) , RED_CARPET_TYPE = carpet_type_list(1)
    WHERE SHOP_CODE BETWEEN 113000510 AND 113000520 ;
    UPDATE IB_TEST2_MERCHANT_OBJ.T_SHOP SET AREA_CODE = area_list(17), CURRENCIES = currencie_list(6) , RED_CARPET_TYPE = carpet_type_list(2)
    WHERE SHOP_CODE BETWEEN 113000530 AND 113000540 ;
    UPDATE IB_TEST2_MERCHANT_OBJ.T_SHOP SET AREA_CODE = area_list(18), CURRENCIES = currencie_list(7) , RED_CARPET_TYPE = carpet_type_list(3)
    WHERE SHOP_CODE BETWEEN 113000550 AND 113000560 ;
    UPDATE IB_TEST2_MERCHANT_OBJ.T_SHOP SET AREA_CODE = area_list(18), CURRENCIES = currencie_list(8) , RED_CARPET_TYPE = carpet_type_list(1)
    WHERE SHOP_CODE BETWEEN 113000570 AND 113000580 ;
  END;
  PROCEDURE setPostType
  AS
  BEGIN
    UPDATE IB_TEST2_MERCHANT_OBJ.T_SHOP SET POS_TYPE = '02' WHERE SHOP_CODE IN (113000010,113000030,113000040,113000060,113000070,113000090,113000100,113000120,113000130,
                                                                                113000150,113000170,113000190,113000200,113000220,113000230,113000250,113000260,113000280);
    UPDATE IB_TEST2_MERCHANT_OBJ.T_SHOP SET POS_TYPE = '15' WHERE SHOP_CODE IN (113000290,113000320,113000330,113000350,113000360,113000380,113000390,113000400,113000410,113000430,113000450,
                                                                                113000470,113000480,113000500,113000510,113000530,113000540,113000560);
    UPDATE IB_TEST2_MERCHANT_OBJ.T_SHOP SET POS_TYPE = 'P5' WHERE SHOP_CODE IN (113000020,113000050,113000080,113000110,113000140,113000160,113000180,113000210,113000240,113000270);
    UPDATE IB_TEST2_MERCHANT_OBJ.T_SHOP SET POS_TYPE = '11' WHERE SHOP_CODE IN (113000300,113000310,113000340,113000370,113000420,113000440,113000460,113000490,113000520,113000550,113000570,113000580);
  END;
  PROCEDURE setCommisionAccountingL
  AS
  BEGIN
    UPDATE IB_TEST2_MERCHANT_OBJ.T_SHOP SET COMMISSION_ACCOUNTING = 'L' WHERE SHOP_CODE IN (113000020,113000060,113000080,113000110,113000150,
                                                                                            113000180,113000220,113000240,113000280,113000300,113000320,113000340,113000370,113000430,113000460,113000500,113000520,113000530,113000550);
  END;
  PROCEDURE insertUsers (user_name_list IN user_name)
  AS
    u_first_name VARCHAR(50);
    u_last_name VARCHAR(50);
  BEGIN
    FOR i IN 1 .. user_name_list.COUNT LOOP
      u_first_name := 'first ' || user_name_list(i);
      u_last_name  := 'last name ' || user_name_list(i);
      IF i IN (1,2) THEN user_level := 'L1'; END IF;
      IF i BETWEEN 3 AND 8 THEN user_level := 'L2'; END IF;
      IF i BETWEEN 9 AND 25 THEN user_level := 'L3'; END IF;
      IF i BETWEEN 26 AND 31 THEN user_level := 'L4'; END IF;
      INSERT INTO IB_TEST2_MERCHANT_OBJ.T_USER (USERNAME, PASSWORD, FIRST_NAME, LAST_NAME, STATUS, EMAIL, USER_LEVEL, LANGUAGE, TERMS_AND_CONDITIONS)
      VALUES (user_name_list(i)||'@gmail.com' ,'1c98decf10a5c1ce3737a5bdd84eec316775e6dc4c03bc6b4178c9e57c7b9e44710763940e31e4be',
              u_first_name , u_last_name ,'ENABLED', 'end.intesatest+' || user_name_list(i) || '@gmail.com',user_level,'it_IT',1);
      INSERT INTO IB_TEST2_MERCHANT_OBJ.T_SEC_USER_GROUP (USER_ID, GROUP_ID)
      VALUES ((SELECT ID FROM IB_TEST2_MERCHANT_OBJ.t_user WHERE username = user_name_list(i)||'@gmail.com'),2);
    END LOOP;
  END;
  PROCEDURE setGrantsForHolding (user_name_list IN user_name, holding_list IN holding )
  AS
  BEGIN
    INSERT INTO IB_TEST2_MERCHANT_OBJ.T_USER_GRANT (user_id, code, code_type)
    VALUES ((SELECT ID FROM IB_TEST2_MERCHANT_OBJ.T_USER WHERE username = user_name_list(1)||'@gmail.com'), holding_list(1), 'HOLDING');
    INSERT INTO IB_TEST2_MERCHANT_OBJ.T_HOLDING ( HOLDING_CODE, NAME)
    VALUES (holding_list(1), holding_names(1) );
    INSERT INTO IB_TEST2_MERCHANT_OBJ.T_USER_GRANT (user_id, code, code_type)
    VALUES ((SELECT ID FROM IB_TEST2_MERCHANT_OBJ.t_user WHERE username = user_name_list(2)||'@gmail.com'), holding_list(2), 'HOLDING');
    INSERT INTO IB_TEST2_MERCHANT_OBJ.T_HOLDING ( HOLDING_CODE, NAME)
    VALUES (holding_list(2), holding_names(2) );
  END;
  PROCEDURE setCompanyGrantHolding1 (user_name_list IN user_name, holding_list IN holding, company_list IN company )
  AS
  BEGIN
    INSERT INTO IB_TEST2_MERCHANT_OBJ.T_USER_GRANT (user_id, code, code2, code_type)
    VALUES ( (SELECT ID FROM IB_TEST2_MERCHANT_OBJ.T_USER WHERE username = user_name_list(3)||'@gmail.com'), company_list(1) ,holding_list(1), 'COMPANY');
    INSERT INTO IB_TEST2_MERCHANT_OBJ.T_COMPANY (COMPANY_CODE, HOLDING_CODE, NAME)
    VALUES (company_list(1), holding_list(1), company_names(1));

    INSERT INTO IB_TEST2_MERCHANT_OBJ.T_USER_GRANT (user_id, code, code2, code_type)
    VALUES ( (SELECT ID FROM IB_TEST2_MERCHANT_OBJ.T_USER WHERE username = user_name_list(4)||'@gmail.com'), company_list(2) ,holding_list(1), 'COMPANY');
    INSERT INTO IB_TEST2_MERCHANT_OBJ.T_COMPANY (COMPANY_CODE, HOLDING_CODE, NAME)
    VALUES (company_list(2), holding_list(1), company_names(2));

    INSERT INTO IB_TEST2_MERCHANT_OBJ.T_USER_GRANT (user_id, code, code2, code_type)
    VALUES ( (SELECT ID FROM IB_TEST2_MERCHANT_OBJ.T_USER WHERE username = user_name_list(5)||'@gmail.com'), company_list(3) ,holding_list(1), 'COMPANY');
    INSERT INTO IB_TEST2_MERCHANT_OBJ.T_COMPANY (COMPANY_CODE, HOLDING_CODE, NAME)
    VALUES (company_list(3), holding_list(1), company_names(3));
  END;
  PROCEDURE setCompanyGrantHolding2 (user_name_list IN user_name, holding_list IN holding, company_list IN company )
  AS
  BEGIN
    INSERT INTO IB_TEST2_MERCHANT_OBJ.T_USER_GRANT (user_id, code, code2, code_type)
    VALUES ( (SELECT ID FROM IB_TEST2_MERCHANT_OBJ.T_USER WHERE username = user_name_list(6)||'@gmail.com'), company_list(4) ,holding_list(2), 'COMPANY');
    INSERT INTO IB_TEST2_MERCHANT_OBJ.T_COMPANY (COMPANY_CODE, HOLDING_CODE, NAME)
    VALUES (company_list(4), holding_list(2), company_names(4));

    INSERT INTO IB_TEST2_MERCHANT_OBJ.T_USER_GRANT (user_id, code, code2, code_type)
    VALUES ( (SELECT ID FROM IB_TEST2_MERCHANT_OBJ.T_USER WHERE username = user_name_list(7)||'@gmail.com'), company_list(5) ,holding_list(2), 'COMPANY');
    INSERT INTO IB_TEST2_MERCHANT_OBJ.T_COMPANY (COMPANY_CODE, HOLDING_CODE, NAME)
    VALUES (company_list(5), holding_list(2), company_names(5));

    INSERT INTO IB_TEST2_MERCHANT_OBJ.T_USER_GRANT (user_id, code, code2, code_type)
    VALUES ( (SELECT ID FROM IB_TEST2_MERCHANT_OBJ.T_USER WHERE username = user_name_list(8)||'@gmail.com'), company_list(6) ,holding_list(2), 'COMPANY');
    INSERT INTO IB_TEST2_MERCHANT_OBJ.T_COMPANY (COMPANY_CODE, HOLDING_CODE, NAME)
    VALUES (company_list(6), holding_list(2), company_names(6));
  END;
  PROCEDURE setAreaGrants (user_name_list IN user_name, area_list IN area)
  AS
  BEGIN
    INSERT INTO IB_TEST2_MERCHANT_OBJ.T_USER_GRANT (user_id, code, code_type) --9--25                                --17 code
    VALUES ((SELECT ID FROM IB_TEST2_MERCHANT_OBJ.T_USER WHERE username = user_name_list(9) || '@gmail.com'), area_list(1) , 'AREA');
    INSERT INTO IB_TEST2_MERCHANT_OBJ.T_USER_GRANT (user_id, code, code_type)
    VALUES ((SELECT ID FROM IB_TEST2_MERCHANT_OBJ.T_USER WHERE username = user_name_list(10) || '@gmail.com'), area_list(2) , 'AREA');
    INSERT INTO IB_TEST2_MERCHANT_OBJ.T_USER_GRANT (user_id, code, code_type)
    VALUES ((SELECT ID FROM IB_TEST2_MERCHANT_OBJ.T_USER WHERE username = user_name_list(11) || '@gmail.com'), area_list(4) , 'AREA');
    INSERT INTO IB_TEST2_MERCHANT_OBJ.T_USER_GRANT (user_id, code, code_type)
    VALUES ((SELECT ID FROM IB_TEST2_MERCHANT_OBJ.T_USER WHERE username = user_name_list(12) || '@gmail.com'), area_list(5) , 'AREA');
    INSERT INTO IB_TEST2_MERCHANT_OBJ.T_USER_GRANT (user_id, code, code_type)
    VALUES ((SELECT ID FROM IB_TEST2_MERCHANT_OBJ.T_USER WHERE username = user_name_list(13) || '@gmail.com'), area_list(6) , 'AREA');
    INSERT INTO IB_TEST2_MERCHANT_OBJ.T_USER_GRANT (user_id, code, code_type)
    VALUES ((SELECT ID FROM IB_TEST2_MERCHANT_OBJ.T_USER WHERE username = user_name_list(14) || '@gmail.com'), area_list(7) , 'AREA');
    INSERT INTO IB_TEST2_MERCHANT_OBJ.T_USER_GRANT (user_id, code, code_type)
    VALUES ((SELECT ID FROM IB_TEST2_MERCHANT_OBJ.T_USER WHERE username = user_name_list(15) || '@gmail.com'), area_list(8) , 'AREA');
    INSERT INTO IB_TEST2_MERCHANT_OBJ.T_USER_GRANT (user_id, code, code_type)
    VALUES ((SELECT ID FROM IB_TEST2_MERCHANT_OBJ.T_USER WHERE username = user_name_list(16) || '@gmail.com'), area_list(9) , 'AREA');
    INSERT INTO IB_TEST2_MERCHANT_OBJ.T_USER_GRANT (user_id, code, code_type)
    VALUES ((SELECT ID FROM IB_TEST2_MERCHANT_OBJ.T_USER WHERE username = user_name_list(17) || '@gmail.com'), area_list(10) , 'AREA');
    INSERT INTO IB_TEST2_MERCHANT_OBJ.T_USER_GRANT (user_id, code, code_type)
    VALUES ((SELECT ID FROM IB_TEST2_MERCHANT_OBJ.T_USER WHERE username = user_name_list(18) || '@gmail.com'), area_list(11) , 'AREA');
    INSERT INTO IB_TEST2_MERCHANT_OBJ.T_USER_GRANT (user_id, code, code_type)
    VALUES ((SELECT ID FROM IB_TEST2_MERCHANT_OBJ.T_USER WHERE username = user_name_list(19) || '@gmail.com'), area_list(12) , 'AREA');
    INSERT INTO IB_TEST2_MERCHANT_OBJ.T_USER_GRANT (user_id, code, code_type)
    VALUES ((SELECT ID FROM IB_TEST2_MERCHANT_OBJ.T_USER WHERE username = user_name_list(20) || '@gmail.com'), area_list(13) , 'AREA');
    INSERT INTO IB_TEST2_MERCHANT_OBJ.T_USER_GRANT (user_id, code, code_type)
    VALUES ((SELECT ID FROM IB_TEST2_MERCHANT_OBJ.T_USER WHERE username = user_name_list(21) || '@gmail.com'), area_list(14) , 'AREA');
    INSERT INTO IB_TEST2_MERCHANT_OBJ.T_USER_GRANT (user_id, code, code_type)
    VALUES ((SELECT ID FROM IB_TEST2_MERCHANT_OBJ.T_USER WHERE username = user_name_list(22) || '@gmail.com'), area_list(15) , 'AREA');
    INSERT INTO IB_TEST2_MERCHANT_OBJ.T_USER_GRANT (user_id, code, code_type)
    VALUES ((SELECT ID FROM IB_TEST2_MERCHANT_OBJ.T_USER WHERE username = user_name_list(23) || '@gmail.com'), area_list(16) , 'AREA');
    INSERT INTO IB_TEST2_MERCHANT_OBJ.T_USER_GRANT (user_id, code, code_type)
    VALUES ((SELECT ID FROM IB_TEST2_MERCHANT_OBJ.T_USER WHERE username = user_name_list(24) || '@gmail.com'), area_list(17) , 'AREA');
    INSERT INTO IB_TEST2_MERCHANT_OBJ.T_USER_GRANT (user_id, code, code_type)
    VALUES ((SELECT ID FROM IB_TEST2_MERCHANT_OBJ.T_USER WHERE username = user_name_list(25) || '@gmail.com'), area_list(18) , 'AREA');
  END;
  PROCEDURE setShopGrants (user_name_list IN user_name)
  AS
  BEGIN
    INSERT INTO IB_TEST2_MERCHANT_OBJ.T_USER_GRANT (user_id, code, code_type)
    VALUES ((SELECT ID FROM IB_TEST2_MERCHANT_OBJ.T_USER WHERE username = user_name_list(26)||'@gmail.com'), 113000010 , 'SHOP');
    INSERT INTO IB_TEST2_MERCHANT_OBJ.T_USER_GRANT (user_id, code, code_type)
    VALUES ((SELECT ID FROM IB_TEST2_MERCHANT_OBJ.T_USER WHERE username = user_name_list(27)||'@gmail.com'), 113000020 , 'SHOP');
    INSERT INTO IB_TEST2_MERCHANT_OBJ.T_USER_GRANT (user_id, code, code_type)
    VALUES ((SELECT ID FROM IB_TEST2_MERCHANT_OBJ.T_USER WHERE username = user_name_list(28)||'@gmail.com'), 113000050 , 'SHOP');
    INSERT INTO IB_TEST2_MERCHANT_OBJ.T_USER_GRANT (user_id, code, code_type)
    VALUES ((SELECT ID FROM IB_TEST2_MERCHANT_OBJ.T_USER WHERE username = user_name_list(29)||'@gmail.com'), 113000030 , 'SHOP');
    INSERT INTO IB_TEST2_MERCHANT_OBJ.T_USER_GRANT (user_id, code, code_type)
    VALUES ((SELECT ID FROM IB_TEST2_MERCHANT_OBJ.T_USER WHERE username = user_name_list(30)||'@gmail.com'), 113000140 , 'SHOP');
    INSERT INTO IB_TEST2_MERCHANT_OBJ.T_USER_GRANT (user_id, code, code_type)
    VALUES ((SELECT ID FROM IB_TEST2_MERCHANT_OBJ.T_USER WHERE username = user_name_list(31)||'@gmail.com'), 113000150 , 'SHOP');
  END;


BEGIN

  FOR k IN 1.. shop_name_list.COUNT LOOP

    main_shop         := 0;                                  --LATER IS UPDATED ACCORDINGLY
    fiscal_id         := generateRandomInteger(16);
    vat_id            := generateRandomInteger(14);
    abi_code          := generateRandomInteger(5);
    cab_code          := generateRandomInteger(5);
    posno_code        := generateRandomInteger(4);
    legal             := generateRandomInteger(3);
    hold_accredit     := generateRandomInteger(1);
    first_name        := generateFirstName();
    last_name         := generateLastName();
    birthday          := (CURRENT_DATE - generateRandomInteger(4));
    place             := generatePlace();
    sex               := 'M';
    shop_address      := generateShopAddress();
    shop_location     := generateShopLocation();
    shop_post_index   := generatePostIndex();
    shop_province     := generateProvince();
    u_nationality     := generateNationality();
    merchant_sia      := generateRandomInteger(7);
    pos_type          := '02';                              --LATER IS UPDATED for specific shops
    branch_sia        := generateRandomInteger(5);
    auth_transactions := generateRandomInteger(1);
    shop_mcc          := generateMcc();
    pos_issued        := generateRandomInteger(5);
    additional        := generateRandomInteger(1);
    ec                := 'Y';                                          --can be 'N' value
    deleted           := 0;
    shop_currencies   := generateCurrencie(currencie_list);
    commissionAccounting := 'N';                                  -- later is updated to L for specific shops
    shop_email        := 'end.intesatest+' || first_name || last_name || '@gmail.com';
    shop_landline_phone := '+39' || generateRandomInteger(9);
    shop_mobile_phone := shop_landline_phone;
    carpet_start_date := (CURRENT_DATE - generateRandomInteger(3));
    carpet_end_date   := (CURRENT_DATE + generateRandomInteger(3));
    carpet_propriety  := 'T';                                   ---LATER IS UPDATED ACCORDINGLY
    carpet_merchant_category  := generateRandomInteger(3);
    carpet_dedicated_phone    := shop_landline_phone;

    INSERT INTO IB_TEST2_MERCHANT_OBJ.T_SHOP(SHOP_CODE, HOLDING_CODE, COMPANY_CODE, AREA_CODE, IS_AREA_MAIN_SHOP, COMPANY_NAME, NAME,
                                             FISCAL_CODE,VAT_NUMBER,ABI,CAB,POSNO,LEGAL_FORM,HOLDING_ACCREDIT,LR_FIRST_NAME,LR_LAST_NAME,LR_BIRTHDAY_DATE,
                                             LR_PLACE_OF_BIRTH,LR_SEX,ADDRESS,LOCATION,POST_INDEX,PROVINCE,NATIONALITY,MERCHANT_SIA_CODE,BRANCH_SIA_CODE,
                                             POS_TYPE,HAS_AUTH_TRANSACTIONS,MCC,POS_ISSUED_CODE,ADDITIONAL_DATA,PRODUCE_EC,IS_DELETED,SHOP_ALIAS,CURRENCIES,
                                             COMMISSION_ACCOUNTING,EMAIL,LANDLINE_PHONE,MOBILE_PHONE,RED_CARPET_TYPE,RED_CARPET_START_DATE,
                                             RED_CARPET_END_DATE,RED_CARPET_PROPRIETY,RED_CARPET_MERCHANT_CATEGORY,RED_CARPET_DEDICATED_PHONE)
    VALUES (113000000 + (k*10), '9999999999', '9999999999', '000000000', main_shop, company_names(1), shop_name_list(k), fiscal_id, vat_id, abi_code,
            cab_code, posno_code, legal, hold_accredit,first_name, last_name, birthday, place, sex, shop_address, shop_location, shop_post_index,
            shop_province, u_nationality, merchant_sia, branch_sia, pos_type, auth_transactions, shop_mcc, pos_issued, additional, ec, deleted,
            shop_name_list(k), shop_currencies,  commissionAccounting, shop_email,  shop_landline_phone, shop_mobile_phone, carpet_type_list(1),
            carpet_start_date,carpet_end_date,carpet_propriety,carpet_merchant_category, carpet_dedicated_phone);

  END LOOP;

  setHoldingCode(holding_list, holding_names);
  setCompanyAndRedCarpetProperty(company_list,company_names, carpet_type_list );
  setAreaCodeCurrencieRedCarpetType(area_list, currencie_list);

  --SET IS_AREA_MAIN_SHOP
  UPDATE IB_TEST2_MERCHANT_OBJ.T_SHOP SET IS_AREA_MAIN_SHOP = 1 WHERE AREA_CODE = SHOP_CODE;

  --SET POS_TYPE
  setPostType();
  --SET COMMISSION_ACCOUNTING
  setCommisionAccountingL();

  --insert Users and Grants
  insertUsers(user_name_list);
  setGrantsForHolding(user_name_list, holding_list);
  setCompanyGrantHolding1(user_name_list, holding_list, company_list);
  setCompanyGrantHolding2(user_name_list, holding_list, company_list);
  setAreaGrants(user_name_list, area_list);
  setShopGrants(user_name_list);

END;

--BIG USER
-- DECLARE
--
--     gr_id1 varchar(9):= '330033';
--     start_shop_id varchar(9) := 3000;
--     post_type_counter int := 1;
--     mcc_id varchar(5);
--     post_id varchar(2);
--
--
-- --COMMISSION_ACCOUNTING N = 1; L = 2 ;
--
-- BEGIN
--
--     FOR i IN 0 .. 355 LOOP
--
--         INSERT INTO IB_TEST2_MERCHANT_OBJ.T_SHOP (shop_code, holding_code, company_code, area_code,    is_area_main_shop, pos_type,  mcc,   ADDRESS,                                   name,                 shop_alias,         company_name,        fiscal_code,       vat_number,  PRODUCE_EC ,COMMISSION_ACCOUNTING)
--         VALUES (start_shop_id + i,   gr_id1 , '1999999999' , '000000000' , 0,                 '02',  '03763',' Milan, Viale  '|| i, 'smart store ' || i, 'smart store ' || i, 'company_name_' || i, 'fisc_code_' || i, 'VAT_' || i,    'Y',          'N');
--
--     END LOOP;
--
--     --ADD USER LEVEL HOLDING gr_id1
--
--     INSERT INTO IB_TEST2_MERCHANT_OBJ.T_USER (USERNAME, PASSWORD, FIRST_NAME, LAST_NAME, STATUS, EMAIL, USER_LEVEL, LANGUAGE, TERMS_AND_CONDITIONS)
--     VALUES ('user350shops@gmail.com' ,'1c98decf10a5c1ce3737a5bdd84eec316775e6dc4c03bc6b4178c9e57c7b9e44710763940e31e4be',
--             gr_id1 || 'first_name' ,gr_id1 || 'last_name','ENABLED','end.intesatest+yser350shops@gmail.com','L1','it_IT',1);
--     INSERT INTO IB_TEST2_MERCHANT_OBJ.T_SEC_USER_GROUP (USER_ID, GROUP_ID)
--     VALUES ((SELECT ID FROM IB_TEST2_MERCHANT_OBJ.t_user WHERE username = 'user350shops@gmail.com'),2);
--     INSERT INTO IB_TEST2_MERCHANT_OBJ.T_USER_GRANT (user_id, code, code_type)
--     VALUES ((SELECT ID FROM IB_TEST2_MERCHANT_OBJ.t_user WHERE username = 'user350shops@gmail.com'), gr_id1, 'HOLDING');
--     INSERT INTO IB_TEST2_MERCHANT_OBJ.T_HOLDING ( HOLDING_CODE, NAME)
--     VALUES ('330033', '330033' || ' group');
--     INSERT INTO IB_TEST2_MERCHANT_OBJ.T_COMPANY (COMPANY_CODE, HOLDING_CODE, NAME)
--     VALUES ('1999999999', gr_id1, '1999999999' || 'subgroup');
--
--
-- END