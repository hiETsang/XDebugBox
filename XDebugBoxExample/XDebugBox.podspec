@version = "0.0.1"

Pod::Spec.new do |s| 
s.name = "XDebugBox"
s.version = @version 
s.summary = "A lightweight, visual tool for development and debugging." 
s.description = "XDebugBox是一个轻量级且安全，可视化的便于开发调试的工具。对项目无侵入，配置简单，并且可以自定义项目开发需求，致力于减少一些开发过程中不必要且耗时的操作。" 
s.homepage = "https://github.com/hiETsang/XDebugBox" 
s.license = { :type => 'MIT', :file => 'LICENSE' } 
s.author = { "canoe" => "canoe_likecode@163.com" } 
s.ios.deployment_target = '8.0'
s.source = { :git => "https://github.com/hiETsang/XDebugBox.git", :tag => "v#{s.version}" } 
s.source_files = 'XDebugBoxExample/XDebugBox/*' 
s.requires_arc = true 
s.framework = "UIKit" 
end