#!/bin/bash

DEST='generic/platform=iOS'

#if [ $2 == 'SIM' ]
#then
#DEST='generic/platform=iOS Simulator'
#fi

xcodebuild archive \
-scheme ExpressPaySDK \
-configuration Release \
-destination $DEST \
-archivePath './build/ExpressPaySDK.framework-iphoneos.xcarchive' \
SKIP_INSTALL=NO \
BUILD_LIBRARIES_FOR_DISTRIBUTION=YES \
MARKETING_VERSION=$1 \
CURRENT_PROJECT_VERSION=$1

# Copy update/generated framework to the flutter plugin
echo -e "${bold}Copying update/generated framework to the flutter plugin"
echo -e "--> /Volumes/EdfaPay/Codes/Github/ExpressPay/Flutter/expresspay-flutter-sdk/ios"
echo -e "\n"
cp -R ./build/ExpressPaySDK.framework-iphoneos.xcarchive/Products/Library/Frameworks/ExpressPaySDK.framework \
/Volumes/EdfaPay/Codes/Github/ExpressPay/Flutter/expresspay-flutter-sdk/ios/



# Copy update/generated framework to the ExpressPay Sample project
echo -e "Copying update/generated framework to the ExpressPay Sample project"
echo -e "--> /Volumes/EdfaPay/Codes/Github/ExpressPay/iOS/expresspay-ios-sdk-framework"
echo -e "\n\n"
cp -R ./build/ExpressPaySDK.framework-iphoneos.xcarchive/Products/Library/Frameworks/ExpressPaySDK.framework \
/Volumes/EdfaPay/Codes/Github/ExpressPay/iOS/expresspay-ios-sdk-framework/


open ./build/ExpressPaySDK.framework-iphoneos.xcarchive/Products/Library/Frameworks/
