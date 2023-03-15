package com.expresspay.fluttersdk.helper

import com.expresspay.sdk.model.response.base.ExpresspayResponse
import com.google.gson.Gson
import java.io.Serializable


fun Serializable.toJSON() = Gson().toJson(this)
fun Serializable.toMap() = Gson().fromJson(toJSON(), Map::class.java)
fun Serializable.fromJSON(json:String) = Gson().fromJson(json, this::class.java)


fun ExpresspayResponse<*>.toMap() : Map<*,*>?{
    return  (this as? ExpresspayResponse.Error)?.let {
        it.error.toMap()
    } ?: (this as? ExpresspayResponse.Result)?.let {
        Gson().fromJson(it.jsonObject, Map::class.java)
    }
}