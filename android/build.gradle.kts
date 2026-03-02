allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
allprojects {
    tasks.withType<com.android.build.gradle.tasks.ExternalNativeBuildJsonTask> {
        doFirst {
            // Force NDK path or version here
        }
    }
}

subprojects {
    project.evaluationDependsOn(":app")
}

subprojects {
    plugins.withType<com.android.build.gradle.BasePlugin> {
        val extension = project.extensions.getByName("android")
        if (extension is com.android.build.gradle.BaseExtension) {
            extension.ndkVersion = "27.0.12077973"
            extension.defaultConfig.minSdk = 24
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
