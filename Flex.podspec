Pod::Spec.new do |spec|
  spec.name                 = "Flex"
  spec.version              = "0.10.0"
  spec.summary              = "Flex"
  spec.homepage             = "https://github.com/nesium/Flex.git"
  spec.license              = "MIT license"
  spec.author               = "Marc Bauer"
  
  spec.platform             = :ios, "11.0"
  spec.source               = { :git => "https://github.com/nesium/Flex.git", :tag => "#{spec.version}" }
  spec.source_files         = "Sources/Flex/**/*.swift", "yoga/yoga/**/*.{h,cpp}"
  spec.public_header_files = [
    "yoga/yoga/Yoga.h",
    "yoga/yoga/YGEnums.h",
    "yoga/yoga/YGMacro.h",
    "yoga/yoga/YGValue.h"
  ]
  spec.swift_version        = "5.1"
  spec.module_name          = "Flex"
  spec.preserve_paths       = "Sources/Yoga/include/module.modulemap"
  spec.pod_target_xcconfig  = { "SWIFT_INCLUDE_PATHS" => "$(SRCROOT)/Flex/Sources/Yoga/**" }
  spec.xcconfig             = {
    "CLANG_CXX_LANGUAGE_STANDARD" => "gnu++14"
  }
end
