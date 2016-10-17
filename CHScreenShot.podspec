
Pod::Spec.new do |s|
  s.name         = "CHScreenShot"
  s.version      = "1.0.1"
  s.summary      = "Swift3编写的截屏分享组件"
  s.description  = <<-DESC
                   Swift3编写的截屏分享组件，支持设备快捷键截屏和手动截屏
                   DESC

  s.homepage     = "https://github.com/zhiquan911/CHScreenShot"

  s.license      = "MIT"
  s.author       = { "Chance" => "zhiquan911@qq.com" }
  s.platform     = :ios, "9.0"
  s.ios.deployment_target = '9.0'
  s.source       = { :git => "https://github.com/zhiquan911/CHScreenShot.git", :tag => s.version}
  s.source_files = "CHScreenShot/CHScreenShot/classes/*.{swift,h,m}"
  s.requires_arc = true


end

#验证命令：pod lib lint CHScreenShot.podspec --verbose
#提交命令：pod trunk push CHScreenShot.podspec

