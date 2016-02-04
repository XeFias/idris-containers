-- ---------------------------------------------------------------- [ Dict.idr ]
-- Module    : Dict.idr
-- Copyright : (c) Jan de Muijnck-Hughes
-- License   : see LICENSE
-- --------------------------------------------------------------------- [ EOH ]

module Data.AVL.Test.Dict

import Test.Generic
import Test.Random
import Data.AVL.Dict

%access export

kvlist1 : List (Integer, Integer)
kvlist1 = rndListIntKVU 123456789 (0,100) 20

-- ------------------------------------------------------------ [ Construction ]

testBuilding : IO ()
testBuilding = genericTest
    (Just "List, Building" )
    (Dict.size $ Dict.fromList kvlist1)
    20
    (==)


-- ---------------------------------------------------------------- [ Updating ]
partial
testUpdate : IO ()
testUpdate = genericTest
    (Just "Update")
    (Dict.toList $ Dict.update 2 (*2) $ Dict.fromList [(1,2), (2,3), (3,4), (5,3)])
    [(1,2), (2,6), (3,4), (5,3)]
    (==)

partial
testHas : IO ()
testHas = genericTest
   (Just "Has value")
   (hasValue 6 $ Dict.fromList [(1,2), (2,6), (3,4)])
   (True)
   (==)

-- ----------------------------------------------------------------- [ Queries ]
partial
testLookup : IO ()
testLookup = genericTest
    (Just "Lookup")
    (Dict.lookup 1 $ Dict.fromList [(1,2), (2,3), (3,4)])
    (Just 2)
    (==)

partial
testKVs : IO ()
testKVs = genericTest
    (Just "KV Pair Extraction")
    (keys given, values given)
    ([1,2,3], [5,6,7])
    (==)
  where
    given : Dict Int Int
    given = Dict.fromList [(1,5), (2,6), (3,7)]

partial
runTest : IO ()
runTest = do
  putStrLn "Testing Dict"
  putStrLn infoLine
  runTests [
      testBuilding
    , testLookup
    , testUpdate
    , testHas
    , testKVs
  ]

-- --------------------------------------------------------------------- [ EOF ]
