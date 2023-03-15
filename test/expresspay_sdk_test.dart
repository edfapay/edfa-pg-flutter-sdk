import 'package:flutter_test/flutter_test.dart';
import 'package:expresspay_sdk/expresspay_sdk.dart';
import 'package:expresspay_sdk/expresspay_sdk_platform_interface.dart';
import 'package:expresspay_sdk/expresspay_sdk_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockExpresspaySdkPlatform
    with MockPlatformInterfaceMixin
    implements ExpresspaySdkPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<bool> config(String key, String password, bool enableDebug) {
    throw UnimplementedError();
  }
}

void main() {
  final ExpresspaySdkPlatform initialPlatform = ExpresspaySdkPlatform.instance;

  test('$MethodChannelExpresspaySdk is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelExpresspaySdk>());
  });

  test('getPlatformVersion', () async {
    ExpresspaySdk expresspaySdkPlugin = ExpresspaySdk();
    MockExpresspaySdkPlatform fakePlatform = MockExpresspaySdkPlatform();
    ExpresspaySdkPlatform.instance = fakePlatform;

    expect(await expresspaySdkPlugin.getPlatformVersion(), '42');
  });
}
