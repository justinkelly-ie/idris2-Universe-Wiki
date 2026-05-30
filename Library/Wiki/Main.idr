module Main

import QuickCheck
import Symmetry.Common
import Derivation.LabelExtraction
import Derivation.DimensionalCausality
import Derivation.EpochInjection
import Scale.CosmologicalScaling
import Compound.Elements
import Simplex.Properties
import Evolution.Evolution
-- New tests
import Code.Engine_Verification
import System.PeriodicTableVerification
import Invariant.PauliExclusionVerification
import Invariant.ColorConfinementVerification
import Invariant.EnergyConservationVerification
import Invariant.PrimorialConservationVerification
import System.HadronGluonDynamicsVerification
import System.Spread13Verification
import Derivation.Double_Slit_Interference
import Scale.Ascension_Probe
import Evolution.Adaptive_Cycle_Pipeline
import Evolution.Adaptive_Cycle_Findings
import Evolution.Adaptive_Cycle_Chemistry
import Evolution.Adaptive_Cycle_Scales
import Maths.LinearBridgeProperties
import Simplex.Core
import Evolution.Cycle
import Math.SpreadPolynumber
import Compound.Water
import Compound.Methane

import System.File
import Data.String

%default covering

markdownTable : List (String, String, QCRes) -> String
markdownTable results =
  let header = "| Test | Description | Status | Details |\n|------|-------------|--------|---------|\n"
      rows = concat $ map formatRow results
  in header ++ rows
  where
    formatRow : (String, String, QCRes) -> String
    formatRow (name, desc, res) =
      let statusStr = case pass res of
                        Nothing => "❓ Unknown"
                        Just True => "✅ PASS"
                        Just False => "❌ FAIL"
      in "| " ++ name ++ " | " ++ desc ++ " | " ++ statusStr ++ " | " ++ trim (msg res) ++ " |\n"

runSimulationSteps : UniverseState -> Nat -> List UniverseState
runSimulationSteps state Z = [state]
runSimulationSteps state (S k) =
  let nextState = runAdaptiveCycle 137 Blue (MkPixel 4 3) state
  in state :: runSimulationSteps nextState k

serializeSimulation : List UniverseState -> String
serializeSimulation states =
  "[" ++ join "," (map serializeUniverseState states) ++ "]"
  where
    join : String -> List String -> String
    join sep [] = ""
    join sep [x] = x
    join sep (x :: xs) = x ++ sep ++ join sep xs

exportSimulationJSON : IO ()
exportSimulationJSON = do
  putStrLn "Generating state vectors for 3D visualizer..."
  let origin = MkPixel 0 0
  let basisX = MkPixel 4 3
  let basisY = MkPixel 3 4
  let initSubstrate = fromList [ ((origin, basisX), 1)
                               , ((origin, basisY), 1)
                               , ((basisX, basisY), 2)
                               , ((basisY, origin), 1)
                               ]
  let seedPoly = spreadPoly 5
  let seedState = fromList [ ((origin, seedPoly), 2)
                           , ((basisX, seedPoly), 1)
                           , ((basisY, seedPoly), 3)
                           ]
  let initialUniverse = MkUniverseState initSubstrate seedState
  let steps = runSimulationSteps initialUniverse 10
  let jsonStr = serializeSimulation steps
  let dest = "/var/home/justin/Projects/Nat-Science/visualizer/public/state_vectors.json"
  Right () <- writeFile dest jsonStr
    | Left err => putStrLn "Failed to write state_vectors.json to visualizer/public/"
  putStrLn "Successfully exported 10 simulation ticks to visualizer/public/state_vectors.json!"

