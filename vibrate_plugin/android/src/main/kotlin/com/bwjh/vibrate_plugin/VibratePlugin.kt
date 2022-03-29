package com.bwjh.vibrate_plugin

import android.content.Context
import android.os.Build
import android.os.VibrationEffect
import android.os.Vibrator
import android.view.HapticFeedbackConstants
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin

/** VibratePlugin */
class VibratePlugin : FlutterPlugin, Messages.HostVibratePluginApi {

  private lateinit var _vibrator: Vibrator

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    Messages.HostVibratePluginApi.setup(flutterPluginBinding.binaryMessenger, this)
    _vibrator =
      flutterPluginBinding.applicationContext.getSystemService(Context.VIBRATOR_SERVICE) as Vibrator
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    Messages.HostVibratePluginApi.setup(binding.binaryMessenger, null)
  }

  override fun vibrate(duration: Int?) {
    if (_vibrator.hasVibrator()) {
      if (Build.VERSION.SDK_INT >= 26) {
        _vibrator.vibrate(
          VibrationEffect.createOneShot(
            duration?.toLong() ?: 0,
            VibrationEffect.DEFAULT_AMPLITUDE
          )
        )
      } else {
        _vibrator.vibrate(duration?.toLong() ?: 0)
      }
    }
  }

  override fun canVibrate(): Boolean {
    return _vibrator.hasVibrator()
  }

  override fun feedback(feedbackType: Messages.FeedbackTypeClass?) {
    if (_vibrator.hasVibrator()) {
      when (feedbackType?.type) {
        Messages.FeedbackType.impact -> {
          if (Build.VERSION.SDK_INT >= 26) {
            _vibrator.vibrate(
              VibrationEffect.createOneShot(
                HapticFeedbackConstants.VIRTUAL_KEY.toLong(),
                VibrationEffect.DEFAULT_AMPLITUDE
              )
            )
          } else {
            _vibrator.vibrate(HapticFeedbackConstants.VIRTUAL_KEY.toLong())
          }
        }
        Messages.FeedbackType.selection -> {
          if (Build.VERSION.SDK_INT >= 26) {
            _vibrator.vibrate(
              VibrationEffect.createOneShot(
                HapticFeedbackConstants.KEYBOARD_TAP.toLong(),
                VibrationEffect.DEFAULT_AMPLITUDE
              )
            )
          } else {
            _vibrator.vibrate(HapticFeedbackConstants.KEYBOARD_TAP.toLong())
          }
        }
        Messages.FeedbackType.success -> {
          val duration = 50L
          if (Build.VERSION.SDK_INT >= 26) {
            _vibrator.vibrate(
              VibrationEffect.createOneShot(
                duration,
                VibrationEffect.DEFAULT_AMPLITUDE
              )
            )
          } else {
            _vibrator.vibrate(duration)
          }
        }
        Messages.FeedbackType.warning -> {
          val duration = 250L
          if (Build.VERSION.SDK_INT >= 26) {
            _vibrator.vibrate(
              VibrationEffect.createOneShot(
                duration,
                VibrationEffect.DEFAULT_AMPLITUDE
              )
            )
          } else {
            _vibrator.vibrate(duration)
          }
        }
        Messages.FeedbackType.error -> {
          val duration = 500L
          if (Build.VERSION.SDK_INT >= 26) {
            _vibrator.vibrate(
              VibrationEffect.createOneShot(
                duration,
                VibrationEffect.DEFAULT_AMPLITUDE
              )
            )
          } else {
            _vibrator.vibrate(duration)
          }
        }
        Messages.FeedbackType.heavy -> {
          val duration = 100L
          if (Build.VERSION.SDK_INT >= 26) {
            _vibrator.vibrate(
              VibrationEffect.createOneShot(
                duration,
                VibrationEffect.DEFAULT_AMPLITUDE
              )
            )
          } else {
            _vibrator.vibrate(duration)
          }
        }
        Messages.FeedbackType.medium -> {
          val duration = 40L
          if (Build.VERSION.SDK_INT >= 26) {
            _vibrator.vibrate(
              VibrationEffect.createOneShot(
                duration,
                VibrationEffect.DEFAULT_AMPLITUDE
              )
            )
          } else {
            _vibrator.vibrate(duration)
          }
        }
        Messages.FeedbackType.light -> {
          val duration = 10L
          if (Build.VERSION.SDK_INT >= 26) {
            _vibrator.vibrate(
              VibrationEffect.createOneShot(
                duration,
                VibrationEffect.DEFAULT_AMPLITUDE
              )
            )
          } else {
            _vibrator.vibrate(duration)
          }
        }
        else -> {
          vibrate(500)
        }
      }
    }
  }
}
