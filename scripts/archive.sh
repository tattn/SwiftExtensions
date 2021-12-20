swift package generate-xcodeproj

CONFIGURATION=Release
PROJECT_NAME=SwiftExtensions-Package
OUTPUT_DIR=./output
DERIVED_DIR=${OUTPUT_DIR}/${CONFIGURATION}-derived
ARCHIVE_DIR=${OUTPUT_DIR}/${CONFIGURATION}-archive
XCFRAMEWORK_DIR=${OUTPUT_DIR}/${CONFIGURATION}-xcframework
ARCHIVE_FILE_IOS=${ARCHIVE_DIR}/ios.xcarchive
ARCHIVE_FILE_IOS_SIMULATOR=${ARCHIVE_DIR}/iossimulator.xcarchive
ARCHIVE_FILE_MACOS=${ARCHIVE_DIR}/macos.xcarchive

rm -rf ${OUTPUT_DIR}
mkdir -p ${DERIVED_DIR}
mkdir -p ${ARCHIVE_DIR}
mkdir -p ${XCFRAMEWORK_DIR}

archive() {
	xcodebuild archive -scheme ${PROJECT_NAME} -destination="$1" -archivePath "$2" -derivedDataPath $DERIVED_DIR SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES $3
}

# Make an archive for the real iOS device
archive "generic/platform=iOS" "$ARCHIVE_FILE_IOS" "EXCLUDED_ARCHS=armv7"

# Make an archive for the iOS simulator
archive "generic/platform=iOS Simulator" "$ARCHIVE_FILE_IOS_SIMULATOR" ""

# Make an archive for the macOS
# archive "generic/platform=macOS" "$ARCHIVE_FILE_MACOS" ""

make_xcframework() {
	xcodebuild -create-xcframework -framework $ARCHIVE_FILE_IOS/Products/Library/Frameworks/$1.framework -framework $ARCHIVE_FILE_IOS_SIMULATOR/Products/Library/Frameworks/$1.framework -output $XCFRAMEWORK_DIR/$1.xcframework
}

make_xcframework SwiftExtensions
make_xcframework SwiftExtensionsUI
make_xcframework SwiftExtensionsUIKit
cp scripts/template/Package.swift $XCFRAMEWORK_DIR/

