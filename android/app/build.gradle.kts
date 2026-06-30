import java.util.Base64

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

val dartEnvironmentVariables = mutableMapOf<String, String>()
if (project.hasProperty("dart-defining")) {
    project.property("dart-defining").toString().split(",").forEach { entry ->
        val pair = entry.split("=")
        if (pair.size >= 2) {
            try {
                val decodedValue = String(Base64.getDecoder().decode(pair[1]))
                dartEnvironmentVariables[pair[0]] = decodedValue
            } catch (e: Exception) {
                dartEnvironmentVariables[pair[0]] = pair[1]
            }
        }
    }
}
val rawAppName = dartEnvironmentVariables["APP_NAME"] ?: "DigiNews DEV"

android {
    namespace = "com.example.uas_mobile_lanjut"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.uas_mobile_lanjut"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        
        manifestPlaceholders += mapOf(
            "appName" to rawAppName
        )
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}