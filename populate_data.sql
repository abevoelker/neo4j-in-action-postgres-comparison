DROP TABLE IF EXISTS t_user_friend;
DROP TABLE IF EXISTS t_user;

CREATE TABLE t_user (
  id bigserial PRIMARY KEY,
  name text NOT NULL
);

CREATE TABLE t_user_friend (
  id bigserial PRIMARY KEY,
  user_1 bigint NOT NULL REFERENCES t_user,
  user_2 bigint NOT NULL REFERENCES t_user
);

CREATE INDEX idx_user_friend_user_1 ON t_user_friend (user_1);
CREATE INDEX idx_user_friend_user_2 ON t_user_friend (user_2);

INSERT INTO t_user (id, name)
  SELECT x.id, substr(md5(random()::text), 0, 10)
  FROM generate_series(1,1000000) AS x(id);

INSERT INTO t_user_friend (user_1, user_2)
  SELECT  g1.x AS user_1, (1 + (random() * 999999)) :: int AS user_2
  FROM generate_series(1, 1000000) as g1(x), generate_series(1, 50) as g2(y);
