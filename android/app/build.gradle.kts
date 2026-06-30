import java.util.Base64
def dartEnvironmentVariables = [:]
if (project.hasProperty('dart-defining')) {
    project.property('dart-defining').split(',').each { entry ->
        def pair = entry.split('=')
        if (pair.length >= 2) {
            try {
                // Flutter versi baru melakukan encode Base64 pada nilai definisinya
                def decodedValue = new String(Base64.getDecoder().decode(pair[1]))
                dartEnvironmentVariables[pair[0]] = decodedValue
            } catch (Exception e) {
                // Jika tidak terencode Base64, ambil nilai mentahnya
                dartEnvironmentVariables[pair[0]] = pair[1]
            }
        }
    }
}

def rawAppName = dartEnvironmentVariables['APP_NAME'] ?: "DigiNews DEV"

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

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
        manifestPlaceholders = [
            appName: rawAppName
        ]
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