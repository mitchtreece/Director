Pod::Spec.new do |s|

  s.name             = 'Director'
  s.version          = '1.0.5'
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
  s.ios.deployment_target   = '11.0'

  # Subspecs

  s.default_subspec = 'Core'

  s.subspec 'Core' do |core|

      core.source_files       = 'Director/Source/Core/**/*'

  end

  s.subspec 'DI' do |di|

      di.source_files       = 'Director/Source/DI/**/*'
      di.dependency         'Director/Core'
      di.dependency         'Swinject', '~> 2.7.0'

  end

  s.subspec 'All' do |all|

      all.dependency        'Director/Core'
      all.dependency        'Director/DI'

  end

end
