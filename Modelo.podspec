#
# Be sure to run `pod lib lint Modelo.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Modelo'
  s.version          = '1.0.0'
  s.summary          = 'Protocol for Models & resolving references.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'Modelo uses the ModelType protocol and Property Wrappers for complex models with multiple references. The ModelReference PropertyWrapper allows you to quickly resolve reference synchronously and asynchronously, and uses OperationQueue to resolve references not yet fetched.'

  s.homepage         = 'https://github.com/erusso1/Modelo'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'erusso1' => 'ephraim.s.russo@gmail.com' }
  s.source           = { :git => 'https://github.com/erusso1/Modelo.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'
  s.swift_version = '5.1'
  s.source_files = 'Modelo/Classes/**/*'
  
  # s.resource_bundles = {
  #   'Modelo' => ['Modelo/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
