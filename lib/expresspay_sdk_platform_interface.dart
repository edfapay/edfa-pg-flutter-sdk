import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'expresspay_sdk_method_channel.dart';

abstract class ExpresspaySdkPlatform extends PlatformInterface {
  /// Constructs a ExpresspaySdkPlatform.
  ExpresspaySdkPlatform() : super(token: _token);

  static final Object _token = Object();

  static ExpresspaySdkPlatform _instance = MethodChannelExpresspaySdk();

  /// The default instance of [ExpresspaySdkPlatform] to use.
  ///
  /// Defaults to [MethodChannelExpresspaySdk].
  static ExpresspaySdkPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ExpresspaySdkPlatform] when
  /// they register themselves.
  static set instance(ExpresspaySdkPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }


  Future<bool> config(String key,String password, bool enableDebug) {
    throw UnimplementedError('config() has not been implemented.');
  }
}
