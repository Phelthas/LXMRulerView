
Pod::Spec.new do |s|

  s.name         = "LXMRulerView"
  s.version      = "2.1.1"
  s.summary      = "A rulerView could be used as a value picker or a value displayer"
  s.description  = <<-DESC
                   用drawRec方式实现的一个rulerView，间距，颜色，字体，范围等都可以自定义，也有数值变化的回调，可以用来作为数值选择器或仅仅作为一个显示用的尺子
                   DESC

  s.homepage     = "https://github.com/Phelthas/LXMRulerView"

  s.license      = "MIT"

  s.author             = { "Phelthas" => "billthas@gmail.com" }

  s.platform     = :ios, "7.0"

  s.source       = { :git => "https://github.com/Phelthas/LXMRulerView.git", :tag => "2.1.1" }

  s.source_files  = "Example/LXMRulerViewDemo/LXMRulerView/*.{h,m}"

  # s.public_header_files = "Classes/**/*.h"

  s.frameworks = "Foundation", "UIKit"

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"


  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

end
