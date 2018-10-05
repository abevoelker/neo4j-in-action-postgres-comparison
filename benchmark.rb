require "benchmark"
require "sequel"

DEPTH_2 = File.read("queries/depth-2.sql")
DEPTH_3 = File.read("queries/depth-3.sql")
DEPTH_4 = File.read("queries/depth-4.sql")
DEPTH_5 = File.read("queries/depth-5.sql")

DB = Sequel.connect("postgres://postgres:password@localhost:5442/graphtest")

# change 1.times to 10.times to get a better average
Benchmark.bm do |x|
  x.report("depth 2") { 1.times{ DB.run(DEPTH_2) } }
  x.report("depth 3") { 1.times{ DB.run(DEPTH_3) } }
  x.report("depth 4") { 1.times{ DB.run(DEPTH_4) } }
  x.report("depth 5") { 1.times{ DB.run(DEPTH_5) } }
end
