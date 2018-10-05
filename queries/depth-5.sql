SELECT
  COUNT(DISTINCT f5.user_2) AS cnt 
FROM
  t_user_friend f1 
  INNER JOIN
    t_user_friend f2 
    ON f1.user_2 = f2.user_1 
  INNER JOIN
    t_user_friend f3 
    ON f2.user_2 = f3.user_1 
  INNER JOIN
    t_user_friend f4 
    ON f3.user_2 = f4.user_1 
  INNER JOIN
    t_user_friend f5 
    ON f4.user_2 = f5.user_1 
WHERE
  f1.user_1 = 1;
