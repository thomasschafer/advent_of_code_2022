module Utils ((...), lpad, mapTuple, quickTrace, setAt, setAt2d, toInt, toTuple, to3Tuple, toList, withIdx, freqCounts, safeTail, groupBy, revTuple, positionsOf, positionOf) where

import Control.Arrow ((***))
import Control.Monad (join)
import Data.HashMap.Strict (HashMap)
import Data.HashMap.Strict qualified as HM
import Data.Hashable
import Data.Maybe (fromMaybe)
import Debug.Trace (trace)

withIdx :: [b] -> [(Int, b)]
withIdx l = zip [0 .. length l] l

quickTrace :: (Show a) => [Char] -> a -> a
quickTrace name value = trace (name ++ " " ++ show value) value

lpad :: a -> Int -> [a] -> [a]
lpad val n xs = replicate (n - length ys) val ++ ys
  where
    ys = take n xs

mapTuple :: (a -> b) -> (a, a) -> (b, b)
mapTuple = join (***)

toTuple :: [a] -> (a, a)
toTuple [x, y] = (x, y)

to3Tuple :: [a] -> (a, a, a)
to3Tuple (x : y : z : []) = (x, y, z)

toList :: (a, a) -> [a]
toList (a, b) = [a, b]

infixr 8 ...

(...) :: (b -> c) -> (a1 -> a2 -> b) -> a1 -> a2 -> c
f ... g = (f .) . g

setAt :: Int -> a -> [a] -> [a]
setAt idx x xs = take idx xs ++ [x] ++ drop (idx + 1) xs

setAt2d :: (Int, Int) -> a -> [[a]] -> [[a]]
setAt2d (r, c) x matrix = setAt r (setAt c x $ matrix !! r) matrix

toInt :: Char -> Int
toInt = read . (: [])

freqCounts :: (Hashable a) => [a] -> HashMap a Int
freqCounts = foldl update HM.empty
  where
    update acc x = HM.insert x (fromMaybe 0 (HM.lookup x acc) + 1) acc

safeTail :: [a] -> [a]
safeTail [] = []
safeTail (_ : xs) = xs

groupBy :: (Hashable b) => (a -> b) -> [a] -> [[a]]
groupBy f = map snd . HM.toList . foldl update HM.empty
  where
    update acc x =
      let key = f x
       in HM.insert key (x : fromMaybe [] (HM.lookup key acc)) acc

revTuple :: (a, b) -> (b, a)
revTuple (x, y) = (y, x)

positionsOf :: (a -> Bool) -> [[a]] -> [(Int, Int)]
positionsOf p grid =
  [ (r, c)
    | r <- [0 .. length grid - 1],
      c <- [0 .. length (head grid) - 1],
      p $ grid !! r !! c
  ]

positionOf :: (a -> Bool) -> [[a]] -> (Int, Int)
positionOf = (\[x] -> x) ... positionsOf
