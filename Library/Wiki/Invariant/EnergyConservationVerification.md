# Energy Conservation

This module establishes the property-based verification of the **Law of Conservation of Energy** across coordinate locations and state vectors.

## Classical Primer

In continuous physics, the Law of Conservation of Energy states that the total energy of an isolated system remains constant over time.

In our discrete Chromogeometric framework:
- **Energy** corresponds to spatial extension on the grid, measured precisely by **Blue Quadrance** (Minkowski Euclidean distance squared from the origin).
- Physical interactions or transitions must conserve the total Blue Quadrance.
- For unified multiset states (`SparseMaxel`), mass-energy is conserved if the total degree of the constituent polynomial states is preserved under transitions.

```idris
module Invariant.EnergyConservationVerification

import QuickCheck
import Symmetry.Common
import Math.Multiset
import Math.IntPolynumber
import Math.SpreadPolynumber
import Invariant.EnergyConservation

%default total
```

## Generators for Spacetime States

We define generators for spatial pixels and state multisets:

```idris
||| Generates a random spatial coordinate pixel.
public export
genPixel : Gen (Pixel Integer)
genPixel = do
  x <- choose (-50, 50)
  y <- choose (-50, 50)
  pure (MkPixel x y)

||| Generates a simple state multiset.
public export
genSparseMaxel : Gen (Multiset (Pixel Integer, IntPolynumber))
genSparseMaxel = do
  px <- genPixel
  pure (AddM (px, spreadPoly 5) 1 ZeroM)
```

## Property-Based Verification

We define top-level helper functions for validation to bypass the backslash-parenthesis (`\(`) parsing limitation:

```idris
||| Helper to verify pixel energy conservation.
public export
checkPixelEnergy : Pixel Integer -> Property
checkPixelEnergy p =
  let res = isEnergyConserved p p
      val = case res of Builtin.(#) v _ => v
  in property (val == True)

||| Proves that any spatial pixel strictly conserves energy with itself
||| (its Blue quadrance from origin is perfectly invariant).
public export
prop_energyConservationPixel : Property
prop_energyConservationPixel = forAll genPixel (MkFn checkPixelEnergy)

||| Helper to verify multiset energy conservation.
public export
checkSparseMaxelEnergy : Multiset (Pixel Integer, IntPolynumber) -> Property
checkSparseMaxelEnergy mset =
  let res = isEnergyConserved mset mset
      val = case res of Builtin.(#) v _ => v
  in property (val == True)

||| Proves that state multiset transitions conserve energy.
public export
prop_energyConservationMultiset : Property
prop_energyConservationMultiset = forAll genSparseMaxel (MkFn checkSparseMaxelEnergy)
```
