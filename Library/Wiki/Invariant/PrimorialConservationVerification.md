# Primorial Information Conservation

This module establishes the property-based verification of the **Law of Primorial Information Conservation** across state pools.

## Classical Primer

In traditional physics, Information Conservation (e.g. Liouville's theorem or unitary evolution in quantum mechanics) states that physical states can never be lost or created.

In our discrete Primorial Architecture:
- The **Universal State Pool** (the Primorial Manifold) strictly maintains exactly **210 constituent states**, derived from the 4th primorial product ($2 \times 3 \times 5 \times 7 = 210$).
- Particles can transition between the Visible Matter ($27$), Invisible Dark Energy ($128$), and Dark Matter background ($55$), but the total mathematical length of the universe is immutable.
- A state vector is physically intact if and only if its total multiplicity equals exactly $210$.

```idris
module Invariant.PrimorialConservationVerification

import QuickCheck
import Symmetry.Common
import Math.Multiset
import Math.IntPolynumber
import Math.SpreadPolynumber
import Invariant.PrimorialConservation

%default total
```

## Generators for Primorial Space

We define generators that produce state pools with exactly $210$ total multiplicity or an invalid state count:

```idris
||| Generates a random spatial pixel coordinate.
public export
genPixel : Gen (Pixel Integer)
genPixel = do
  x <- choose (-50, 50)
  y <- choose (-50, 50)
  pure (MkPixel x y)

||| Generates a state pool with exactly 210 constituent states.
public export
genPrimorialManifold : Gen (Multiset (Pixel Integer, IntPolynumber))
genPrimorialManifold = do
  p <- genPixel
  pure (AddM (p, spreadPoly 5) 210 ZeroM)

||| Generates a state pool with an invalid number of states (not equal to 210).
public export
genInvalidManifold : Gen (Multiset (Pixel Integer, IntPolynumber))
genInvalidManifold = do
  p <- genPixel
  count <- choose (1, 300)
  let count' = if count == 210 then 211 else count
  pure (AddM (p, spreadPoly 5) count' ZeroM)
```

## Property-Based Verification

We define top-level helper functions for validation to bypass the backslash-parenthesis (`\(`) parsing limitation:

```idris
||| Helper to verify primorial manifold intactness.
public export
checkManifoldIntact : Multiset (Pixel Integer, IntPolynumber) -> Property
checkManifoldIntact mset = property (isPrimorialManifoldIntact mset == True)

||| Proves that any state pool with exactly 210 constituent states
||| is recognized as physically intact.
public export
prop_primorialManifoldConserved : Property
prop_primorialManifoldConserved = forAll genPrimorialManifold (MkFn checkManifoldIntact)

||| Helper to verify primorial manifold violation.
public export
checkManifoldViolated : Multiset (Pixel Integer, IntPolynumber) -> Property
checkManifoldViolated mset = property (isPrimorialManifoldIntact mset == False)

||| Proves that any state pool with non-210 constituent states
||| is recognized as physically violated/decoherent.
public export
prop_primorialManifoldViolated : Property
prop_primorialManifoldViolated = forAll genInvalidManifold (MkFn checkManifoldViolated)
```
