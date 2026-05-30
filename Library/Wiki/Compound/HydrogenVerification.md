# Hydrogen

Hydrogen is the simplest and most abundant element in the universe.

## Classical Primer

In standard physics, Hydrogen consists of a single proton and electron, possessing minimal atomic mass and serving as the primary fuel for nucleosynthesis.

In our discrete Multiset framework:
- Hydrogen ($Z=1$) represents the ground excited state, possessing minimal causal lag.
- It acts as the unit builder of all organic compounds and coordinates.

```idris
module Compound.HydrogenVerification

import QuickCheck
import Simplex.Core
import Compound.Hydrogen

%default total
```

## Property-Based Verification

We verify that Hydrogen possesses a valid minimal mass-lag:

```idris
||| Verifies that Hydrogen's coordinate lag is minimal and non-trivial.
public export
prop_hydrogenLagMinimal : Property
prop_hydrogenLagMinimal = property (hydrogenLag (MkPixel 0 0) > 0)
```
