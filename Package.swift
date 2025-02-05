// swift-tools-version: 5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let czLibExcludes: [String] = [
    "CMakeLists.txt", "ChangeLog", "FAQ", "INDEX",
    "Makefile", "Makefile.in", "README",
    "amiga/Makefile.pup", "amiga/Makefile.sas", "configure", "configure.log",
    "doc/algorithm.txt", "doc/rfc1950.txt", "doc/rfc1951.txt",
    "doc/rfc1952.txt", "doc/txtvsbin.txt", "make_vms.com",
    "msdos/Makefile.bor", "msdos/Makefile.dj2",
    "msdos/Makefile.emx", "msdos/Makefile.msc", "msdos/Makefile.tc",
    "nintendods/Makefile", "nintendods/README",
    "old/Makefile.emx", "old/Makefile.riscos", "old/README",
    "old/descrip.mms", "old/os2/Makefile.os2", "old/visual-basic.txt",
    "os400/README400", "os400/bndsrc", "os400/make.sh", "os400/zlib.inc",
    "qnx/package.qpg", "treebuild.xml",
    "watcom/watcom_f.mak", "watcom/watcom_l.mak",
    "win32/DLL_FAQ.txt", "win32/Makefile.bor", "win32/Makefile.gcc",
    "win32/Makefile.msc", "win32/README-WIN32.txt",
    "win32/VisualC.txt", "win32/zlib1.rc",
    "zconf.h.cmakein", "zconf.h.in", "zlib.3", "zlib.3.pdf",
    "zlib.map", "zlib.pc", "zlib.pc.cmakein", "zlib.pc.in", "zlib2ansi"
]

let flags: [String] = ["-Wno-conversion"]
let cSettings = [CSetting.unsafeFlags(flags)]

let package = Package(
    name: "Perfect",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15)
    ],
    products: [
        .library(name: "PerfectCRUD", targets: ["PerfectCRUD"]),
        .library(name: "PerfectCrypto", targets: ["PerfectCrypto"]),
        .library(name: "PerfectLib", targets: ["PerfectLib"]),
        .library(name: "PerfectHTTP", targets: ["PerfectHTTP"]),
        .library(name: "PerfectHTTPServer", targets: ["PerfectHTTPServer"]),
        .library(name: "PerfectMustache", targets: ["PerfectMustache"]),
        .library(name: "PerfectNet", targets: ["PerfectNet"]),
        .library(name: "PerfectSQLite", targets: ["PerfectSQLite"]),
        .library(name: "PerfectThread", targets: ["PerfectThread"])
    ],
    dependencies: [ ],
    targets: [
        .target(name: "COpenSSL", cSettings: cSettings),
        .target(name: "PerfectCZlib", exclude: czLibExcludes, cSettings: cSettings),
        .target(name: "PerfectCHTTPParser"),
        .target(name: "PerfectCRUD"),
        .target(name: "PerfectLib"),
        .target(name: "PerfectThread"),
        .target(name: "PerfectCrypto", dependencies: ["PerfectLib", "PerfectThread", "COpenSSL"]),
        .target(name: "PerfectHTTP", dependencies: ["PerfectLib", "PerfectNet"]),
        .target(name: "PerfectHTTPServer", dependencies: ["PerfectCHTTPParser", "PerfectNet", "PerfectHTTP", "PerfectCZlib"]),
        .target(name: "PerfectMustache", dependencies: ["PerfectLib"]),
        .target(name: "PerfectNet", dependencies: ["PerfectCrypto", "PerfectThread"]),
        .target(name: "PerfectSQLite", dependencies: ["PerfectCRUD"]),
        .testTarget(name: "PerfectCryptoTests", dependencies: ["PerfectCrypto"]),
        .testTarget(name: "PerfectHTTPTests", dependencies: ["PerfectHTTP"]),
        .testTarget(name: "PerfectHTTPServerTests", dependencies: ["PerfectHTTPServer"]),
        .testTarget(name: "PerfectLibTests", dependencies: ["PerfectLib"]),
        .testTarget(name: "PerfectMustacheTests", dependencies: ["PerfectMustache"]),
        .testTarget(name: "PerfectNetTests", dependencies: ["PerfectNet"]),
        .testTarget(name: "PerfectSQLiteTests", dependencies: ["PerfectSQLite"]),
        .testTarget(name: "PerfectThreadTests", dependencies: ["PerfectThread"])
    ]
)
