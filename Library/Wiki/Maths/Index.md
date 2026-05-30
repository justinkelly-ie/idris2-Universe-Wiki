# Section: The QTT Linear Memory Bridge

This section documents the compile-time mathematical bridge that binds Quantitative Type Theory (QTT) with the pure integer multiset engine.

## Core Concepts

*   **Quantitative Type Theory (QTT)**: By wrapping universe state transformations with Idris 2's strictly linear types (`1`), the compiler guarantees at compile-time that state vectors can never be duplicated (No-Cloning Theorem) or accidentally destroyed (Conservation of Energy).
*   **The Linear Memory Bridge**: Safely bridges high-performance flat pure multisets with linear state wrappers, providing compile-time type-safety without execution overhead.

## Section Contents

*   **[Linear Bridge Properties](LinearBridgeProperties.md)**: Proofs of compile-time linear bridge round-trips and physical conservation laws.
