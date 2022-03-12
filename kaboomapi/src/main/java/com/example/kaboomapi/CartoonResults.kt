package com.example.kaboomapi

data class CartoonResults(
    val count: Int,
    val next: String,
    val previous: Any,
    val results: List<Cartoon>
)