package com.example.kaboomapi

import retrofit2.Call
import retrofit2.http.GET

interface ApiInterface {
    @GET("v1/cartoons/series/")
    fun getCartoons(): Call<CartoonResults>
}