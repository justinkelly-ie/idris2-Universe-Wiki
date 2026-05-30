# Simplicial Topology & Multiset Invariants

This module establishes the property-based verification of the core algebraic and topological invariants of the simplicial geometry engine. Every component of our spacetime manifold and state vector is modeled purely as a discrete Multiset, ensuring exact conservation laws.

## 1. Causal Density Aggregation

In this cosmology, the causal relations of spacetime are represented by the `Substrate` multiset, and its density (total edge count) is the **Leibniz Lag**—the discrete spatial representation of time accumulation. 

When two separate causal substrates merge, the total lag of the combined substrate must strictly equal the sum of their individual lags. This algebraic invariant proves that no causal relations are lost or spuriously created during topological operations.

```idris
module Simplex.Properties

import QuickCheck
import Simplex.Core
import Math.Multiset
import Math.Chromogeometry
import Symmetry.Common

%default total
```

```idris
public export
prop_substrateMergeLag : Property
prop_substrateMergeLag = forAll genUniverseStateWithDepth (MkFn (\(depth1, u1) => 
  forAll genUniverseStateWithDepth (MkFn (\(depth2, u2) =>
    let mergedSub = mergeSubstrate u1.substrate u2.substrate
        expectedLag = substrateLag u1.substrate + substrateLag u2.substrate
    in property (substrateLag mergedSub == expectedLag)))))
```

## 2. Quantum State Superposition

The particle state vector (`SparseMaxel`) maps spatial coordinates to their polynomial mass-energy amplitudes. Superposing two quantum states is modeled as the multiset union of their amplitudes. We verify that the total accumulated Leibniz lag (quantum probability mass) is perfectly conserved under state superposition.

```idris
public export
prop_superposeLag : Property
prop_superposeLag = forAll genUniverseStateWithDepth (MkFn (\(d1, u1) =>
  forAll genUniverseStateWithDepth (MkFn (\(d2, u2) =>
    let superposed = superposeStates u1.stateVector u2.stateVector
        expectedLag = stateLag u1.stateVector + stateLag u2.stateVector
    in property (stateLag superposed == expectedLag)))))
```

## 3. Evolved State Topological Gluing (Synchronisation)

A state vector is only physically valid if it is topologically glued to its spacetime manifold. We verify that as the universe evolves recursively across arbitrary depth epochs, every single active coordinate assigned a non-zero amplitude in the `SparseMaxel` strictly possesses a corresponding causal node in the `Substrate` DAG. 

An unsynchronized coordinate would represent a physical particle existing in a location with no causal history—a topological fracture that is mathematically prohibited.

```idris
public export
verifyStateSynchronised : UniverseState -> Bool
verifyStateSynchronised u = isSynchronised u.substrate u.stateVector

||| Rigorously proves the multiset coordinate gluing: every active particle coordinate
||| in the State Vector must possess a corresponding causal node in the Substrate DAG.
||| This invariant must hold true across all recursive epoch depths.
public export
prop_evolvedUniverseSynchronised : Property
prop_evolvedUniverseSynchronised = forAll genUniverseStateWithDepth (MkFn (\(depth, u) => property (verifyStateSynchronised u)))
```
