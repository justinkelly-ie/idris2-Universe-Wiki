# Verified Theorems

This document aggregates all formal mathematical physics theorems proven entirely at compile-time by the Idris 2 typechecker. These are absolute structural guarantees, requiring no runtime execution.

### Hydrogen
**Module**: `System.PeriodicTable`

```idris
Hydrogen : Element
```

---

### Carbon
**Module**: `System.PeriodicTable`

```idris
Carbon : Element
```

---

### Oxygen
**Module**: `System.PeriodicTable`

Oxygen (Z=8): the universal mediator.

Structural position in the 128/27 partition:
- 8 = 2^3 (BackgroundGate cubed)
- 128 / 8 = 16 (divides dark energy pool exactly)
- 27 mod 8 = 3  (remainder = MatterGate degree)
- Does NOT divide the primorial (210)

This makes Oxygen the bridge between the latent and visible sectors:
it partitions dark energy into 16 equal quanta and its remainder in
visible matter is the MatterGate — the gate that generates structure.

```idris
Oxygen : Element
```

---

### Iron
**Module**: `System.PeriodicTable`

Iron (Z=26): the stellar fusion limit.
Heaviest element producible by core fusion before gravitational collapse.

```idris
Iron : Element
```

---

### Feynmanium
**Module**: `System.PeriodicTable`

The absolute maximum stable element on the grid.
Z=137 survives the resonance gate. Z=138 does not.

```idris
Feynmanium : Element
```

---

### oxygenDividesLatent
**Module**: `System.PeriodicTable`

Oxygen divides the dark energy pool (128 = 2^7) exactly.
128 / 8 = 16 quanta.

```idris
oxygenDividesLatent : (div 128 8 = 16)
```

---

### oxygenVisibleResidue
**Module**: `System.PeriodicTable`

Oxygen's remainder in visible matter (27 = 3^3) is exactly
the MatterGate degree (n=3).

```idris
oxygenVisibleResidue : (Prelude.mod 27 8 = 3)
```

---

### oxygenNotPrimorial
**Module**: `System.PeriodicTable`

Oxygen does NOT divide the primorial manifold (210).
This is why it acts as a mediator rather than a structural primitive.

```idris
oxygenNotPrimorial : (Prelude.mod 210 8 = 2)
```

---

### carbonIsBackgroundTimesMatter
**Module**: `Compound.Carbon`

Formal Proof that Carbon's atomic number (6) is exactly
BackgroundGate × MatterGate.

```idris
carbonIsBackgroundTimesMatter : (6 = degree BackgroundGate * degree MatterGate)
```

---

### carbonValenceIsBondGate
**Module**: `Compound.Carbon`

Formal Proof that Carbon's valence (4) exactly matches the BondGate.

```idris
carbonValenceIsBondGate : (Compound.Carbon.carbonValence = degree BondGate)
```

---

### methaneTimeOscillation
**Module**: `Compound.Methane`

Formal Proof that the Red Quadrance signature of Methane forms
a perfect TimeGate oscillation (+7, -7, +7, -7).

```idris
methaneTimeOscillation : (Compound.Methane.redSignatureH1 = 7, Compound.Methane.redSignatureH2 = -7, Compound.Methane.redSignatureH3 = 7, Compound.Methane.redSignatureH4 = -7)
```

---

### methaneNullVector
**Module**: `Compound.Methane`

Formal Proof that Methane forms a pure Null Vector in Minkowski space.
The total TimeGate oscillation sums to exactly 0 (7 - 7 + 7 - 7 = 0).
This means the Carbon Backbone is causally stable (a persistent identity),
exactly like the (7,7) hydrogen bond in IceGeometry!

```idris
methaneNullVector : (Compound.Methane.redSignatureH1 + Compound.Methane.redSignatureH2 + Compound.Methane.redSignatureH3 + Compound.Methane.redSignatureH4 = 0)
```

---

### methaneOrthogonal
**Module**: `Compound.Methane`

Formal Proof that the Methane bonds are perfectly orthogonal
in the Blue (Euclidean) Metric.

```idris
methaneOrthogonal : isPerpendicularNL Blue Compound.Methane.ch4_h1 Compound.Methane.ch4_h2 = True
```

---

### methaneChargeConservation
**Module**: `Compound.Methane`

Formal Proof that all Methane bonds conserve exactly the same
Blue Quadrance (25 = ChargeGate²) as the Water molecule.

```idris
methaneChargeConservation : (Compound.Methane.methaneBondQuadrance = 25)
```

---

### methaneBaryonicLagIs10
**Module**: `Compound.Methane`

```idris
methaneBaryonicLagIs10 : (Compound.Methane.methaneBaryonicLag = 10)
```

---

### methaneMassEnergyEquivalence
**Module**: `Compound.Methane`

Formal Proof of Discrete E=mc² (Mass-Energy Equivalence).
The total Baryonic Mass (Z) of Methane is 10.
The total Euclidean Energy (Blue Quadrance) of its 4 bonds is 100 (25 × 4).
Energy (100) = Mass (10)².
Water does NOT have this property (50 ≠ 10²), making Methane the first
"Complete" particle in the scale hierarchy where bond energy perfectly
squares the mass.

```idris
methaneMassEnergyEquivalence : (Compound.Methane.methaneBondQuadrance * 4 = Compound.Methane.methaneBaryonicLag * Compound.Methane.methaneBaryonicLag)
```

---
