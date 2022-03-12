package com.example.kaboommobile

data class CartoonResults(
    val count: Int,
    val next: String,
    val previous: Any,
    val results: List<Cartoon>
)