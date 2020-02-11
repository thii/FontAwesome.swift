Pod::Spec.new do |s|
  s.name             = "FontAwesome.swift"
  s.version          = "1.8.2"
  s.summary          = "Use Font Awesome in your Swift projects"
  s.homepage         = "https://github.com/thii/FontAwesome.swift"
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { "Thi Doan" => "t@thi.im" }
  s.source           = { :git => "https://github.com/thii/FontAwesome.swift.git", :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.tvos.deployment_target = '9.0'
  s.osx.deployment_target = '10.11'
  s.requires_arc = true

  s.source_files = 'FontAwesome/*.{swift}', 'FontAwesome/Extensions/*.{swift}'
  s.ios.source_files = s.tvos.source_files = 'FontAwesome/UIKit/*.{swift}'
  s.osx.source_files = 'FontAwesome/AppKit/**/*.{swift}'
  s.resources = 'FontAwesome/*.otf'
  s.frameworks = 'CoreText'
  s.ios.frameworks = s.tvos.frameworks = 'UIKit'
  s.osx.frameworks = 'AppKit'
  s.swift_version = "5.0"

  s.test_spec do |test_spec|
    test_spec.source_files  = "FontAwesomeTests/**/*.swift"
  end
end
