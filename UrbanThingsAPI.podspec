Pod::Spec.new do |s|
  s.name             = "UrbanThingsAPI"
  s.version          = "0.9.5"
  s.summary          = "UrbanThings SDK framework for UrbanThings Transport API"
  s.description      = <<-DESC
Provides Swift framework for all Apple platforms to access the UrbanThings Transport API
                        DESC
  s.homepage         = "https://github.com/urbanthings/urbanthings-sdk-apple"
  s.license          = 'MIT'
  s.author           = { "UrbanThings" => "apisupport@urbanthings.io" }
  s.source           = { :git => "https://github.com/urbanthings/urbanthings-sdk-apple.git", :tag => s.version.to_s }

  s.requires_arc          = true

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.9'
  s.watchos.deployment_target = '2.0'
  s.tvos.deployment_target = '9.0'

  s.source_files          = 'UrbanThingsAPI/**/*.{swift,h}'
  s.watchos.exclude_files = '**/MKPolyline+GooglePolyline.swift'
end
