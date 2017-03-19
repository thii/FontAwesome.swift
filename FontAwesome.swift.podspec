Pod::Spec.new do |s|
  s.name             = "FontAwesome.swift"
  s.version          = "1.1.1"
  s.summary          = "Use Font Awesome in your Swift projects"
  s.homepage         = "https://github.com/thii/FontAwesome.swift"
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { "Thi Doan" => "t@thi.im" }
  s.source           = { :git => "https://github.com/thii/FontAwesome.swift.git", :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.tvos.deployment_target = '9.0'
  s.requires_arc = true

  s.source_files = 'FontAwesome/*.{swift}'
  s.resource_bundle = { 'FontAwesome.swift' => 'FontAwesome/*.otf' }
  s.frameworks = 'UIKit', 'CoreText'
end
