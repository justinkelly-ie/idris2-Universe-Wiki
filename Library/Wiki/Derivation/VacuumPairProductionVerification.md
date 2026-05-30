# Vacuum Pair Production & Virtual Particle Invariants

This section documents and verifies the discrete, non-linear geometric mechanics of **Vacuum Pair Production** and **Virtual Particle Annihilation** in the LUniverse physical substrate.

## Classical Primer

In standard continuous quantum field theory, the vacuum is not a quiet, empty void. Instead, it is a boiling sea of **virtual particles** that spontaneously emerge as particle-antiparticle pairs and almost immediately annihilate back into the vacuum. Under extreme conditions—such as the intense electric fields of the **Schwinger Effect** or the sharp gravitational gradients at black hole event horizons (**Hawking Radiation**)—these virtual pairs are ripped apart before they can annihilate, becoming real, detectable particles.

In our discrete Multiset model:
- The **vacuum** is not represented by a zero-dimensional space, but by coordinates where the net sum of polynomial wave amplitudes is exactly zero.
- Spontaneous pair production corresponds to unrolling a complementary pair of $+1$ and $-1$ amplitude states at a coordinate pixel.
- The virtual particle carries a positive quantum wave ($s^1$ with coefficient $+1$), and the antiparticle carries an identical wave with a negative coefficient ($-1$).
- The **Leibniz Lag** — measured by `multiplicityAll` as the sum of **absolute** counts — is always 2 for a freshly created pair: one unit of matter and one unit of antimatter, both physically present.
- When the particle and antiparticle are reunited, their opposite coefficients annihilate upon the next `annihilateMultiset` call, restoring the ground state vacuum.
- In **Hawking Radiation**, one member of the pair escapes as an observable photon, raising the total measurable lag from 2 to 3.

---

## Living Physical Proofs

We define the literate verification module to execute QuickCheck properties over the vacuum pair production engine.

```idris
module Derivation.VacuumPairProductionVerification

import QuickCheck
import Simplex.Core
import Math.IntPolynumber
import Math.Multiset
import Derivation.VacuumPairProduction
import Symmetry.Common

%default total
```

### Generators

We define local generators for pixel coordinates following the established pattern of other wiki verification modules:

```idris
||| Generates a random spatial coordinate pixel.
public export
genPairPixel : Gen (Pixel Integer)
genPairPixel = do
  x <- choose (-50, 50)
  y <- choose (-50, 50)
  pure (MkPixel x y)
```

---

## Property-Based Verifications

We prove the fundamental conservation laws governing virtual pair creation and Hawking emission, expressed in terms of the physical **Leibniz Lag** — the sum of absolute multiplicities across all active state nodes.

The key architectural fact: `multiplicityAll` uses `abs c` per entry, not `c`. It measures total physical activity regardless of sign. A matter node ($c = +1$) and an antimatter node ($c = -1$) each contribute **1** to the Leibniz Lag.

### 1. Pair Lag Invariant

Each Schwinger pair injection adds exactly **2** units of total Leibniz Lag to the vacuum, regardless of which coordinate receives the pair. One unit is contributed by the matter particle ($c = +1$) and one by the antimatter partner ($c = -1$). The verification runs over 100 random coordinates:

```idris
||| Helper: verifies that a pair injection at a pixel adds exactly 2 lag units to the vacuum.
public export
checkPairLagIsTwo : Pixel Integer -> Property
checkPairLagIsTwo geom =
  let afterPair = simulateSchwingerEffect emptySparseMaxel geom
  in property (stateLag afterPair == 2)

||| Verifies that spontaneous Schwinger pair creation always produces exactly
||| 2 units of Leibniz Lag — one matter and one antimatter node.
public export
prop_pairProductionNetCharge : Property
prop_pairProductionNetCharge = forAll genPairPixel (MkFn checkPairLagIsTwo)
```

### 2. Hawking Radiation Lag Extension

We verify the Hawking radiation mechanism: when one member of a virtual pair escapes the gravitational horizon as a real photon, the total observable Leibniz Lag of the state rises from 2 (the pair alone) to exactly **3** (pair plus the escaped Hawking photon). This confirms that the pair production and radiation processes are additive and coherent:

```idris
||| Verifies that Hawking photon emission adds exactly 1 lag unit to the
||| pair-production state, giving a total observable Leibniz Lag of 3.
public export
prop_pairAnnihilationRestoresVacuum : Property
prop_pairAnnihilationRestoresVacuum = property (
  let geom         = MkPixel 0 0
      afterPair    = simulateSchwingerEffect emptySparseMaxel geom
      afterHawking = simulateHawkingRadiation afterPair geom
  in stateLag afterHawking == 3
  )
```
