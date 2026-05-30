# Hadron Gluon Dynamics

This module establishes the property-based verification of **Hadron Gluon Dynamics** within Baryon configurations.

## Classical Primer

In orthodox Quantum Chromodynamics (QCD), gluons are force carriers that mediate the strong nuclear interaction between quarks. They carry color charges and constantly exchange them to bind quarks stably inside hadrons.

In our discrete Multiset framework:
- A **Gluon** is not an independent physical particle.
- It is a **localized Chromogeometric pivot (matrix rotation)** that shifts the fractional coordinates across the Red, Green, and Blue metrics to continuously re-balance the $A(Q) = T(s)$ locking condition.
- Executing a gluon transaction dynamically preserves the color-confined state, ensuring the Baryon remains stable and colorless throughout coordinate shifts.

```idris
module System.HadronGluonDynamicsVerification

import QuickCheck
import Symmetry.Common
import Math.Multiset
import Math.IntPolynumber
import Math.SpreadPolynumber
import Invariant.ColorConfinement
import System.HadronGluonDynamics
import Symmetry.Quark
import Symmetry.Baryon

%default total
```

## Generators for Baryon Configurations

We define custom generators to procedurally construct Quarks and Baryon triads:

```idris
||| Generates a single Quark state at a random spatial coordinate.
public export
genQuark : Gen Quark
genQuark = do
  x <- choose (-50, 50)
  y <- choose (-50, 50)
  pure (MkQuark (AddM (MkPixel x y, spreadPoly 5) 1 ZeroM))

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
Show Baryon where
  show _ = "Baryon"
```

## Property-Based Verification

We define top-level helper functions for validation to bypass the backslash-parenthesis (`\(`) parsing limitation:

```idris
||| Helper to verify gluon transaction confinement preservation.
public export
checkGluonConfinement : Baryon -> Property
checkGluonConfinement baryon =
  let baryon' = executeGluonTransaction baryon
      res     = isColorless baryon'
      val     = case res of Builtin.(#) v _ => v
  in property (val == True)

||| Proves that executing a gluon transaction (matrix rotation)
||| strictly preserves Color Confinement, leaving the Baryon colorless.
public export
prop_gluonTransactionPreservesConfinement : Property
prop_gluonTransactionPreservesConfinement = forAll genBaryon (MkFn checkGluonConfinement)

||| Helper to verify gluon transaction stability.
public export
checkGluonStability : Baryon -> Property
checkGluonStability baryon =
  let baryon' = executeGluonTransaction baryon
      c1 = multisetToList baryon.q1.state
      c1' = multisetToList baryon'.q1.state
  in property (c1 == c1')

||| Proves that the gluon transaction successfully returns the baryon structure.
public export
prop_gluonTransactionIsStable : Property
prop_gluonTransactionIsStable = forAll genBaryon (MkFn checkGluonStability)
```
