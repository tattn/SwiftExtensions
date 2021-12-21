VERSION=3.0.0-beta.0

cp scripts/template/ReleasePackage.swift Package.swift

cat <<EOS  >> Package.swift
package.targets = package.targets + [
EOS

for name in "${FRAMEWORK_NAMES[@]}"; do
	cat <<EOS  >> Package.swift
	.binaryTarget(
		name: "$name",
		url: "https://github.com/tattn/SwiftExtensions/releases/download/$VERSION/$name.xcframework.zip",
		checksum: "`swift package compute-checksum $XCFRAMEWORK_DIR/$name.xcframework.zip`"
	),
EOS
done

cat <<EOS  >> Package.swift
]

package.products = package.targets
    .filter { !\$0.isTest }
    .map { Product.library(name: \$0.name, targets: [\$0.name]) }
EOS
