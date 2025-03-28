package com.punch.looking2hire

import io.flutter.embedding.android.FlutterActivity
import android.content.Intent
import android.nfc.NfcAdapter
import androidx.annotation.NonNull
//import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

//class MainActivity : FlutterActivity()
class MainActivity: FlutterActivity() {
    private val CHANNEL = "nfc_channel"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call, result ->
            when (call.method) {
                "getInitialIntent" -> handleInitialIntent(result)
                else -> result.notImplemented()
            }
        }
    }

    private fun handleInitialIntent(result: MethodChannel.Result) {
    val intent = this.intent
    if (intent?.action == NfcAdapter.ACTION_NDEF_DISCOVERED) {
        val ndefMessages = intent.getParcelableArrayExtra(NfcAdapter.EXTRA_NDEF_MESSAGES)
        if (ndefMessages != null && ndefMessages.isNotEmpty()) {
            val ndefMessage = ndefMessages[0] as android.nfc.NdefMessage
            val record = ndefMessage.records[0]
            val payload = record.payload
            // Convert entire payload to string (skip MIME type bytes)
            val jsonString = String(payload, 0, payload.size - 0, Charsets.UTF_8)
            result.success(jsonString)
            return
        }
    }
    result.success(null)
}
}