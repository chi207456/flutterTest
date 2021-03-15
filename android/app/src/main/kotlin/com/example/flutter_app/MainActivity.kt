package com.example.flutter_app

import android.content.Context
import android.content.Intent
import android.hardware.Sensor
import android.hardware.SensorManager
import android.os.Bundle
import com.google.gson.Gson
import com.google.gson.reflect.TypeToken
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.*
import io.flutter.plugins.GeneratedPluginRegistrant
import java.io.InputStream
import java.nio.ByteBuffer

class MainActivity : FlutterActivity() {
    private var sharedText: String? = null
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        // Creates a MethodChannel as soon as the FlutterEngine is attached to
        // the Activity, and registers a MethodCallHandler. The Method.setMethodCallHandler
        // is responsible to register a MethodCallHandler to handle the incoming calls.

        // The call parameter of MethodCallHandler has information about the incoming call,
        // like method name, and arguments. The result parameter of MethodCallHandler is
        // responsible to send the results of the call.
        MethodChannel(flutterEngine.dartExecutor, "methodChannelDemo")
                .setMethodCallHandler { call, result ->
                    val count: Int? = call.argument<Int>("count")

                    if (count == null) {
                        result.error("INVALID ARGUMENT", "Value of count cannot be null", null)
                    } else {
                        when (call.method) {
                            "increment" -> result.success(count + 1)
                            "decrement" -> result.success(count - 1)
                            else -> result.notImplemented()
                        }
                    }
                }
        MethodChannel(flutterEngine.dartExecutor, "app.channel.shared.data")
                .setMethodCallHandler { call, result ->
                    when (call.method) {
                        "getSharedText" -> {
                            result.success(sharedText)
                            sharedText = null

                        }
                    }
                }

        val sensorManger: SensorManager = getSystemService(Context.SENSOR_SERVICE) as SensorManager
        val accelerometerSensor: Sensor = sensorManger.getDefaultSensor(Sensor.TYPE_ACCELEROMETER)
        EventChannel(flutterEngine.dartExecutor, "eventChannelDemo")
                .setStreamHandler(AccelerometerStreamHandler(sensorManger, accelerometerSensor))

        // Registers a MessageHandler for BasicMessageChannel to receive a message from Dart and send
        // image data in reply.
        BasicMessageChannel(flutterEngine.dartExecutor, "platformImageDemo", StandardMessageCodec())
                .setMessageHandler { message, reply ->
                    if (message == "getImage") {
                        val inputStream: InputStream = assets.open("eat_new_orleans.png")
                        reply.reply(inputStream.readBytes())
                    }
                }

        val petList = mutableListOf<Map<String, String>>()
        val gson = Gson()

        // A BasicMessageChannel for sending petList to Dart.
        val stringCodecChannel = BasicMessageChannel(flutterEngine.dartExecutor, "stringCodecDemo", StringCodec.INSTANCE)

        // Registers a MessageHandler for BasicMessageChannel to receive pet details to be
        // added in petList and send the it back to Dart using stringCodecChannel.
        BasicMessageChannel(flutterEngine.dartExecutor, "jsonMessageCodecDemo", JSONMessageCodec.INSTANCE)
                .setMessageHandler { message, reply ->
                    petList.add(0, gson.fromJson(message.toString(), object : TypeToken<Map<String, String>>() {}.type))
                    stringCodecChannel.send(gson.toJson(mapOf("petList" to petList)))
                }

        // Registers a MessageHandler for BasicMessageChannel to receive the index of pet
        // details to be removed from the petList and send the petList back to Dart using
        // stringCodecChannel. If the index is not in the range of petList, we send null
        // back to Dart.
        BasicMessageChannel(flutterEngine.dartExecutor, "binaryCodecDemo", BinaryCodec.INSTANCE)
                .setMessageHandler { message, reply ->
                    val index = String(message!!.array()).toInt()
                    if (index >= 0 && index < petList.size) {
                        petList.removeAt(index)
                        val replyMessage = "Removed Successfully"
                        reply.reply(ByteBuffer.allocateDirect(replyMessage.toByteArray().size).put(replyMessage.toByteArray()))
                        stringCodecChannel.send(gson.toJson(mapOf("petList" to petList)))
                    } else {
                        reply.reply(null)
                    }
                }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(flutterEngine!!)
        if (intent.action == Intent.ACTION_SEND && intent.type == "text/plain") {
            handleSendText(intent)
        }
    }

    fun handleSendText(intent: Intent) {
        sharedText = intent.getStringExtra(Intent.EXTRA_TEXT)
    }

}
