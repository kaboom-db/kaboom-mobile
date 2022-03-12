package com.example.kaboommobile

data class Cartoon(
    val background_image: String,
    val characters: List<Any>,
    val cover_image: String,
    val date_created: String,
    val genres: List<Any>,
    val id: Int,
    val imdb_id: Any,
    val name: String,
    val network: Network,
    val rating: Double,
    val season_count: Int,
    val status: String,
    val summary: String,
    val tmdb_id: Any,
    val website: Any
)