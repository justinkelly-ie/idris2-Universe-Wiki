```idris
module Compound.Elements

import QuickCheck
import Compound.Water
import Compound.Methane
import Compound.Carbon
import Compound.Iron
import Compound.Feynmanium
import Simplex.Core
import Math.Chromogeometry

%default total

```
Verifies that the Water Molecule maintains its canonical bond quadrance
and its red-metric orthogonality regardless of evaluation context.
```idris
public export
prop_waterArchimedes : Property
prop_waterArchimedes = property ((bondQuadrance == 25) && (bondsRedPerpendicular == True))

```

### Visualisation
Inspect and interact with the Water molecule's live serialization state vectors in the 3D lab:
* **[Interactive 3D Visualisation (Water)](http://localhost:5173/?mode=live&file=water)**
Verifies the topological stability and mass-energy properties of Methane.
```idris
public export
prop_methaneStability : Property
prop_methaneStability = property ((redSignatureH1 + redSignatureH2 + redSignatureH3 + redSignatureH4 == 0) && (bondsBlueOrthogonal == True))

```

### Visualisation
Inspect and interact with Methane's live serialization state vectors in the 3D lab:
* **[Interactive 3D Visualisation (Methane)](http://localhost:5173/?mode=live&file=methane)**
Verifies Carbon's algebraic properties.
```idris
public export
prop_carbonValence : Property
prop_carbonValence = property (carbonValence == 4)
```

Verifies the structural properties of Iron.
```idris
public export
prop_ironLag : Property
prop_ironLag = property (ironLag (MkPixel 0 0) == 52)

```

### Visualisation
Inspect and interact with Iron's live serialization state vectors in the 3D lab:
* **[Interactive 3D Visualisation (Iron)](http://localhost:5173/?mode=live&file=iron)**
Verifies the structural properties of Feynmanium.
```idris
public export
prop_feynmaniumLag : Property
prop_feynmaniumLag = property (feynmaniumLag (MkPixel 0 0) == 274)
```

### Visualisation
Inspect and interact with Feynmanium's live serialization state vectors in the 3D lab:
* **[Interactive 3D Visualisation (Feynmanium)](http://localhost:5173/?mode=live&file=feynmanium)**
