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
ARCHIVE_FILE_WATCHOS=${ARCHIVE_DIR}/watchos.xcarchive
ARCHIVE_FILE_WATCHOS_SIMULATOR=${ARCHIVE_DIR}/watchossimulator.xcarchive
ARCHIVE_FILE_TVOS=${ARCHIVE_DIR}/tvos.xcarchive
ARCHIVE_FILE_TVOS_SIMULATOR=${ARCHIVE_DIR}/tvossimulator.xcarchive

rm -rf ${OUTPUT_DIR}
mkdir -p ${DERIVED_DIR} ${ARCHIVE_DIR} ${XCFRAMEWORK_DIR}

archive() {
	xcodebuild archive -scheme ${PROJECT_NAME} -destination="$1" -sdk $2 -archivePath "$3" -derivedDataPath $DERIVED_DIR SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES $4
}

# Make archives
archive "generic/platform=iOS" "iphoneos" "$ARCHIVE_FILE_IOS" "EXCLUDED_ARCHS=armv7"
archive "generic/platform=iOS Simulator" "iphonesimulator" "$ARCHIVE_FILE_IOS_SIMULATOR" "-arch arm64 -arch x86_64"
archive "generic/platform=macOS" "macosx" "$ARCHIVE_FILE_MACOS" ""
archive "generic/platform=watchOS" "watchos" "$ARCHIVE_FILE_WATCHOS"
archive "generic/platform=watchOS Simulator" "watchsimulator" "$ARCHIVE_FILE_WATCHOS_SIMULATOR"
archive "generic/platform=tvOS" "appletvos" "$ARCHIVE_FILE_TVOS"
archive "generic/platform=tvOS Simulator" "appletvsimulator" "$ARCHIVE_FILE_TVOS_SIMULATOR"

make_xcframework() {
	xcodebuild -create-xcframework \
		-framework $ARCHIVE_FILE_IOS/Products/Library/Frameworks/$1.framework \
		-framework $ARCHIVE_FILE_IOS_SIMULATOR/Products/Library/Frameworks/$1.framework \
		-framework $ARCHIVE_FILE_MACOS/Products/Library/Frameworks/$1.framework \
		-framework $ARCHIVE_FILE_WATCHOS/Products/Library/Frameworks/$1.framework \
		-framework $ARCHIVE_FILE_WATCHOS_SIMULATOR/Products/Library/Frameworks/$1.framework \
		-framework $ARCHIVE_FILE_TVOS/Products/Library/Frameworks/$1.framework \
		-framework $ARCHIVE_FILE_TVOS_SIMULATOR/Products/Library/Frameworks/$1.framework \
		-output $XCFRAMEWORK_DIR/$1.xcframework
	}

make_xcframework SwiftExtensions
make_xcframework SwiftExtensionsUI
make_xcframework SwiftExtensionsUIKit
cp scripts/template/Package.swift $XCFRAMEWORK_DIR/
