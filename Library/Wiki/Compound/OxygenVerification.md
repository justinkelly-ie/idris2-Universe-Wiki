# Oxygen

Oxygen is the universal mediator driving chemistry and metabolism across metrics.

## Classical Primer

In standard physics, Oxygen ($Z=8$) is highly electronegative, serving as the prime electron acceptor that drives metabolism and chemical bonding.

In our discrete Multiset framework:
- Oxygen occupies a unique structural position: $8 = 2^3$ (BackgroundGate cubed).
- It perfectly divides the dark energy pool ($128 / 8 = 16$).
- Its residue in visible matter is the MatterGate ($27 \bmod 8 = 3$).
- This unique arithmetic is why Oxygen is the universal electron acceptor, accepting exactly 2 electrons (BackgroundGate degree).

```idris
module Compound.OxygenVerification

import QuickCheck
import Compound.Oxygen

%default total
```

## Property-Based Verification

We verify Oxygen's structural valence and dark energy partitioning bounds:

```idris
||| Verifies that Oxygen's algebraic valence accepts exactly 2 electrons (BackgroundGate degree).
public export
prop_oxygenValenceIs2 : Property
prop_oxygenValenceIs2 = property (oxygenValence == 2)

||| Verifies that Oxygen partitions the 128 Dark Energy pool into exactly 16 quanta.
public export
prop_oxygenDividesLatent : Property
prop_oxygenDividesLatent = property (darkEnergyQuanta == 16)
```
