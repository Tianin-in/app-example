package mo.festivalre.wxapi

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.util.Log
import com.tencent.mm.opensdk.modelbase.BaseReq
import com.tencent.mm.opensdk.modelbase.BaseResp
import com.tencent.mm.opensdk.modelmsg.SendAuth
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
            api.handleIntent(intent, this)
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

    override fun onReq(baseReq: BaseReq) {
        Log.d(TAG, "onReq: $baseReq")
    }

    override fun onResp(resp: BaseResp) {
        Log.d(TAG, "onResp: $resp")
        
        when (resp) {
            is SendAuth.Resp -> {
                val result = when (resp.errCode) {
                    BaseResp.ErrCode.ERR_OK -> {
                        // 授权成功
                        Log.i(TAG, "Auth success, code: ${resp.code}")
                        "success"
                    }
                    BaseResp.ErrCode.ERR_USER_CANCEL -> {
                        // 用户取消
                        Log.i(TAG, "Auth canceled by user")
                        "cancel"
                    }
                    BaseResp.ErrCode.ERR_AUTH_DENIED -> {
                        // 授权被拒绝
                        Log.i(TAG, "Auth denied")
                        "denied"
                    }
                    else -> {
                        // 其他错误
                        Log.e(TAG, "Auth error: ${resp.errCode}, ${resp.errStr}")
                        "error"
                    }
                }
                
                // 发送广播通知Flutter层
                val intent = Intent("mo.festivalre.WX_AUTH")
                intent.putExtra("state", result)
                intent.putExtra("code", resp.code)
                sendBroadcast(intent)
            }
        }
        finish()
    }
} 