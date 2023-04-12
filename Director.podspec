Pod::Spec.new do |s|

  s.name             = 'Director'
  s.version          = '1.1.0'
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
  s.ios.deployment_target   = '13.0'

  # Subspecs

  s.default_subspec = 'Core'

  s.subspec 'Core' do |ss|

    ss.source_files = 'Director/Source/Core/**/*'

  end

  s.subspec 'DI' do |ss|

      ss.source_files = 'Director/Source/DI/**/*'

      ss.dependency   'Director/Core'
      ss.dependency   'Swinject', '~> 2.0'

  end

  s.subspec 'All' do |ss|

      ss.dependency 'Director/Core'
      ss.dependency 'Director/DI'

  end

end
