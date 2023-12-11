package com.edfapg.flutter.sdk.helper

import com.edfapg.sdk.model.response.base.EdfaPgResponse
import com.google.gson.Gson
import java.io.Serializable


fun Serializable.toJSON() = Gson().toJson(this)
fun Serializable.toMap() = Gson().fromJson(toJSON(), Map::class.java)
fun Serializable.fromJSON(json:String) = Gson().fromJson(json, this::class.java)


fun EdfaPgResponse<*>.toMap() : Map<*,*>?{
    return  (this as? EdfaPgResponse.Error)?.let {
        it.error.toMap()
    } ?: (this as? EdfaPgResponse.Result)?.let {
        Gson().fromJson(it.jsonObject, Map::class.java)
    }
}