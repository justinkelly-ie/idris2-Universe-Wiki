# Feynmanium

Feynmanium ($Fy$, $Z=137$) represents the ultimate stable coordinate state at the absolute boundary of the 137-grid.

## Classical Primer

Richard Feynman mathematically derived that elements with $Z > 137$ cannot exist in continuous quantum theory, as the innermost electron shell would be forced to exceed the speed of light ($v = Z\alpha c > c$).

In our discrete Multiset framework:
- The constant $137$ represents the absolute spatial boundary limit.
- Elements are stable excited states of the grid up to Feynmanium ($Z=137$), beyond which the local address space overflows and resonance violently shatters the coordinates.
- Feynmanium represents the absolute stable limit, concentrating exactly **274 lag units** (mass density) at the grid boundary.

```idris
module Compound.FeynmaniumVerification

import QuickCheck
import Simplex.Core
import Compound.Feynmanium

%default total
```

## Property-Based Verification

We verify that Feynmanium possesses exactly 274 total lag units at the grid boundary:

```idris
||| Verifies that the maximum stable element Feynmanium possesses exactly 274 lag units.
public export
prop_feynmaniumLag : Property
prop_feynmaniumLag = property (feynmaniumLag (MkPixel 0 0) == 274)
```

## Interactive 3D Visualizer

Inspect and interact with Feynmanium's live serialization state vectors in the 3D lab:
* **[Interactive 3D Visualisation (Feynmanium)](http://localhost:5173/?mode=live&file=feynmanium)**
