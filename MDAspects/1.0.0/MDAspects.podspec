#
# Be sure to run `pod lib lint MDAspects.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MDAspects'
  s.version          = '1.0.0'
  s.summary          = 'AOP 补充'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
                        对著名第三方库Aspects的扩展，添加了对类方法hook的支持
                       DESC

  s.homepage         = 'https://github.com/Iyongjie/MDAspects'
  
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '李永杰' => 'iyongjie@yeah.net' }
  s.source           = { :git => 'https://github.com/Iyongjie/MDAspects.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'MDAspects/Classes/*'
  

end
