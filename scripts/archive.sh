swift package generate-xcodeproj

CONFIGURATION=Release
PROJECT_NAME=SwiftExtensions-Package
OUTPUT_DIR=./output
DERIVED_DIR=${OUTPUT_DIR}/${CONFIGURATION}-derived
ARCHIVE_DIR=${OUTPUT_DIR}/${CONFIGURATION}-archive
XCFRAMEWORK_DIR=${OUTPUT_DIR}/${CONFIGURATION}-xcframework
ARCHIVE_FILE_IOS=${ARCHIVE_DIR}/ios.xcarchive
ARCHIVE_FILE_IOS_SIMULATOR=${ARCHIVE_DIR}/iossimulator.xcarchive

rm -rf ${OUTPUT_DIR}
mkdir -p ${DERIVED_DIR}
mkdir -p ${ARCHIVE_DIR}
mkdir -p ${XCFRAMEWORK_DIR}

# Make an archive for the real iOS device
xcodebuild archive -scheme ${PROJECT_NAME} -destination="generic/platform=iOS" -archivePath $ARCHIVE_FILE_IOS -derivedDataPath $DERIVED_DIR -sdk iphoneos SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES EXCLUDED_ARCHS=armv7

# Make an archive for the iOS simulator
xcodebuild archive -scheme ${PROJECT_NAME} -destination="generic/platform=iOS Simulator" -archivePath $ARCHIVE_FILE_IOS_SIMULATOR -derivedDataPath $DERIVED_DIR SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES

make_xcframework () {
	xcodebuild -create-xcframework -framework $ARCHIVE_FILE_IOS/Products/Library/Frameworks/$1.framework -framework $ARCHIVE_FILE_IOS_SIMULATOR/Products/Library/Frameworks/$1.framework -output $XCFRAMEWORK_DIR/$1.xcframework
}

make_xcframework SwiftExtensions
make_xcframework SwiftExtensionsUI
make_xcframework SwiftExtensionsUIKit
cp scripts/template/Package.swift $XCFRAMEWORK_DIR/

