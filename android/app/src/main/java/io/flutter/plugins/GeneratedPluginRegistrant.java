package io.flutter.plugins;

import androidx.annotation.Keep;
import androidx.annotation.NonNull;
import io.flutter.Log;

import io.flutter.embedding.engine.FlutterEngine;

/**
 * Generated file. Do not edit.
 * This file is generated by the Flutter tool based on the
 * plugins that support the Android platform.
 */
@Keep
public final class GeneratedPluginRegistrant {
  private static final String TAG = "GeneratedPluginRegistrant";
  public static void registerWith(@NonNull FlutterEngine flutterEngine) {
    try {
      flutterEngine.getPlugins().add(new co.quis.flutter_contacts.FlutterContactsPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin flutter_contacts, co.quis.flutter_contacts.FlutterContactsPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new com.yanisalfian.flutterphonedirectcaller.FlutterPhoneDirectCallerPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin flutter_phone_direct_caller, com.yanisalfian.flutterphonedirectcaller.FlutterPhoneDirectCallerPlugin", e);
    }
  }
}
