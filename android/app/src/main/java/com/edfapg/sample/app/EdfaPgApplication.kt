/*
 * Property of EdfaPg (https://edfapay.com).
 */

package com.edfapg.sample.app

import android.app.Application
import android.content.pm.ApplicationInfo
import android.webkit.WebView
import com.edfapg.sdk.core.EdfaPgSdk
import io.kimo.lib.faker.Faker


class EdfaPgApplication : Application() {

    override fun onCreate() {
        super.onCreate()
        Faker.with(this)

        EdfaPgSdk.init(
            this,
            "b5abdab4-5c46-11ed-a7be-8e03e789c25f",
            "cdb715a1b482b2af375785d70e8005cd",
            "https://api.expresspay.sa/post"
        )

        if (0 != applicationInfo.flags and ApplicationInfo.FLAG_DEBUGGABLE) {
            WebView.setWebContentsDebuggingEnabled(true)
        }
    }
}
