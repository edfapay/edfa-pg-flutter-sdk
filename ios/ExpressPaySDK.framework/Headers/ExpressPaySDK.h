//
//  ExpressPaySDK.h
//  ExpressPaySDK
//
//  Created by Zohaib Kambrani on 26/01/2023.
// To Archive the Framework (xcodebuild archive)
// To Clean/Build/Arvice the Framework  (xcodebuild -project ExpressPaySDK.xcodeproj -scheme ExpressPaySDK -configuration Release CONFIGURATION_BUILD_DIR=. clean build)


/*
// Could not find module 'ExpressPaySDK' for target 'arm64-apple-ios-simulator'; found: arm64-apple-ios, at: /Volumes/EdfaPay/Codes/Github/ExpressPay/iOS/expresspay-ios-sdk-framework/ExpressPaySDK.framework/Modules/ExpressPaySDK.swiftmodule


// Archive Framework for Simulator
xcodebuild archive \
-scheme ExpressPaySDK \
-configuration Release \
-destination 'generic/platform=iOS Simulator' \
-archivePath './build/ExpressPaySDK.framework-iphonesimulator.xcarchive' \
SKIP_INSTALL=NO \
BUILD_LIBRARIES_FOR_DISTRIBUTION=YES \
MARKETING_VERSION=0.0.6 \
CURRENT_PROJECT_VERSION=0.0.6


// Archive Framework for iOS
xcodebuild archive \
-scheme ExpressPaySDK \
-configuration Release \
-destination 'generic/platform=iOS' \
-archivePath './build/ExpressPaySDK.framework-iphoneos.xcarchive' \
SKIP_INSTALL=NO \
BUILD_LIBRARIES_FOR_DISTRIBUTION=YES \
MARKETING_VERSION=0.0.6 \
CURRENT_PROJECT_VERSION=0.0.6

*/

#import <Foundation/Foundation.h>

//! Project version number for ExpressPaySDK.
FOUNDATION_EXPORT double ExpressPaySDKVersionNumber = 2;

//! Project version string for ExpressPaySDK.
FOUNDATION_EXPORT const unsigned char ExpressPaySDKVersionString[];

// In this header, you should import all the public headers of your framework using statements like