exportModelJSONs : IO ()
exportModelJSONs = do
  putStrLn "Exporting individual models for 3D visualizer..."
  
  -- 1. Water Model
  let waterState = fromList [
        ((oPosition, spreadPoly 1), 8),
        ((oPosition, spreadPoly 3), 8),
        ((h1Position, spreadPoly 1), 1),
        ((h1Position, spreadPoly 3), 1),
        ((h1Position, spreadPoly 4), 1),
        ((h2Position, spreadPoly 1), 1),
        ((h2Position, spreadPoly 3), 1),
        ((h2Position, spreadPoly 4), 1)
      ]
  let waterSubstrate = fromList [
        ((oPosition, h1Position), 1),
        ((oPosition, h2Position), 1)
      ]
  let waterUniverse = MkUniverseState waterSubstrate waterState
  let waterJson = serializeSimulation [waterUniverse]
  Right () <- writeFile "/var/home/justin/Projects/Nat-Science/visualizer/public/water.json" waterJson
    | Left err => putStrLn "Failed to write water.json to visualizer/public/"
  putStrLn "  Successfully exported water.json!"

  -- 2. Methane Model
  let methaneState = fromList [
        ((cPosition, spreadPoly 1), 6),
        ((cPosition, spreadPoly 3), 6),
        ((ch4_h1, spreadPoly 1), 1),
        ((ch4_h1, spreadPoly 3), 1),
        ((ch4_h1, spreadPoly 4), 1),
        ((ch4_h2, spreadPoly 1), 1),
        ((ch4_h2, spreadPoly 3), 1),
        ((ch4_h2, spreadPoly 4), 1),
        ((ch4_h3, spreadPoly 1), 1),
        ((ch4_h3, spreadPoly 3), 1),
        ((ch4_h3, spreadPoly 4), 1),
        ((ch4_h4, spreadPoly 1), 1),
        ((ch4_h4, spreadPoly 3), 1),
        ((ch4_h4, spreadPoly 4), 1)
      ]
  let methaneSubstrate = fromList [
        ((cPosition, ch4_h1), 1),
        ((cPosition, ch4_h2), 1),
        ((cPosition, ch4_h3), 1),
        ((cPosition, ch4_h4), 1)
      ]
  let methaneUniverse = MkUniverseState methaneSubstrate methaneState
  let methaneJson = serializeSimulation [methaneUniverse]
  Right () <- writeFile "/var/home/justin/Projects/Nat-Science/visualizer/public/methane.json" methaneJson
    | Left err => putStrLn "Failed to write methane.json to visualizer/public/"
  putStrLn "  Successfully exported methane.json!"

  -- 3. Iron Model
  let ironPos = MkPixel 0 0
  let ironState = fromList [
        ((ironPos, spreadPoly 1), 26),
        ((ironPos, spreadPoly 3), 26)
      ]
  let ironUniverse = MkUniverseState (fromList []) ironState
  let ironJson = serializeSimulation [ironUniverse]
  Right () <- writeFile "/var/home/justin/Projects/Nat-Science/visualizer/public/iron.json" ironJson
    | Left err => putStrLn "Failed to write iron.json to visualizer/public/"
  putStrLn "  Successfully exported iron.json!"

  -- 4. Feynmanium Model
  let fyPos = MkPixel 0 0
  let fyState = fromList [
        ((fyPos, spreadPoly 1), 137),
        ((fyPos, spreadPoly 3), 137)
      ]
  let fyUniverse = MkUniverseState (fromList []) fyState
  let fyJson = serializeSimulation [fyUniverse]
  Right () <- writeFile "/var/home/justin/Projects/Nat-Science/visualizer/public/feynmanium.json" fyJson
    | Left err => putStrLn "Failed to write feynmanium.json to visualizer/public/"
  putStrLn "  Successfully exported feynmanium.json!"

