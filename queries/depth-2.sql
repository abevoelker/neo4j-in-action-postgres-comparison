SELECT
  COUNT(DISTINCT f2.user_2) AS cnt 
FROM
  t_user_friend f1 
  INNER JOIN
    t_user_friend f2 
    ON f1.user_2 = f2.user_1 
WHERE
  f1.user_1 = 1;
