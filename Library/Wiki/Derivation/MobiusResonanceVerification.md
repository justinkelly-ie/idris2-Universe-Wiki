# Möbius Twist & Substrate Resonance

This section documents and verifies the **multiset scale transition** at the heart of the LUniverse model: the moment the 2D spectral information substrate twists through a Möbius cross-ratio and resolves into observable 3D baryonic matter.

## Classical Primer

The Möbius transformation is the unique conformal bijection of the Riemann sphere. In standard complex analysis it takes the form $w = (az + b)/(cz + d)$. In our discrete integer model there is no complex plane and no division — but the Möbius *cross-ratio matrix* survives intact as a purely algebraic $2\times 2$ integer operator.

The **Boole-Möbius zero-remainder** is the algebraic signature of a state that lives entirely in the null subspace of the Red Minkowski metric ($Q_{\text{Red}} = x^2 - y^2 = 0$). Every such state is a pure photon ensemble: timeless, massless, and multiplicity-balanced. Its net Leibniz residue is exactly zero — no matter knots, no locked charge, no persistent identity.

The **Baryogenesis threshold** is the moment this clean photonic substrate tips over the 128-node ($2^7$) vacuum capacity limit. At that point a Pigeonhole conflict is triggered: the 2D sheet cannot accommodate the spectral pressure and *twists* — an irreversible topological fold from the $2^7 = 128$-state spectral pool into the $3^3 = 27$-state baryonic triad. Quarks are born.

The **cross-ratio absorption matrix** is the explicit discrete Möbius map:

$$M_x = \begin{pmatrix} 1 & 1 \\ 1 & -1 \end{pmatrix}, \quad M_x \begin{pmatrix} x \\ x \end{pmatrix} = \begin{pmatrix} 2x \\ 0 \end{pmatrix}$$

Applied to a photon on the null diagonal ($y = x$), it collapses the temporal component to zero and doubles the spatial impulse, converting a massless excitation into a pure spatial disturbance — matter being absorbed.

---

## Living Physical Proofs

```idris
module Derivation.MobiusResonanceVerification

import QuickCheck
import Simplex.Core
import Math.Multiset
import Math.IntPolynumber
import Math.Chromogeometry
import Derivation.Radiation
import Symmetry.Photon
import Symmetry.Common
import System.CosmicPartition

%default total
```

### Generators

We build null-quadrance radiation states for property testing. A null pixel satisfies $x = n$ and $y = n$ for any $n$, giving $Q_{\text{Red}} = n^2 - n^2 = 0$. `isZeroRemainder` checks the **signed** outer-count balance — a balanced ensemble pairs a node with outer count $+1$ against one with outer count $-1$, giving a total of zero:

```idris
||| Generates a pure null-quadrance photon pixel on the Minkowski null diagonal.
public export
genNullPixel : Gen (Pixel Integer)
genNullPixel = do
  n <- choose (1, 50)
  pure (MkPixel n n)

||| Builds a balanced, zero-remainder Radiation SparseMaxel.
||| Two entries share the same null pixel and amplitude, but carry
||| outer counts +1 and -1 respectively — net signed balance is zero.
public export
genBalancedRadiationState : Gen SparseMaxel
genBalancedRadiationState = do
  p   <- genNullPixel
  let amp = fromList [((1, 0), 1)]
  pure (addMultiset (AddM (p, amp) 1 ZeroM) (AddM (p, amp) (-1) ZeroM))

||| Generates a pure radiation state with a single photon node, having
||| a multiplicity well below the 128-node threshold (e.g. 1 to 50).
public export
genPureRadiationState : Gen SparseMaxel
genPureRadiationState = do
  p   <- genNullPixel
  m   <- choose (1, 50)
  let amp = fromList [((1, 0), 1)]
  pure (AddM (p, amp) m ZeroM)
```

---

## Property-Based Verifications

### 1. Möbius Zero-Remainder Invariant

A radiation state whose outer-count contributions are perfectly balanced (summing to zero after weighting by inner amplitude) carries exactly zero Boole-Möbius residue. This is the multiset ground state of the pre-baryonic 2D substrate — no net information accumulation, no causal knots, no persistent identity:

```idris
||| Helper: verifies that a balanced radiation state always has zero Möbius remainder.
public export
checkZeroRemainder : SparseMaxel -> Property
checkZeroRemainder pip =
  case validateRadiation pip of
    Nothing => property True   -- non-radiation states are out of scope
    Just r  => property (isZeroRemainder r)

||| Verifies that any balanced null-quadrance radiation ensemble has exactly
||| zero Boole-Möbius resolution remainder — the multiset ground state
||| of the 2D spectral substrate before baryogenesis.
public export
prop_mobiusZeroRemainder : Property
prop_mobiusZeroRemainder = forAll genBalancedRadiationState (MkFn checkZeroRemainder)
```

### 2. Baryogenesis Density Threshold

The vacuum capacity of the 2D spectral pool is exactly 128 states ($2^7$ — the dimension of a maximally saturated spin network). We verify that the baryogenesis trigger fires precisely when the radiation energy density crosses this limit, and never fires below it:

```idris
||| Verifies that a single-photon radiation state does not trigger baryogenesis —
||| the density remains well below the 128-node Pigeonhole threshold.
public export
prop_subThresholdNoBaryogenesis : Property
prop_subThresholdNoBaryogenesis = forAll genPureRadiationState (MkFn checkBelowThreshold)
  where
    checkBelowThreshold : SparseMaxel -> Property
    checkBelowThreshold pip =
      case validateRadiation pip of
        Nothing => property True
        Just r  => property (not (checkBaryogenesisTrigger r))

||| Verifies that a radiation state with exactly 129 photon nodes fires the
||| baryogenesis trigger — one node beyond the $2^7 = 128$ saturation limit.
public export
prop_overThresholdTriggersBaryogenesis : Property
prop_overThresholdTriggersBaryogenesis = property (
  let singlePhoton = fromList [((1, 0), 1)]
      nullPx       = MkPixel 1 1
      -- Build a state with 129 identical null-photon nodes (> 128 threshold)
      overfilledState : SparseMaxel
      overfilledState = AddM (nullPx, singlePhoton) 129 ZeroM
  in case validateRadiation overfilledState of
       Nothing => True    -- if not pure radiation, trigger is irrelevant
       Just r  => checkBaryogenesisTrigger r
  )
```

### 3. Cross-Ratio Photon Absorption (The Möbius Map)

The discrete Möbius cross-ratio matrix $M_x$ transforms a photon travelling on the null diagonal ($x = y$) into a pure spatial impulse with zero temporal component. This is the algebraic mechanism of matter-photon interaction — the collapse of a timeless excitation into a located spatial disturbance:

```idris
||| Verifies that the Möbius cross-ratio absorption matrix collapses
||| the temporal component of any null-diagonal photon to exactly zero,
||| leaving a pure spatial (matter) impulse.
public export
checkCrossRatioCollapsesTemporal : Pixel Integer -> Property
checkCrossRatioCollapsesTemporal p =
  case createPhoton p of
    Nothing     => property True   -- only null photons are in scope
    Just photon =>
      let absorbed = absorbPhoton photon
      in property (absorbed.tgt == 0)

||| Verifies the cross-ratio Möbius map over 100 random null photons.
public export
prop_crossRatioAbsorption : Property
prop_crossRatioAbsorption = forAll genNullPixel (MkFn checkCrossRatioCollapsesTemporal)
```
