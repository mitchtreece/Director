Pod::Spec.new do |s|

  s.name             = 'Director'
  s.version          = '1.0.1'
  s.summary          = 'Lightweight Swift coordinator library.'

  s.description      = <<-DESC
    Director is a lightweight Swift coordinator library for iOS.
    Lights, cameras, navigation.
    DESC

  s.homepage                = 'https://github.com/mitchtreece/Director'
  s.license                 = { :type => 'MIT', :file => 'LICENSE' }
  s.author                  = { 'Mitch Treece' => 'mitchtreece@me.com' }
  s.source                  = { :git => 'https://github.com/mitchtreece/Director.git', :tag => s.version.to_s }
  s.social_media_url        = 'https://twitter.com/mitchtreece'

  s.swift_version           = '5'
  s.ios.deployment_target   = '12.0'

  s.source_files = 'Director/Source/**/*'

end
