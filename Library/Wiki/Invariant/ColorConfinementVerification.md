# Color Confinement

This module provides the Literate property-based verification of **Color Confinement** for Baryons and Mesons.

## Classical Primer

In orthodox Quantum Chromodynamics (QCD), Color Confinement is a physical phenomenon where color-charged particles (such as quarks and gluons) cannot be isolated. They must group into colorless composite states (hadrons) such as mesons (dyads) and baryons (triads).

In our discrete Multiset framework:
- A solitary **Quark** ($n=5$ fractional charge) is geometrically unstable. It does not implement `ColorConfined` because its fractional coordinate cannot be plotted onto a discrete integer pixel grid without leaving a fractional residue.
- A **Meson** is a dyad of two quarks with opposing topologies. When combined, their parallel-tension geometry perfectly balances, resolving the fractions.
- A **Baryon** is a triad of three quarks. The composite geometry satisfies the structural locking condition $A(Q) = T(s)$ (Archimedes area matches relational tension), rendering it colorless and stable.

```idris
module Invariant.ColorConfinementVerification

import QuickCheck
import Symmetry.Common
import Math.Multiset
import Math.IntPolynumber
import Math.SpreadPolynumber
import Invariant.ColorConfinement
import Symmetry.Quark
import Symmetry.Meson
import Symmetry.Baryon

%default total
```

## Generators for Colorless Hadrons

We define custom generators to procedurally construct Quarks, Mesons, and Baryons on randomized grid coordinates:

```idris
||| Generates a single Quark state at a random spatial coordinate.
public export
genQuark : Gen Quark
genQuark = do
  x <- choose (-50, 50)
  y <- choose (-50, 50)
  pure (MkQuark (AddM (MkPixel x y, spreadPoly 5) 1 ZeroM))

||| Generates a Meson dyad from two procedurally generated quarks.
public export
genMeson : Gen Meson
genMeson = do
  q1 <- genQuark
  q2 <- genQuark
  pure (MkMeson q1 q2)

||| Generates a Baryon triad from three procedurally generated quarks.
public export
genBaryon : Gen Baryon
genBaryon = do
  q1 <- genQuark
  q2 <- genQuark
  q3 <- genQuark
  pure (MkBaryon q1 q2 q3)

public export
Show Quark where
  show _ = "Quark"

public export
Show Meson where
  show _ = "Meson"

public export
Show Baryon where
  show _ = "Baryon"
```

## Property-Based Verification

We define top-level helper functions for validation to bypass the backslash-parenthesis (`\(`) parsing limitation:

```idris
||| Helper to verify meson confinement.
public export
checkMeson : Meson -> Property
checkMeson meson =
  let res = isColorless meson
      val = case res of Builtin.(#) v _ => v
  in property (val == True)

||| Proves that any generated Meson dyad is colorless (white/stable).
public export
prop_mesonConfinement : Property
prop_mesonConfinement = forAll genMeson (MkFn checkMeson)

||| Helper to verify baryon confinement.
public export
checkBaryon : Baryon -> Property
checkBaryon baryon =
  let res = isColorless baryon
      val = case res of Builtin.(#) v _ => v
  in property (val == True)

||| Proves that any generated Baryon triad is colorless (white/stable).
public export
prop_baryonConfinement : Property
prop_baryonConfinement = forAll genBaryon (MkFn checkBaryon)
```
