#
# Be sure to run `pod lib lint Director.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|

  s.name             = 'Director'
  s.version          = '1.0.0'
  s.summary          = 'Lightweight Swift coordinator library.'

  s.description      = <<-DESC
    Lightweight Swift coordinator library.
    DESC

  s.homepage                = 'https://github.com/mitchtreece/Director'
  s.license                 = { :type => 'MIT', :file => 'LICENSE' }
  s.author                  = { 'Mitch Treece' => 'mitchtreece@me.com' }
  s.source                  = { :git => 'https://github.com/mitchtreece/Director.git', :tag => s.version.to_s }
  s.social_media_url        = 'https://twitter.com/mitchtreece'

  s.swift_version           = '5'
  s.ios.deployment_target   = '8.0'

  s.source_files = 'Director/Source/**/*'

end
