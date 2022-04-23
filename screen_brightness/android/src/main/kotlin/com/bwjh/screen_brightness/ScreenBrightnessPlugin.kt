package com.bwjh.screen_brightness

import android.app.Activity
import android.content.Context
import android.os.Build
import android.os.PowerManager
import android.provider.Settings
import android.util.Log
import androidx.annotation.NonNull
import androidx.lifecycle.LifecycleRegistry
import com.bwjh.screen_brightness.stream_handler.CurrentBrightnessChangeStreamHandler

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.embedding.engine.plugins.lifecycle.HiddenLifecycleReference
import io.flutter.plugin.common.EventChannel
import java.lang.reflect.Field
import kotlin.properties.Delegates
import android.view.WindowManager
import kotlin.math.sign

/** ScreenBrightnessPlugin */
class ScreenBrightnessPlugin : FlutterPlugin, EventChannel.StreamHandler,
    Messages.HostScreenBrightnessApi,
    ActivityAware {
    private lateinit var currentBrightnessChangeEventChannel: EventChannel

    private var eventSink: EventChannel.EventSink? = null

    private var currentBrightnessChangeStreamHandler: CurrentBrightnessChangeStreamHandler? = null

    private var activity: Activity? = null

    /**
     * The value which will be init when this plugin is attached to the Flutter engine
     *
     * This value refer to the maximum brightness value.
     *
     * By system default the value should be 255.0f, however it vary in some OS, e.g Miui.
     * Should not be changed in the future
     */
    private var maximumBrightness = 0.0

    /**
     * The value which will be init when this plugin is attached to the Flutter engine
     *
     * This value refer to the brightness value between 0 to 1 when the application initialized.
     */
    private var systemBrightness = 0.0

    /**
     * The value which will be set when user called [handleSetScreenBrightnessMethodCall]
     * or [handleResetScreenBrightnessMethodCall]
     *
     * This value refer to the brightness value between 0 to 1 when user called [handleSetScreenBrightnessMethodCall].
     */
    private var changedBrightness: Double? = null

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        currentBrightnessChangeEventChannel =
            EventChannel(flutterPluginBinding.binaryMessenger, "com.bwjh.screen_brightness")
        currentBrightnessChangeEventChannel.setStreamHandler(this)
        Messages.HostScreenBrightnessApi.setup(flutterPluginBinding.binaryMessenger, this)

        try {
            maximumBrightness = getScreenMaximumBrightness(flutterPluginBinding.applicationContext)
            systemBrightness = getSystemBrightness(flutterPluginBinding.applicationContext)
        } catch (e: Settings.SettingNotFoundException) {
            e.printStackTrace()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        Messages.HostScreenBrightnessApi.setup(binding.binaryMessenger, null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        this.activity = binding.activity

        currentBrightnessChangeStreamHandler =
            CurrentBrightnessChangeStreamHandler(
                binding.activity,
                onListenStart = null,
                onChange = { eventSink ->
                    systemBrightness = getSystemBrightness(binding.activity)
                    if (changedBrightness == null) {
                        eventSink.success(systemBrightness)
                    }
                })
        currentBrightnessChangeEventChannel.setStreamHandler(currentBrightnessChangeStreamHandler)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        this.activity = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        this.activity = binding.activity
    }

    override fun onDetachedFromActivity() {
        this.activity = null
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        eventSink = events
    }

    override fun onCancel(arguments: Any?) {
    }

    private fun getSystemBrightness(context: Context): Double {
        return Settings.System.getInt(
            context.contentResolver,
            Settings.System.SCREEN_BRIGHTNESS
        ) / maximumBrightness
    }

    private fun getScreenMaximumBrightness(context: Context): Double {
        try {
            val powerManager: PowerManager =
                context.getSystemService(Context.POWER_SERVICE) as PowerManager?
                    ?: throw ClassNotFoundException()
            val fields: Array<Field> = powerManager.javaClass.declaredFields
            for (field in fields) {
                if (field.name.equals("BRIGHTNESS_ON")) {
                    field.isAccessible = true
                    return (field[powerManager] as Int).toDouble()
                }
            }

            return 255.0
        } catch (e: Exception) {
            return 255.0
        }
    }

    override fun getSystemBrightness(): Double {
        return systemBrightness
    }

    override fun getCurrentBrightness(): Double {
        val activity = activity
        if (activity == null) {
            //result.error("-10", "Unexpected error on activity binding", null)
            return -10.0
        }

        var brightness: Double?
        // get current window attribute brightness
        val layoutParams: WindowManager.LayoutParams = activity.window.attributes
        brightness = layoutParams.screenBrightness.toDouble()
        // check brightness changed
        if (brightness != -1.0) {
            // return changed brightness
            return brightness
        }

        // get system setting brightness
        try {
            brightness = getSystemBrightness(activity)
        } catch (e: Settings.SettingNotFoundException) {
            e.printStackTrace()
        }

        if (brightness == null) {
            //result.error("-11", "Could not found system setting screen brightness value", null)
            return -11.0
        }

        return brightness
    }

    override fun resetScreenBrightness() {
        val activity = activity
        if (activity == null) {
            //result.error("-10", "Unexpected error on activity binding", null)
            return
        }

        val isSet =
            setWindowsAttributesBrightness(WindowManager.LayoutParams.BRIGHTNESS_OVERRIDE_NONE.toDouble())
        if (!isSet) {
            //result.error("-1", "Unable to change screen brightness", null)
            return
        }

        changedBrightness = null
        handleCurrentBrightnessChanged(systemBrightness)
    }

    private fun setWindowsAttributesBrightness(brightness: Double): Boolean {
        return try {
            val layoutParams: WindowManager.LayoutParams = activity!!.window.attributes
            layoutParams.screenBrightness = brightness.toFloat()
            activity!!.window.attributes = layoutParams
            true
        } catch (e: Exception) {
            false
        }
    }

    private fun handleCurrentBrightnessChanged(currentBrightness: Double) {
        currentBrightnessChangeStreamHandler?.addCurrentBrightnessToEventSink(currentBrightness)
    }

    override fun hasChanged(): Boolean {
        return changedBrightness != null
    }

    override fun isScreenLocked(): Boolean {
        val pm = activity!!.getSystemService(Context.POWER_SERVICE) as PowerManager
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT_WATCH) {
            !pm.isInteractive
        } else {
            !pm.isScreenOn
        }
    }

    override fun setScreenBrightness(brightness: Double) {
        val activity = activity
        if (activity == null) {
            //result.error("-10", "Unexpected error on activity binding", null)
            return
        }

        val isSet = setWindowsAttributesBrightness(brightness)
        if (!isSet) {
            //result.error("-1", "Unable to change screen brightness", null)
            return
        }

        changedBrightness = brightness
        handleCurrentBrightnessChanged(brightness)
    }
}
