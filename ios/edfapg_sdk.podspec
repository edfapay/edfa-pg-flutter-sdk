#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint expresspay_sdk.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'edfapg_sdk'
  s.version          = '2.0.0'
  s.summary          = 'A Flutter plugin for EdfaPaymentSDK.'
  s.description      = <<-DESC
EdfaPgSdk Flutter plugin was developed and designed with one purpose: to help the iOS/Android developers easily integrate the ExpressPay API Payment Platform for a specific merchant.
                       DESC
  s.homepage         = 'https://edfapay.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'EdfaPay' => 'admin@edfapay.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'EdfaPgSdk', '~> 2.0.7'
#   s.dependency 'EdfaPgSdk', :git => 'https://github.com/edfapay/edfa-pg-ios-sdk-pod.git', :branch => 'production'
  s.platform = :ios, '12.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'

end
