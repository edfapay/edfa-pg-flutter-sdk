import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'expresspay_sdk_platform_interface.dart';

/// An implementation of [ExpresspaySdkPlatform] that uses method channels.
class MethodChannelExpresspaySdk extends ExpresspaySdkPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('com.expresspay.sdk');


  final methodGetPlatformVersion = "getPlatformVersion";
  final methodConfig = "config";

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>(methodGetPlatformVersion);
    return version;
  }

  @override
  Future<bool> config(String key,String password, bool enableDebug) async {
    final result = await methodChannel.invokeMethod<bool>(methodConfig,[key, password, enableDebug]);
    return result ?? false;
  }
}
