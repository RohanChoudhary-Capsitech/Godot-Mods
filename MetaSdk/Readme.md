# Meta SDK Setup for Godot

This guide shows the full setup needed to integrate the Meta / Facebook SDK into a Godot Android export.

## 1. AndroidManifest.xml

Replace your custom manifest with:

```xml
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools"
    package="com.thegamewise.symbolsync"
    android:versionCode="1"
    android:versionName="1.0"
    android:installLocation="auto">

    <uses-permission android:name="android.permission.INTERNET"/>

    <supports-screens
        android:smallScreens="true"
        android:normalScreens="true"
        android:largeScreens="true"
        android:xlargeScreens="true" />

    <uses-feature
        android:glEsVersion="0x00030000"
        android:required="true" />

    <application
        android:label="@string/godot_project_name_string"
        android:allowBackup="false"
        android:icon="@mipmap/icon"
        android:appCategory="game"
        android:isGame="true"
        tools:ignore="GoogleAppIndexingWarning">

        <profileable
            android:shell="true"
            android:enabled="true"
            tools:targetApi="29" />

        <activity
            android:name=".GodotApp"
            android:theme="@style/GodotAppSplashTheme"
            android:launchMode="singleTask"
            android:exported="true"
            android:screenOrientation="landscape"
            android:windowSoftInputMode="adjustResize"
            android:configChanges="layoutDirection|locale|orientation|keyboardHidden|screenSize|smallestScreenSize|density|keyboard|navigation|screenLayout|uiMode"
            android:resizeableActivity="false">

            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>

        </activity>

        <meta-data
            android:name="com.facebook.sdk.ApplicationId"
            android:value="YOUR_APP_ID"/>

        <meta-data
            android:name="com.facebook.sdk.ClientToken"
            android:value="YOUR_CLIENT_TOKEN"/>

    </application>

</manifest>
```

## 2. `build.gradle` (Module: `app`)

Add this dependency:

```gradle
dependencies {
    implementation 'com.facebook.android:facebook-android-sdk:16.3.0'
}
```

## 3. `GodotApp.java`

Path:

```text
android/build/src/main/java/com/godot/game/GodotApp.java
```

Use:

```java
package com.godot.game;

import org.godotengine.godot.Godot;
import org.godotengine.godot.GodotActivity;

import android.os.Bundle;
import android.util.Log;
import android.content.SharedPreferences;

import androidx.activity.EdgeToEdge;
import androidx.core.splashscreen.SplashScreen;

import com.facebook.FacebookSdk;
import com.facebook.LoggingBehavior;
import com.facebook.appevents.AppEventsLogger;

public class GodotApp extends GodotActivity {

    static {
        if (org.godotengine.godot.BuildConfig.FLAVOR.equals("mono")) {
            try {
                Log.v("GODOT", "Loading System.Security.Cryptography.Native.Android library");
                System.loadLibrary("System.Security.Cryptography.Native.Android");
            } catch (UnsatisfiedLinkError e) {
                Log.e("GODOT", "Unable to load System.Security.Cryptography.Native.Android library");
            }
        }
    }

    private final Runnable updateWindowAppearance = () -> {
        Godot godot = getGodot();
        if (godot != null) {
            godot.enableImmersiveMode(godot.isInImmersiveMode(), true);
            godot.enableEdgeToEdge(godot.isInEdgeToEdgeMode(), true);
            godot.setSystemBarsAppearance();
        }
    };

    @Override
    public void onCreate(Bundle savedInstanceState) {
        SplashScreen.installSplashScreen(this);
        EdgeToEdge.enable(this);

        super.onCreate(savedInstanceState);

        FacebookSdk.sdkInitialize(getApplicationContext());

        FacebookSdk.setIsDebugEnabled(true);
        FacebookSdk.addLoggingBehavior(LoggingBehavior.APP_EVENTS);

        SharedPreferences prefs = getSharedPreferences("fb_prefs", MODE_PRIVATE);
        AppEventsLogger logger = AppEventsLogger.newLogger(this);

        if (!prefs.getBoolean("first_launch_done", false)) {
            prefs.edit().putBoolean("first_launch_done", true).apply();

            logger.logEvent("first_opened");
            Log.d("FB_EVENT", "First opened event sent");

        } else {
            logger.logEvent("app_opened_again");
            Log.d("FB_EVENT", "App opened again event sent");
        }
    }

    @Override
    public void onResume() {
        super.onResume();
        updateWindowAppearance.run();
    }

    @Override
    public void onGodotMainLoopStarted() {
        super.onGodotMainLoopStarted();
        runOnUiThread(updateWindowAppearance);
    }

    @Override
    public void onGodotForceQuit(Godot instance) {
        if (!org.godotengine.godot.BuildConfig.FLAVOR.equals("instrumented")) {
            super.onGodotForceQuit(instance);
        }
    }
}
```

## 4. Godot Export Settings

Set the package name to:

```text
Use the Package that is already or will be updated in PlayStore
```

Location:

```text
Godot -> Export -> Android -> Package -> Unique Name
```

## 5. Build Steps

In Android Studio:

```text
Sync Project
Build -> Clean Project
Build -> Assemble Project
```

Then in Godot:

```text
Export APK
Install on Meta Quest
Run App
```

## 6. Events Sent

On first install:

```text
first_opened
```

On every later launch:

```text
app_opened_again
```

## 7. Reset First Launch Event

You can reset the first-launch event by:

```text
Uninstalling the app and reinstalling the APK
```

or:

```text
Clearing app data
```

## Notes

- Replace `YOUR_APP_ID` with your real Meta / Facebook App ID.
- Replace `YOUR_CLIENT_TOKEN` with your real client token.
- Keep package names consistent across Godot, Android, and the Meta / Facebook app settings.
