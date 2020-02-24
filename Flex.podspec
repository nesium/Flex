Pod::Spec.new do |spec|
  spec.name                 = "Flex"
  spec.version              = "0.10.0"
  spec.summary              = "Flex"
  spec.homepage             = "https://github.com/nesium/Flex.git"
  spec.license              = "MIT license"
  spec.author               = "Marc Bauer"
  spec.platform             = :ios, "10.0"
  spec.source               = { :git => "https://github.com/nesium/Flex.git", :tag => "#{spec.version}" }
  spec.source_files         = "Sources/Flex.h", "Sources/Flex/**/*.{swift,h}", "Sources/Yoga/**/*.cpp", "Sources/YogaDebug/**/*.{h,mm}"
  spec.public_header_files  = "Sources/Flex.h"
  spec.exclude_files        = "Sources/Flex/Layout/FlexLayout+Debug.swift"
  spec.pod_target_xcconfig  = { 'HEADER_SEARCH_PATHS' => '$(PODS_ROOT)/Yoga/include' }
  spec.swift_version        = "5.1"
  spec.module_name          = "Flex"
  spec.preserve_paths       = "Sources/Yoga/include/module.modulemap", "yoga/yoga/**/*.{h,cpp}", "Sources/Yoga/include"
  spec.pod_target_xcconfig  = { "SWIFT_INCLUDE_PATHS" => "$(SRCROOT)/Flex/Sources/Yoga/**" }
  spec.xcconfig             = {
    "CLANG_CXX_LANGUAGE_STANDARD" => "gnu++14"
  }
end
