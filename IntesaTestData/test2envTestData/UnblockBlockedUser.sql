-- UNLOCK user after 5 attepts FULL VERSION
update ib_test2_merchant_obj.t_cas_audit set is_skipped = 1
                                             -- SELECT * FROM ib_test2_merchant_obj.t_cas_audit
WHERE LOWER(aud_user) = LOWER('user6@gmail.com') AND aud_action = 'AUTHENTICATION_FAILED' AND is_skipped = 0
  AND aud_date > nvl((SELECT aud_date FROM (SELECT aud_date FROM ib_test2_merchant_obj.t_cas_audit WHERE LOWER(aud_user) = LOWER('user6@gmail.com')
  AND aud_action='AUTHENTICATION_SUCCESS' ORDER BY aud_date DESC) WHERE ROWNUM = 1), current_timestamp-numtodsinterval(10800, 'second' ));

-- UNLOCK user after 5 attepts LOW VERSION

update t_cas_audit set is_skipped = 1
WHERE LOWER(aud_user) = LOWER('user9@gmail.com') AND aud_action = 'AUTHENTICATION_FAILED' AND is_skipped = 0