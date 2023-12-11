import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'edfapg_sdk_method_channel.dart';

abstract class EdfaPgSdkPlatform extends PlatformInterface {
  /// Constructs a  EdfaPgSdkPlatform.
  EdfaPgSdkPlatform() : super(token: _token);

  static final Object _token = Object();

  static EdfaPgSdkPlatform _instance = MethodChannelEdfaPgSdk();

  /// The default instance of [EdfaPgSdkPlatform] to use.
  ///
  /// Defaults to [MethodChannelEdfaPgSdk].
  static EdfaPgSdkPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [EdfaPgSdkPlatform] when
  /// they register themselves.
  static set instance(EdfaPgSdkPlatform instance) {
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
