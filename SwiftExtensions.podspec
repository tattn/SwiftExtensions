
Pod::Spec.new do |s|

s.name         = "SwiftExtensions"
s.version      = "2.0.2"
s.summary      = "SwiftExtension for iOS."
s.homepage     = "https://github.com/biostome/SwiftExtensions.git"
s.license          = { :type => "MIT", :file => "LICENSE" }
s.author       = { "biostome" => "453816118@qq.com" }
s.platform     = :ios, "10.0"
s.source       = { :git => "https://github.com/biostome/SwiftExtensions.git", :tag => "1.0.0" }
s.source_files = "Sources/*"
s.framework    = "UIKit","Foundation"
s.requires_arc = true
s.ios.deployment_target = "10.0"
s.swift_version = "5.0"
# s.frameworks = "SomeFramework", "AnotherFramework"

end