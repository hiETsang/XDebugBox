@version = "0.0.7"

Pod::Spec.new do |s| 
s.name = "XDebugBox"
s.version = @version 
s.summary = "A lightweight, visual tool for development and debugging." 
s.homepage = "https://github.com/hiETsang/XDebugBox" 
s.license = 'MIT'
s.author = { "canoe" => "canoe_likecode@163.com" } 

s.ios.deployment_target = '8.0'
s.source = { :git => "https://github.com/hiETsang/XDebugBox.git", :tag => "v#{s.version}" } 
s.source_files = 'XDebugBoxExample/XDebugBox/**/*' 
s.resources    = 'XDebugBoxExample/XDebugBox/Sources/*.{png,xib,nib,bundle}'

s.requires_arc = true 
s.framework = 'UIKit','WebKit'
end