import Day16 (part1, part2)

main :: IO ()
main = do
  testData <- readFile "data/day_16_test.txt"
  realData <- readFile "data/day_16.txt"
  print $ part1 testData
  print $ part1 realData
  print $ part2 realData
