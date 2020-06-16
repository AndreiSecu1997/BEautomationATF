SELECT U.USERNAME, COUNT (DISTINCT S.SHOP_CODE), COUNT (DISTINCT B.AREA_CODE), COUNT (DISTINCT B.COMPANY_CODE),COUNT (DISTINCT B.HOLDING_CODE)
FROM IB_TEST2_MERCHANT_OBJ.V_USER_SHOP S
       INNER JOIN  IB_TEST2_MERCHANT_OBJ.T_USER U
                   ON S.USER_ID = U.ID
       INNER JOIN IB_TEST2_MERCHANT_OBJ.T_SEC_USER_GROUP G
                  ON U.ID = G.USER_ID
       INNER JOIN IB_TEST2_MERCHANT_OBJ.T_SHOP B
                  ON S.SHOP_ID = B.ID
WHERE G.GROUP_ID = 1 AND b.is_deleted = 0
GROUP BY U.USERNAME;

SELECT COUNT(DISTINCT a.SHOP_CODE), b.holding_code FROM IB_TEST2_MERCHANT_OBJ.T_SHOP a
               INNER JOIN IB_TEST2_MERCHANT_OBJ.T_HOLDING b
                          ON a.holding_code = b.holding_code
group by b.holding_code;

SELECT COUNT(DISTINCT HOLDING_CODE) FROM IB_TEST2_MERCHANT_OBJ.T_HOLDING;
SELECT COUNT(DISTINCT COMPANY_CODE) FROM (SELECT DISTINCT HOLDING_CODE, COMPANY_CODE FROM IB_TEST2_MERCHANT_OBJ.T_COMPANY);
SELECT COUNT(DISTINCT AREA_CODE) FROM IB_TEST2_MERCHANT_OBJ.T_SHOP;


SELECT A.holding_code, count (distinct S.shop_code) from IB_TEST2_MERCHANT_OBJ.T_SHOP S
     INNER JOIN IB_TEST2_MERCHANT_OBJ.T_HOLDING A
                ON S.Holding_code = A.holding_code
where s.is_deleted = 0
group by a.holding_code;

---- need refactor
-- INSERT INTO t_user_grant (user_id, code, code_type)
-- SELECT a.id
--      ,b.holding_code
--      ,'HOLDING'
-- FROM (SELECT id
--            ,username
--       FROM t_user
--       WHERE user_level='L0'
--         and username = 'BackofficeUser@gmail.com' )a
--          CROSS JOIN (SELECT holding_code FROM t_holding
--                      MINUS
--                      Select code from t_user_grant
--                      where user_id = (SELECT id
--                                       FROM t_user
--                                       WHERE user_level='L0'
--                                         and username = 'BackofficeUser@gmail.com' ) )b;