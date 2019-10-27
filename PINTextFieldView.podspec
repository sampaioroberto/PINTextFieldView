Pod::Spec.new do |s|
  s.name             = 'PINTextFieldView'
  s.version          = '0.1.0'
  s.summary          = 'Its a insert pincode View.'

  s.description      = <<-DESC
  PINTextFieldView is a library used for accepting pincodes.
                       DESC

  s.homepage         = 'https://github.com/sampaioroberto/PINTextFieldView'

  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Roberto Sampaio' => 'ssampaio.roberto@gmail.com' }
  s.source           = { :git => 'https://github.com/sampaioroberto/PINTextFieldView.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.3'

  s.source_files = 'PINTextFieldView/Classes/**/*'
end
