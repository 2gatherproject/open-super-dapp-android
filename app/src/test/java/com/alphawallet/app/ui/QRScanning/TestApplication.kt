package com.alphawallet.app.ui.QRScanning

import android.app.Application
import android.content.Context

open class TestApplication: Application() {
    override fun getApplicationContext(): Context {
        return this
    }
}
