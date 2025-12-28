package com.edfapg.flutter.sdk.helper

import com.edfapg.sdk.model.request.Extra
import com.edfapg.sdk.model.response.base.EdfaPgResponse
import com.google.gson.Gson
import com.google.gson.reflect.TypeToken
import java.io.Serializable

internal val ExtrasType = object : TypeToken<List<Extra>>() {}.type

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