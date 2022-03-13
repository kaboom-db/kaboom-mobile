package com.example.kaboommobile.api

import com.example.kaboommobile.models.CartoonResults
import retrofit2.Call
import retrofit2.http.GET

interface ApiInterface {
    @GET("v1/cartoons/series/")
    fun getCartoons(): Call<CartoonResults>
}