main : IO ()
main = do
  putStrLn "Starting UniverseState QuickCheck Suite...\n"
  
  putStrLn "Running Test 1: Label extraction"
  let res1 = quickCheck prop_spacetimeHasLabel
  
  putStrLn "Running Test 2: Strict Causality"
  let res2 = quickCheck prop_strictCausality
  
  putStrLn "Running Test 3: Injected Baryogenesis Epoch"
  let res3 = quickCheck (property (verifyTimeline baryogenesisEpoch))
  
  putStrLn "Running Test 4: Cosmological Scaling"
  let res4 = quickCheck prop_eddingtonScaling
  
  putStrLn "Running Test 5: Negative Testing (Not 138)"
  let res5 = quickCheck prop_not138

  putStrLn "Running Test 7: Water Archimedes Signature"
  let res7 = quickCheck prop_waterArchimedes

  putStrLn "Running Test 8: Methane Causal Stability"
  let res8 = quickCheck prop_methaneStability

  putStrLn "Running Test 9: Carbon Valence Identity"
  let res9 = quickCheck prop_carbonValence

  putStrLn "Running Test 9.1: Iron Structural Lag"
  let resIron = quickCheck prop_ironLag

  putStrLn "Running Test 9.2: Feynmanium Structural Lag"
  let resFeynmanium = quickCheck prop_feynmaniumLag

  putStrLn "Running Test 10: Evolution Mass Conservation on Ascension"
  let res10 = quickCheck prop_ascensionConservesMass

  putStrLn "Running Test 11: Evolution Empty Vacuum ascension prevention"
  let res11 = quickCheck prop_emptyNeverAscends

  putStrLn "Running Test 12: Substrate Merge Lag Aggregation"
  let res12 = quickCheck prop_substrateMergeLag

  putStrLn "Running Test 13: SparseMaxel Superposition Lag Preservation"
  let res13 = quickCheck prop_superposeLag

  putStrLn "Running Test 14: Evolved Universe Synchronisation"
  let res14 = quickCheck prop_evolvedUniverseSynchronised

  putStrLn "Running Test 15: QTT SigmaBridge Round-Trip"
  let res15 = quickCheck prop_sigmaBridgeRoundTrip

  putStrLn "Running Test 16: Radiation Timelessness Proof"
  let res16 = quickCheck prop_radiationTimelessnessProof

  putStrLn "Running Test 17: Periodic Table Stability Boundary"
  let res17 = quickCheck prop_periodicTableStability

  putStrLn "Running Test 18: Pauli Exclusion on Unique Coordinates"
  let res18 = quickCheck prop_exclusionOnUniqueCoords

  putStrLn "Running Test 19: Pauli Exclusion Violated on Overlap"
  let res19 = quickCheck prop_exclusionViolatedOnOverlap

  putStrLn "Running Test 20: Meson Color Confinement"
  let res20 = quickCheck prop_mesonConfinement

  putStrLn "Running Test 21: Baryon Color Confinement"
  let res21 = quickCheck prop_baryonConfinement

  putStrLn "Running Test 22: Pixel Energy Conservation"
  let res22 = quickCheck prop_energyConservationPixel

  putStrLn "Running Test 23: Multiset Energy Conservation"
  let res23 = quickCheck prop_energyConservationMultiset

  putStrLn "Running Test 24: Primorial Manifold Conserved"
  let res24 = quickCheck prop_primorialManifoldConserved

  putStrLn "Running Test 25: Primorial Manifold Violated"
  let res25 = quickCheck prop_primorialManifoldViolated

  putStrLn "Running Test 26: Gluon Transaction Preserves Confinement"
  let res26 = quickCheck prop_gluonTransactionPreservesConfinement

  putStrLn "Running Test 27: Gluon Transaction Structural Stability"
  let res27 = quickCheck prop_gluonTransactionIsStable

  putStrLn "Running Test 28: S13 Evaluation Matches"
  let res28 = quickCheck prop_s13EvaluateMatches

  putStrLn "Running Test 29: S13 Evaluation Non-Trivial"
  let res29 = quickCheck prop_s13NonTrivial

  let tableStr = markdownTable [
        ("Label Extraction", "Verifies that UniverseState can be serialized to a non-empty string label for topological graphing.", res1),
        ("Strict Causality", "Ensures that the directed causal graph (Substrate) maintains strictly monotonic time ordering with no cycles.", res2),
        ("Injected Baryogenesis Epoch", "Validates that skipping the vacuum and starting exactly at Phase 2 dynamically unfolds the Primorial 137-Grid, leading to the Baryogenesis phase transition (MatterGate).", res3),
        ("Eddington Scaling Bound", "Confirms the polynomial scaling limits align with the Eddington Number (~10^81) within the target epochs (e.g. 38 scales).", res4),
        ("Not 138 Constraint", "Verifies that the expansion dynamics break down / decohere irrevocably if pushed to a 138-grid.", res5),
        ("Water Archimedes Signature", "Dynamically verifies that the fundamental H₂O bond geometry perfectly balances Red and Blue quadrances, yielding an invariant structural anchor.", res7),
        ("Methane Causal Stability", "Proves that Methane's Red Quadrance signature precisely sums to a Null Vector, confirming perfectly balanced dynamic oscillation across its 4 bonds.", res8),
        ("Carbon Valence Identity", "Ensures Carbon's algebraic valence mathematically equals the BondGate degree (4), formalizing why it acts as the universal organic backbone.", res9),
        ("Iron Structural Lag", "Verifies the total structural Leibniz lag of Iron matches its nucleosynthesis peak state of 52 lag units.", resIron),
        ("Feynmanium Structural Lag", "Verifies the maximum stable element Feynmanium possesses exactly 274 total lag units at the grid boundary.", resFeynmanium),
        ("Ascension Mass Conservation", "Verifies that when a state condenses into a single macro-node during topological ascension, its total mass (Leibniz Lag) is perfectly conserved.", res10),
        ("Empty Vacuum Anchor", "Ensures an empty universe cannot spontaneously ascend scales.", res11)
      ]
  
  let preamble = unlines [
        "# Linear Physics Verification Matrix",
        "",
        "This matrix tracks the automated testing suite for the core Cosmology, Chromogeometry, and Linear Memory Bridge modules.",
        "",
        "### Core Concepts",
        "* **`UniverseState`**: The purely functional mathematical data structure that models the universe. It contains the `Substrate` (a directed acyclic graph of causal evolution) and the `SparseMaxel` (the multiset of discrete spatial coordinates and spread polynomials).",
        "* **Linear Bridge**: The module that strictly wraps the `UniverseState` in Idris 2's Linear Types (`1`). This enforces at compile-time that physical states can never be duplicated (No-Cloning Theorem) or accidentally destroyed (Conservation of Energy).",
        "* **QuickCheck Properties**: Property-based testing. Instead of testing one specific state, QuickCheck procedurally generates hundreds of randomized `UniverseState` topologies and ensures the absolute physical laws hold true for *all* of them.",
        "",
        "---",
        ""
      ]
  
  putStrLn "\n--- Test Results ---"
  putStrLn tableStr
  Right () <- writeFile "Library/Wiki/Verification_Matrix.md" (preamble ++ tableStr)
    | Left err => putStrLn "Failed to write Verification_Matrix.md file."
  
  let codeTableStr = markdownTable [
        ("Substrate Merge Lag Aggregation", "Verifies that merging two causal substrates strictly aggregates their Leibniz lag (causal density).", res12),
        ("SparseMaxel Superposition Lag Preservation", "Verifies that superposing two SparseMaxels perfectly preserves the total state lag (Quantum Probability / Mass).", res13),
        ("Evolved Universe Synchronisation", "Verifies that every active, evolved UniverseState remains perfectly topologically synchronised across all epochs.", res14),
        ("QTT SigmaBridge Round-Trip", "Verifies that melting a state vector into a linear dependent multiset and freezing it back preserves the exact physical identity.", res15),
        ("Radiation Timelessness Proof", "Verifies that a pure Radiation ensemble has exactly zero temporal lag in the Minkowski metric, proving photon timelessness.", res16),
        ("Periodic Table Stability Boundary", "Verifies the exact Feynman stability limit Z <= 137 dynamically across the elements.", res17),
        ("Pauli Exclusion (Unique)", "Verifies that coordinate systems with unique elements strictly satisfy the Pauli Exclusion Principle.", res18),
        ("Pauli Exclusion (Overlap)", "Verifies that injecting duplicate coordinate assignments correctly triggers a Pauli Exclusion violation.", res19),
        ("Meson Color Confinement", "Verifies that any generated Meson dyad is colorless under the ColorConfined interface.", res20),
        ("Baryon Color Confinement", "Verifies that any generated Baryon triad is colorless under the ColorConfined interface.", res21),
        ("Pixel Energy Conservation", "Verifies that pixel transitions conserve Blue Quadrance spatial extension.", res22),
        ("Multiset Energy Conservation", "Verifies that multiset transitions conserve mass-energy degree.", res23),
        ("Primorial Manifold Conserved", "Verifies that a state pool with exactly 210 states is recognized as physically intact.", res24),
        ("Primorial Manifold Violated", "Verifies that any state pool with a non-210 size is recognized as physically violated.", res25),
        ("Gluon Transaction Confinement", "Verifies that executing a gluon transaction (matrix rotation) dynamically preserves color confinement.", res26),
        ("Gluon Transaction Stability", "Verifies that the gluon transaction is structurally stable and coordinates are preserved.", res27),
        ("S13 Evaluation Matches", "Verifies that the evaluated S13 resonance matches the S13 polynomial.", res28),
        ("S13 Evaluation Non-Trivial", "Verifies that the high-order S13 resonance is non-trivial.", res29)
      ]
      
  let codePreamble = unlines [
        "# Code Architecture Verification Matrix",
        "",
        "This matrix tracks the property-based verification of the underlying mathematical topology engines (`Math.Multiset` and `Simplex.Core`).",
        "",
        "### Core Properties",
        "* **Causal Aggregation**: Ensures that when causal graphs merge, no directed edges are lost or spuriously created.",
        "* **State Superposition**: Verifies that polynomial state vectors linearly superpose, guaranteeing Conservation of Energy at the geometric level.",
        "* **Synchronisation**: The core topological gluing condition — a state is only valid if every particle coordinate actually exists in the local causal graph.",
        "",
        "---",
        ""
      ]

  Right () <- writeFile "Library/Wiki/Code/Verification_Matrix.md" (codePreamble ++ codeTableStr)
    | Left err => putStrLn "Failed to write Code/Verification_Matrix.md file."

  putStrLn "\nTests complete. Results written to Library/Wiki/Verification_Matrix.md and Library/Wiki/Code/Verification_Matrix.md!"
  
  -- Run the individual tests that print their own outputs
  putStrLn "\n--- Engine Verification ---"
  Code.Engine_Verification.main
  
  putStrLn "\n--- Double Slit Interference ---"
  Derivation.Double_Slit_Interference.main

  putStrLn "\n--- Ascension Probe ---"
  Scale.Ascension_Probe.main
  
  putStrLn "\n--- Adaptive Cycle: Pipeline ---"
  Evolution.Adaptive_Cycle_Pipeline.main
  
  putStrLn "\n--- Adaptive Cycle: Findings ---"
  Evolution.Adaptive_Cycle_Findings.main
  
  putStrLn "\n--- Adaptive Cycle: Chemistry ---"
  Evolution.Adaptive_Cycle_Chemistry.main
  
  putStrLn "\n--- Adaptive Cycle: Scales ---"
  Evolution.Adaptive_Cycle_Scales.main

  putStrLn "\n--- State Serialization Bridge ---"
  exportSimulationJSON
  exportModelJSONs
