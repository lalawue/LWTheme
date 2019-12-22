#
#  Be sure to run `pod spec lint LWThemeObjC.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name         = "LWThemeObjC"
  spec.version      = "0.0.1"
  spec.summary      = "A Theme Color Management Library for ObjectiveC."

  spec.description  = <<-DESC
 A Theme Color Management Library for ObjectiveC
                   DESC

  spec.homepage     = "http://github.com/lalawue/LWTheme"
  spec.license      = "MIT"

  spec.author       = "lalawue"

  spec.source       = { :git => "http://github.com/lalawue/LWTheme.git", :tag => "#{spec.version}" }

  spec.source_files  = "Classes", "Classes/**/*.{h,m}"
  spec.exclude_files = "Classes/Exclude"

  spec.public_header_files = "Classes/ThemeObject/*.h", "Classes/ThemeManager/*.h"

end

