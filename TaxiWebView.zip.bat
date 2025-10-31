@echo off
title إنشاء تطبيق Taxi WebView
color 0a
echo ==============================================
echo      🚖 إنشاء مشروع Taxi WebView تلقائياً
echo ==============================================
echo.

set app_name=Taxi
set package_name=com.taxi.webview
set app_url=https://saadiraq2025-cyber.github.io/saad/
set folder=TaxiWebView

echo جاري إنشاء المجلد...
mkdir %folder%
cd %folder%
mkdir src
mkdir res
mkdir res\drawable

echo جاري إنشاء AndroidManifest.xml...
(
echo ^<?xml version="1.0" encoding="utf-8"?^>
echo ^<manifest xmlns:android="http://schemas.android.com/apk/res/android"
echo     package="%package_name%"^>
echo     ^<uses-permission android:name="android.permission.INTERNET"/^>
echo     ^<application android:label="%app_name%" android:icon="@drawable/icon" android:usesCleartextTraffic="true"^>
echo         ^<activity android:name=".MainActivity"^>
echo             ^<intent-filter^>
echo                 ^<action android:name="android.intent.action.MAIN"/^>
echo                 ^<category android:name="android.intent.category.LAUNCHER"/^>
echo             ^</intent-filter^>
echo         ^</activity^>
echo     ^</application^>
echo ^</manifest^>
) > AndroidManifest.xml

echo جاري إنشاء MainActivity.java...
(
echo package com.taxi.webview;
echo import android.app.Activity;
echo import android.os.Bundle;
echo import android.webkit.WebView;
echo import android.webkit.WebViewClient;
echo import android.widget.Toast;
echo import android.net.ConnectivityManager;
echo import android.net.NetworkInfo;
echo public class MainActivity extends Activity {
echo     @Override
echo     protected void onCreate(Bundle savedInstanceState) {
echo         super.onCreate(savedInstanceState);
echo         WebView webView = new WebView(this);
echo         webView.getSettings().setJavaScriptEnabled(true);
echo         webView.setWebViewClient(new WebViewClient());
echo         if (isOnline()) {
echo             webView.loadUrl("%app_url%");
echo         } else {
echo             Toast.makeText(this, "الرجاء الاتصال بالإنترنت", Toast.LENGTH_LONG).show();
echo         }
echo         setContentView(webView);
echo     }
echo     private boolean isOnline() {
echo         ConnectivityManager cm = (ConnectivityManager) getSystemService(CONNECTIVITY_SERVICE);
echo         NetworkInfo netInfo = cm.getActiveNetworkInfo();
echo         return netInfo != null && netInfo.isConnected();
echo     }
echo }
) > src\MainActivity.java

echo جاري إنشاء أيقونة افتراضية...
(
echo  .
echo    [🚖]
echo  .
) > res\drawable\icon.txt

echo تم إنشاء ملفات المشروع.
cd ..
echo.
echo جاري ضغط المجلد إلى TaxiWebView.zip ...
powershell Compress-Archive -Path "%folder%" -DestinationPath "TaxiWebView.zip" -Force

echo.
echo ✅ تم إنشاء الملف TaxiWebView.zip بنجاح!
echo موجود في نفس المجلد الحالي.
pause
