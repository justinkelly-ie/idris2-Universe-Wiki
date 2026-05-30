# Carbon

Carbon serves as the universal organic backbone in both continuous and discrete physics.

## Classical Primer

In continuous chemistry, Carbon's atomic number $Z=6$ grants it 4 valence electrons, allowing it to form stable, complex covalent bonds (catenation) with other atoms.

In our discrete Multiset framework:
- Carbon is an excited state carrying exactly 6 units of baryonic lag.
- Carbon's algebraic valence matches the **BondGate** degree of 4.
- This valence is why Carbon serves as the base structure for all organic and multivalent molecular compositions.

```idris
module Compound.CarbonVerification

import QuickCheck
import Compound.Carbon

%default total
```

## Property-Based Verification

We verify Carbon's algebraic valence identity:

```idris
||| Verifies that Carbon's algebraic valence exactly equals the BondGate degree (4).
public export
prop_carbonValence : Property
prop_carbonValence = property (carbonValence == 4)
```
