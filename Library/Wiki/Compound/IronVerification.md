# Iron

Iron is the peak stable element of stellar nucleosynthesis.

## Classical Primer

In standard physics, Iron-56 has the highest binding energy per nucleon of any element. Elements lighter than Iron release energy through fusion, while heavier elements require energy, making Iron the final evolutionary stage of stellar fusion cores.

In our discrete Multiset framework:
- Iron ($Z=26$) represents a local maximum of coordinate stability.
- Its total structural Leibniz lag (mass-energy density) concentrated at the origin equals exactly **52 lag units**, representing the physical nucleosynthesis energy peak.

```idris
module Compound.IronVerification

import QuickCheck
import Simplex.Core
import Compound.Iron

%default total
```

## Property-Based Verification

We verify that Iron's structural lag at origin equals exactly 52 units:

```idris
||| Verifies that the total structural Leibniz lag of Iron matches its peak value of 52.
public export
prop_ironLag : Property
prop_ironLag = property (ironLag (MkPixel 0 0) == 52)
```

## Interactive 3D Visualizer

Inspect and interact with Iron's live serialization state vectors in the 3D lab:
* **[Interactive 3D Visualisation (Iron)](http://localhost:5173/?mode=live&file=iron)**
