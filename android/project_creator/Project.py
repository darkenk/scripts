class Project:
    gradle = """apply plugin: 'com.android.application'

android {{
    compileSdkVersion {compileSdkVersion}
    defaultConfig {{
        minSdkVersion {sdkVersion}
        targetSdkVersion {sdkVersion}
        externalNativeBuild {{
            cmake {{
                cppFlags "-std=c++11"
                arguments "-DAOSP={aosp}"
            }}
        }}
    }}

    sourceSets {{
        main {{
            manifest.srcFile 'AndroidManifest.xml'
        }}
    }}

    externalNativeBuild {{
        cmake {{
            path "CMakeLists.txt"
        }}
    }}
}}"""

    manifest = """<manifest package="com.stub.native"/>"""

    cmake = """cmake_minimum_required(VERSION 3.4.1)"""

    def __init__(self, compileSdkVersion, sdkVersion, aosp, projectName = None):
        self.gradleFormat = dict(compileSdkVersion=compileSdkVersion,
                                 sdkVersion=sdkVersion,
                                 aosp=aosp)
        self.cmake = self.cmake
        self.objectFiles = []
        self.globalIncludes = []
        self.globalSystemIncludes = []
        self.globalDefines = []
        self.srcFiles = []
        self.projectName = projectName


    def getManifest(self):
        return self.manifest


    def getGradle(self):
        return self.gradle.format(**self.gradleFormat)


    def getCmake(self):
        entryPrefix = "${AOSP}/"
        cmake = self.cmake
        cmake += "\n"
        cmake += self.addGlobals("include_directories(", self.globalIncludes, entryPrefix)
        cmake += self.addGlobals("include_directories(SYSTEM", self.globalSystemIncludes, entryPrefix)
        cmake += self.addGlobals("add_definitions(", self.globalDefines)
        cmake += self.addGlobals("set(SRC", self.srcFiles, entryPrefix)
        cmake += "add_library({} SHARED ${{SRC}})".format(self.projectName)
        return cmake

    def addGlobals(self, prefix, entries, entryPrefix = ""):
        file = ""
        file +=  prefix + "\n"
        for entry in entries:
            file += " " * 4 + entryPrefix + entry + "\n"
        file += ")\n\n"
        return file

    def addFile(self, file):
        if len(self.srcFiles) == 0:
            self.globalIncludes.extend(file.includes)
            self.globalSystemIncludes.extend(file.systemIncludes)
            self.globalDefines.extend(file.defines)
        else:
            includes = set(file.includes) - set(self.globalIncludes)
            defines =  set(file.defines) - set(self.globalDefines)
            systemIncludes = set(file.systemIncludes) - set(self.globalSystemIncludes)
            if len(includes) != 0 or len(defines) != 0 or len(systemIncludes):
                file.includes = includes
                file.defines = defines
                file.systemIncludes = systemIncludes
                self.objectFiles.append(file)
        self.srcFiles.append(file.source)
        return