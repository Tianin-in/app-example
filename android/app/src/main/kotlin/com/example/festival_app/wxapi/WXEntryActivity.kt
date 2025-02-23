package com.example.festival_app.wxapi

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.util.Log
import com.tencent.mm.opensdk.modelbase.BaseReq
import com.tencent.mm.opensdk.modelbase.BaseResp
import com.tencent.mm.opensdk.openapi.IWXAPI
import com.tencent.mm.opensdk.openapi.IWXAPIEventHandler
import com.tencent.mm.opensdk.openapi.WXAPIFactory

class WXEntryActivity : Activity(), IWXAPIEventHandler {
    private lateinit var api: IWXAPI
    private val TAG = "WXEntryActivity"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        Log.d(TAG, "onCreate")
        api = WXAPIFactory.createWXAPI(this, "wx0b3db4684108f23b", false)
        try {
            val result = api.handleIntent(intent, this)
            Log.d(TAG, "handleIntent result: $result")
        } catch (e: Exception) {
            Log.e(TAG, "handleIntent error", e)
        }
    }

    override fun onNewIntent(intent: Intent?) {
        super.onNewIntent(intent)
        Log.d(TAG, "onNewIntent")
        setIntent(intent)
        api.handleIntent(intent, this)
    }

    override fun onReq(req: BaseReq?) {
        Log.d(TAG, "onReq: $req")
    }

    override fun onResp(resp: BaseResp?) {
        Log.d(TAG, "onResp: $resp")
        finish()
    }
} 