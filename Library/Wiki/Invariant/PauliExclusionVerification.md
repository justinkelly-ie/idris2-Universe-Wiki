# The Pauli Exclusion Principle

This module establishes the property-based verification of the discrete **Pauli Exclusion Principle** and validates coordinate overlap detection across the state space.

## Classical Primer

In orthodox quantum mechanics, the Pauli Exclusion Principle states that two identical fermions (such as electrons or quarks) cannot occupy the identical quantum state simultaneously.

In our discrete Multiset framework:
- Coordinates are discrete locations represented by `Geometry` (`Pixel Integer`).
- A state vector (`SparseMaxel`) is a multiset of coordinate-amplitude pairs.
- Fermionic particles occupy discrete spatial coordinates. The **Pauli Exclusion Principle** states that no two fermionic coordinate assignments in the state vector can occupy the exact same spatial coordinate simultaneously.
- If there is any coordinate overlap (duplicates), the state is physically invalid and must be excluded.
- Bosons (such as photons or sharing bonds) are arithmetically exempted from this exclusion constraint, allowing them to freely superpose at identical coordinates.

```idris
module Invariant.PauliExclusionVerification

import QuickCheck
import Simplex.Core
import Math.Multiset
import Invariant.PauliExclusion

%default total
```

## Generators for Coordinate Topologies

We define custom generators to produce state vectors with either strictly unique or guaranteed overlapping coordinate systems:

```idris
public export
genUniqueCoords : Gen SparseMaxel
genUniqueCoords = do
  x1 <- choose (-50, 50)
  y1 <- choose (-50, 50)
  x2 <- choose (-50, 50)
  y2 <- choose (-50, 50)
  let (x2', y2') = if x1 == x2 && y1 == y2 then (x2 + 1, y2) else (x2, y2)
  pure (fromList [((MkPixel x1 y1, emptyAmplitude), 1), ((MkPixel x2' y2', emptyAmplitude), 1)])

public export
genOverlappingCoords : Gen SparseMaxel
genOverlappingCoords = do
  x <- choose (-50, 50)
  y <- choose (-50, 50)
  pure (fromList [((MkPixel x y, emptyAmplitude), 1), ((MkPixel x y, emptyAmplitude), 1)])
```

## Property-Based Verification

We verify that the `ObeysPauliExclusion` implementation successfully identifies and validates coordinate systems:

```idris
||| Proves that any state vector containing entirely unique coordinates 
||| strictly obeys the Pauli Exclusion Principle (no coordinate overlaps).
public export
prop_exclusionOnUniqueCoords : Property
prop_exclusionOnUniqueCoords = forAll genUniqueCoords (MkFn (\state => property (hasNoCoordinateOverlap state == True)))

||| Proves that injecting any duplicate coordinate into a state vector 
||| correctly triggers the Pauli Exclusion violation (hasNoCoordinateOverlap == False).
public export
prop_exclusionViolatedOnOverlap : Property
prop_exclusionViolatedOnOverlap = forAll genOverlappingCoords (MkFn (\state => property (hasNoCoordinateOverlap state == False)))
```
