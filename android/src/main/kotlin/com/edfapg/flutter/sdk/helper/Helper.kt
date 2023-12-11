package com.edfapg.flutter.sdk.helper

import com.google.gson.Gson

class Helper {
    companion object{
        fun toJSON(model:Any) : Map<*,*>{
            val map:Map<*,*> = Gson().fromJson(Gson().toJson(model), Map::class.java)
            return map
        }
    }
}

