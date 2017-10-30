USE origin_waimai;

-- QUERY FROM VIEW
SELECT *
FROM origin_waimai.waimai_safe_order;

SELECT binded_phone
      ,common_ext
      ,recipient_address
      ,recipient_name
      ,recipient_phone
FROM origin_waimai.waimai_safe_order;

USE origindb;

-- QUERY FROM TABLE
SELECT *
FROM origindb.waimai_order_shard__wm;

SELECT binded_phone
      ,common_ext
      ,recipient_address
      ,recipient_name
      ,recipient_phone
FROM origindb.waimai_order_shard__wm;
