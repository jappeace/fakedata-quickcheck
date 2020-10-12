# MOVED TO https://github.com/fakedata-haskell/fakedata-quickcheck

> If the truth shall kill them, let them die.

This library allows you to make [quickcheck Generators](https://hackage.haskell.org/package/QuickCheck-2.14.1/docs/Test-QuickCheck-Gen.html#t:Gen)
out of [Fake](https://hackage.haskell.org/package/fakedata-0.8.0/docs/Faker.html#t:Fake) functions from fakedata.


```haskell
import qualified Faker.Company as CM

isDomain :: Text -> Bool
isDomain = (=~ "^[A-Za-z_]+\\.[a-z]{1,4}$") . T.unpack

spec :: Spec
spec = do
  describe "fakedata quickcheck" $
  it "forall domain fullfils is a domain name regex" $
    Q.property $ Q.forAll (fakeQuickcheck CM.domain) isDomain
```

See the full code in the tests.

---

Added to a separate project as discussed in [here](https://github.com/psibi/fakedata/pull/27)
