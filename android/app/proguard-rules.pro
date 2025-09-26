# Flutter-specific rules.
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.plugins.**  { *; }
-keep class io.flutter.embedding.android.FlutterActivity

# Razorpay-specific rules
-keepclassmembers class * {
    @android.webkit.JavascriptInterface <methods>;
}
-keepattributes JavascriptInterface
-keepattributes *Annotation*
-dontwarn com.razorpay.**
-keep class com.razorpay.** { *; }

-keep public class * extends com.google.android.gms.common.api.GoogleApi
-keep public class * extends com.google.android.gms.common.api.Api$AbstractClientBuilder
-keep public class * extends com.google.android.gms.common.api.Api$ApiOptions
-keep public class * extends com.google.android.gms.common.api.internal.TaskApiCall
