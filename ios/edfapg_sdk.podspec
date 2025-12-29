#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint expresspay_sdk.podspec` to validate before publishing.
#
if File.exist?(File.join(__dir__, 'edfapay_properties.rb'))
    require_relative 'edfapay_properties'
else
    EDFAPG_SDK_VERSION = '~> 2.1.3'
end

Pod::Spec.new do |s|
  s.name             = 'edfapg_sdk'
  s.version          = '2.0.0'
  s.summary          = 'A Flutter plugin for EdfaPaymentSDK.'
  s.description      = <<-DESC
EdfaPgSdk Flutter plugin was developed and designed with one purpose: to help the iOS/Android developers easily integrate the ExpressPay API Payment Platform for a specific merchant.
                       DESC
  s.homepage         = 'https://edfapay.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'EdfaPay' => 'info@edfapay.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'EdfaPgSdk', EDFAPG_SDK_VERSION
#   s.dependency 'EdfaPgSdk', '~> 2.1.2'
  s.platform = :ios, '12.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'

end
