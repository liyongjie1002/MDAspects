
Pod::Spec.new do |s|
  s.name             = 'MDAspects'
  s.version          = '1.0.2'
  s.summary          = 'AOP 提高开发效率'
  s.description      = <<-DESC
                        对著名第三方库Aspects的扩展，添加了对类方法hook的支持
                       DESC

  s.homepage         = 'https://github.com/Iyongjie/MDAspects'
  
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '李永杰' => 'iyongjie@yeah.net' }
  s.source           = { :git => 'https://github.com/Iyongjie/MDAspects.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'MDAspects/*'
   
end
