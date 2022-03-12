package com.example.kaboommobile

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.widget.TextView
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import java.lang.StringBuilder

const val BASE_URL = "https://staging-kaboom.herokuapp.com/"
class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        getMyCartoons()
    }

    private fun getMyCartoons() {
        val builder = Retrofit.Builder()
            .addConverterFactory(GsonConverterFactory.create())
            .baseUrl(BASE_URL)
            .build()
            .create(ApiInterface::class.java)

        val data = builder.getCartoons()

        data.enqueue(object : Callback<CartoonResults?> {
            override fun onResponse(
                call: Call<CartoonResults?>,
                response: Response<CartoonResults?>
            ) {
                val body = response.body()!!

                val strBuilder = StringBuilder()
                for (item in body.results) {
                    strBuilder.append(item.name)
                    strBuilder.append("\n")
                }

                val textView: TextView = findViewById<TextView>(R.id.names)
                textView.text = strBuilder
            }

            override fun onFailure(call: Call<CartoonResults?>, t: Throwable) {
                Log.d("MainActivity", "onFailure: " + t.message)
            }
        })
    }
}