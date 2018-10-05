require "logger"
require "securerandom"
require "sequel"
require "tempfile"

USER_COUNT = 1000000
FRIENDS_PER_USER = 50

DB = Sequel.connect("postgres://postgres:password@localhost:5442/graphtest")
DB.loggers << Logger.new($stdout)

DB.run <<-SQL
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
SQL

Tempfile.open("t_user", "tmp") do |f|
  USER_COUNT.times do
    f.puts SecureRandom.alphanumeric(10)
  end
  f.rewind
  DB.copy_into(:t_user, columns: [:name], data: f)
end

Tempfile.open("t_user_friend", "tmp") do |f|
  USER_COUNT.times do |i|
    FRIENDS_PER_USER.times do
      user_1 = i + 1
      user_2 = SecureRandom.random_number(USER_COUNT - 1) + 1
      f.puts "#{user_1}\t#{user_2}"
    end
  end
  f.rewind
  DB.copy_into(:t_user_friend, columns: [:user_1, :user_2], data: f)
end
