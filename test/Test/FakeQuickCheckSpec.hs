{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE OverloadedStrings #-}

module Test.FakeQuickCheckSpec
  ( spec
  )
where

import qualified Faker.Company as CM
import Faker
import Test.QuickCheck.Gen.Faker
import Data.Text (Text)
import           Text.Regex.TDFA         hiding (empty)
import qualified Data.Text as T
import qualified Faker.Internet as F
import           Test.Hspec
import qualified Test.QuickCheck as Q
import Data.Char(isAlphaNum)


isDomain :: Text -> Bool
isDomain = (=~ ddd) . T.unpack
  where
    ddd :: Text
    ddd =  "^[A-Za-z_]+\\.[a-z]{1,4}$"

spec :: Spec
spec = do
  describe "fakedata quickcheck" $
    it "forall domain fullfils is a domain name regex" $ Q.property $ Q.forAll (fakeQuickcheck domain) isDomain

domain :: Fake Text
domain = do
  suffix <- F.domainSuffix
  companyName <- CM.name
  pure $ fixupName companyName <> "." <> suffix

fixupName :: Text -> Text
fixupName = T.filter (\c -> isAlphaNum c || c == '_') . T.replace " " "_"
