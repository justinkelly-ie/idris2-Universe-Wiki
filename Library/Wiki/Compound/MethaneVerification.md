# Methane

Methane ($CH_4$) represents the simplest organic carbon compound on the discrete coordinate grid.

## Classical Primer

In standard organic chemistry, Methane forms a perfect tetrahedral geometry, distributing four covalent hydrogen bonds symmetrically around a central carbon atom.

In our discrete Multiset framework:
- Carbon's matter-bond gate ($n=4$) binds four Hydrogen coordinates.
- To maintain coordinate stability, the spatial red signatures must sum perfectly to a **null vector** ($0$), balancing the dynamic oscillations across the 4 bonds.
- The blue bonds are strictly orthogonal in the Euclidean metric, anchoring the tetrahedral configuration mathematically.

```idris
module Compound.MethaneVerification

import QuickCheck
import Compound.Methane
import Simplex.Core
import Math.Chromogeometry

%default total
```

## Property-Based Verification

We verify Methane's dynamic red-signature null-vector balance and blue bond orthogonality:

```idris
||| Verifies the topological stability, red signature null-sum, and mass-energy properties of Methane.
public export
prop_methaneStability : Property
prop_methaneStability = property ((redSignatureH1 + redSignatureH2 + redSignatureH3 + redSignatureH4 == 0) && (bondsBlueOrthogonal == True))
```

## Interactive 3D Visualizer

Inspect and interact with Methane's live serialization state vectors in the 3D lab:
* **[Interactive 3D Visualisation (Methane)](http://localhost:5173/?mode=live&file=methane)**
