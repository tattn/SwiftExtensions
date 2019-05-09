
Pod::Spec.new do |s|

s.name         = "BTSwiftExtensions"
s.version      = "2.0.3"
s.summary      = "SwiftExtension for iOS."
s.homepage     = "https://github.com/biostome/BTSwiftExtensions.git"
s.license          = { :type => "MIT", :file => "LICENSE" }
s.author       = { "biostome" => "453816118@qq.com" }
s.platform     = :ios, "9.0"
s.source       = { :git => "https://github.com/biostome/BTSwiftExtensions.git", :tag => s.version }
s.source_files = "Sources/*.{swift,h}"
s.requires_arc = true
s.ios.deployment_target = "9.0"
s.swift_version = "5.0"
# s.frameworks = "SomeFramework", "AnotherFramework"
#s.framework    = "UIKit","Foundation"

end
