#
# Be sure to run `pod lib lint PINTextFieldView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PINTextFieldView'
  s.version          = '0.1.0'
  s.summary          = 'Its a insert pincode View.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  PINTextFieldView is a library used for accepting pincodes.
                       DESC

  s.homepage         = 'https://github.com/sampaioroberto/PINTextFieldView'

  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Roberto Sampaio' => 'ssampaio.roberto@gmail.com' }
  s.source           = { :git => 'https://github.com/sampaioroberto/PINTextFieldView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.3'

  s.source_files = 'PINTextFieldView/Classes/**/*'
  
  # s.resource_bundles = {
  #   'PINTextFieldView' => ['PINTextFieldView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
