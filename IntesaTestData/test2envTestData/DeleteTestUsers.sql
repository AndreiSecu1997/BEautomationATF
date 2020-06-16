DECLARE
  TYPE user_name IS VARRAY(50) OF VARCHAR(50); -- 31 users
  user_name_list user_name := user_name('h_ikea_c3a9s28', 'h_mcdon_c3a9s30', 'c_ikeait_a3s16', 'c_ikeaswd_a3s6', 'c_ikeasp_a3s6', 'c_mcdonca_a3s16',
                                        'c_mcdonjp_a3s6', 'c_mcdonnd_a3s6','a_bologna_s2', 'a_pisa_s11', 'a_malmo_s2', 'a_hansa_s2', 'a_stokholm_s2',
                                        'a_malaga_s2', 'a_murcia_s2', 'a_seville_s2', 'a_montreal_s11', 'a_toronto_s2', 'a_quebec_s3','a_osaka_s2',
                                        'a_tokyo_s2','a_boke_s2', 'a_rotterdam_s2', 'a_amsterdam_s2', 'a_haarlem_s4', 's_bologna_n', 's_bologna_l',
                                        's_pisa_l', 's_pisa_n', 's_florence_l', 's_florence_n' );

  TYPE company IS VARRAY(50) OF VARCHAR(50);
  company_list company := company ('1001','2002','3003','4004','5005','6006');
  company_names company := company ('IKEA Italy', 'IKEA Sweden', 'IKEA Spain', 'McDonalds Canada', 'McDonalds Japan', 'McDonalds Netherlands');

  TYPE holding IS VARRAY(50) OF VARCHAR(50);
  holding_list holding := holding ('105','106');
  holding_names holding:= holding ('IKEA', 'Mcdonalds');

BEGIN
  DELETE FROM IB_TEST2_MERCHANT_OBJ.T_SHOP WHERE SHOP_CODE BETWEEN 113000010 AND 113000580;
  FOR i IN 1..user_name_list.COUNT LOOP
    DELETE FROM IB_TEST2_MERCHANT_OBJ.T_USER_GRANT WHERE USER_ID = (SELECT ID FROM IB_TEST2_MERCHANT_OBJ.T_USER
                WHERE USERNAME =  user_name_list(i) || '@gmail.com');
    DELETE FROM IB_TEST2_MERCHANT_OBJ.T_SEC_USER_GROUP WHERE USER_ID = (SELECT ID FROM IB_TEST2_MERCHANT_OBJ.T_USER
                WHERE USERNAME =  user_name_list(i) || '@gmail.com');
    DELETE FROM IB_TEST2_MERCHANT_OBJ.T_USER WHERE USERNAME =  user_name_list(i) || '@gmail.com';
  END LOOP;

  FOR i IN 1..holding_list.COUNT LOOP
    DELETE FROM IB_TEST2_MERCHANT_OBJ.T_HOLDING WHERE HOLDING_CODE = holding_list(i) AND NAME = holding_names(i);
  END LOOP;

  FOR i IN 1..company_list.COUNT LOOP
    DELETE FROM IB_TEST2_MERCHANT_OBJ.T_COMPANY WHERE COMPANY_CODE = company_list(i) AND NAME = company_names(i);
  END LOOP;
END;

