import java.util.Properties

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystorePropertiesFile.inputStream().use { keystoreProperties.load(it) }
}

android {
    namespace = "com.jiulang.prompt.optimizer"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    signingConfigs {
        if (keystorePropertiesFile.exists()) {
            val keyAliasStr = keystoreProperties.getProperty("keyAlias")
            val keyPasswordStr = keystoreProperties.getProperty("keyPassword")
            val storeFileStr = keystoreProperties.getProperty("storeFile")
            val storePasswordStr = keystoreProperties.getProperty("storePassword")

            if (keyAliasStr != null && keyPasswordStr != null && storeFileStr != null && storePasswordStr != null) {
                create("release") {
                    keyAlias = keyAliasStr
                    keyPassword = keyPasswordStr
                    storeFile = file(storeFileStr)
                    storePassword = storePasswordStr
                }
            } else {
                println("Warning: key.properties exists but some properties are missing. Skipping release signing config.")
            }
        }
    }

    defaultConfig {
        applicationId = "com.jiulang.prompt.optimizer"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = if (keystorePropertiesFile.exists()) {
                signingConfigs.getByName("release")
            } else {
                signingConfigs.getByName("debug")
            }
        }
    }
}

flutter {
    source = "../.."
}
