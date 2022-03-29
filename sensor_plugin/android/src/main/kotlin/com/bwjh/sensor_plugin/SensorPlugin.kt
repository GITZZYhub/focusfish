package com.bwjh.sensor_plugin

import android.content.Context
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import org.json.JSONObject
import java.math.BigDecimal

/** SensorPlugin */
class SensorPlugin: FlutterPlugin, EventChannel.StreamHandler, Messages.HostSensorPluginApi {
  private lateinit var eventChannel: EventChannel

  private var aSensor: Sensor? = null
  private var mSensor: Sensor? = null

  private var mSensorManager: SensorManager? = null

  private var eventSink: EventChannel.EventSink? = null

  private var X = 0f
  private var Y = 0f
  private var accelerometerValues = FloatArray(3)
  private var magneticFieldValues = FloatArray(3)
  private val sensorValuesTemp = FloatArray(3)

  private var SENSOR_FIX_COUNT = 10000 //传感器固定频率100Hz

  private var SENSOR_FIX_ALPHA = 0.97f

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    eventChannel = EventChannel(flutterPluginBinding.binaryMessenger, "com.bwjh.sensor_plugin")
    eventChannel.setStreamHandler(this)
    Messages.HostSensorPluginApi.setup(flutterPluginBinding.binaryMessenger, this)
    initSensor(flutterPluginBinding.applicationContext)
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    Messages.HostSensorPluginApi.setup(binding.binaryMessenger, null)
    unregisterSensor()
    mSensorManager = null
    aSensor = null
    mSensor = null
  }

  override fun isSensorAvailable(): Boolean {
    return aSensor != null && mSensor != null
  }

  private fun initSensor(context: Context) {
    mSensorManager = context.getSystemService(Context.SENSOR_SERVICE) as SensorManager?
    aSensor = mSensorManager?.getDefaultSensor(Sensor.TYPE_ACCELEROMETER)
    mSensor = mSensorManager?.getDefaultSensor(Sensor.TYPE_MAGNETIC_FIELD)
  }

  override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
    registerSensor()
    eventSink = events
  }

  override fun onCancel(arguments: Any?) {
    unregisterSensor()
  }

  private fun registerSensor() {
    mSensorManager!!.registerListener(myListener, aSensor, SENSOR_FIX_COUNT)
    mSensorManager!!.registerListener(myListener, mSensor, SENSOR_FIX_COUNT)
  }

  private fun unregisterSensor() {
    if (mSensorManager != null) {
      mSensorManager!!.unregisterListener(myListener)
    }
  }

  private val myListener: SensorEventListener = object : SensorEventListener {
    override fun onSensorChanged(sensorEvent: SensorEvent) {
      synchronized(this) {
        if (sensorEvent.sensor.type == Sensor.TYPE_MAGNETIC_FIELD) {
          magneticFieldValues = sensorEvent.values.clone()
        }
        if (sensorEvent.sensor.type == Sensor.TYPE_ACCELEROMETER) {
          accelerometerValues = sensorEvent.values.clone()
        }
        calculateOrientation()
      }
    }

    override fun onAccuracyChanged(sensor: Sensor?, accuracy: Int) {
    }
  }

  /**
   * 计算传感器角度
   */
  private fun calculateOrientation() {
    val values = FloatArray(3)
    val temp = FloatArray(9)
    val Rr = FloatArray(9)
    SensorManager.getRotationMatrix(temp, null, accelerometerValues, magneticFieldValues)
    //Remap to camera's point-of-view
    SensorManager.remapCoordinateSystem(
      temp,
      SensorManager.AXIS_X,
      SensorManager.AXIS_Z, Rr
    )
    SensorManager.getOrientation(Rr, values)
    values[0] = Math.toDegrees(values[0].toDouble()).toFloat()
    values[1] = Math.toDegrees(values[1].toDouble()).toFloat()
    values[2] = Math.toDegrees(values[2].toDouble()).toFloat()

    //传感器数据去噪方法，一阶差分
    sensorValuesTemp[0] =
      SENSOR_FIX_ALPHA * sensorValuesTemp[0] + (1 - SENSOR_FIX_ALPHA) * values[0]
    sensorValuesTemp[1] =
      SENSOR_FIX_ALPHA * sensorValuesTemp[1] + (1 - SENSOR_FIX_ALPHA) * values[1]
    sensorValuesTemp[2] =
      SENSOR_FIX_ALPHA * sensorValuesTemp[2] + (1 - SENSOR_FIX_ALPHA) * values[2]
    X = -sensorValuesTemp[1]
    Y = sensorValuesTemp[2]
    val obj = JSONObject()
    var bg: BigDecimal = BigDecimal(X.toDouble())
    obj.put("X", bg.setScale(1, BigDecimal.ROUND_HALF_UP).toDouble())
    bg = BigDecimal(Y.toDouble())
    obj.put("Y", bg.setScale(1, BigDecimal.ROUND_HALF_UP).toDouble())
    eventSink?.success(obj.toString())
  }

}
