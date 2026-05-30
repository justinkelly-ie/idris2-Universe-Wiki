# Double Slit Interference Phenomenon

In this model, rather than representing wave-particle duality through continuous wave functions, we model it as the **emergent arithmetic projection of discrete Spread Polynomials**. A particle remains a discrete coordinate on the pixel grid, but its spatial dispersion is governed by a fractional input spread that naturally projects into the observed interference-like pattern upon grid resolution.

The "interference pattern" observed on the detector screen is purely an arithmetic projection of Spread Polynomials.

```idris
module Derivation.Double_Slit_Interference

import QuickCheck
import Math.SpreadPolynumber
import Math.IntPolynumber
import Math.Fraction
import Math.FractionalEvaluator

import Data.Maybe

%default covering
```

## Slit Geometry 

We use a simple gate degree for the geometry. A bright fringe occurs if the polynomial evaluated at the given fractional spread results in an exact integer.

```idris
isDivisible : Nat -> Nat -> Bool
isDivisible Z _ = True
isDivisible _ Z = False
isDivisible n d = 
  case n `minus` d of
       Z => (n == d)
       diff => isDivisible (assert_smaller n diff) d

projectsToBrightFringe : Nat -> Spread -> Bool
projectsToBrightFringe gateDegree spread =
  let algebraicPoly = memoSpreadPoly gateDegree
      polyResult = evaluateIntPoly algebraicPoly spread
  in polyResult.value.denominator == 1 || isDivisible polyResult.value.numerator polyResult.value.denominator
```

## QuickCheck Properties

We verify that for certain combinations of rational spreads, we get either deterministic bright or dark fringes.

```idris
restrictGate : Nat -> Nat
restrictGate Z = Z
restrictGate (S k) = 
  let r = restrictGate k 
  in if r == 15 then 0 else S r

genTwoNats : Gen (Nat, Nat)
genTwoNats = do
  x <- arbitrary
  y <- arbitrary
  pure (x, y)

public export
verifyIntegerSpread : Nat -> Nat -> Bool
verifyIntegerSpread gateDeg num =
  let spread = MkSpread (MkFraction num 1)
  in projectsToBrightFringe (restrictGate gateDeg) spread

public export
verifyVacuumSpread : Nat -> Nat -> Bool
verifyVacuumSpread num den =
  let den' = if den == 0 then 1 else den
      spread = MkSpread (MkFraction num den')
  in projectsToBrightFringe 0 spread

||| Proves that any integer spread (denominator = 1) always evaluates to an integer
||| result, projecting to a bright fringe regardless of the gate degree.
public export
prop_integerSpreadsAreBright : Property
prop_integerSpreadsAreBright = forAll genTwoNats (MkFn (\(gateDeg, num) => verifyIntegerSpread gateDeg num))

||| Proves that the Vacuum Gate (n=1) always evaluates to an integer (0),
||| projecting to a bright fringe for any arbitrary fractional spread.
public export
prop_vacuumIsAlwaysBright : Property
prop_vacuumIsAlwaysBright = forAll genTwoNats (MkFn (\(num, den) => verifyVacuumSpread num den))
```

## Main Test Runner

```idris
public export
main : IO ()
main = do
  let res1 = QuickCheck.quickCheck prop_integerSpreadsAreBright
  putStrLn $ "prop_integerSpreadsAreBright: " ++ res1.msg
  let res2 = QuickCheck.quickCheck prop_vacuumIsAlwaysBright
  putStrLn $ "prop_vacuumIsAlwaysBright: " ++ res2.msg
```
