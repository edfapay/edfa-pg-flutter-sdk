import 'package:flutter_test/flutter_test.dart';
import 'package:edfapg_sdk/edfapg_sdk.dart';
import 'package:edfapg_sdk/edfapg_sdk_platform_interface.dart';
import 'package:edfapg_sdk/edfapg_sdk_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockEdfaPgSdkPlatform
    with MockPlatformInterfaceMixin
    implements EdfaPgSdkPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<bool> config(String key, String password, bool enableDebug) {
    throw UnimplementedError();
  }
}

void main() {
  final EdfaPgSdkPlatform initialPlatform = EdfaPgSdkPlatform.instance;

  test('$MethodChannelEdfaPgSdk is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelEdfaPgSdk>());
  });

  test('getPlatformVersion', () async {
    EdfaPgSdk expresspaySdkPlugin = EdfaPgSdk();
    MockEdfaPgSdkPlatform fakePlatform = MockEdfaPgSdkPlatform();
    EdfaPgSdkPlatform.instance = fakePlatform;

    expect(await expresspaySdkPlugin.getPlatformVersion(), '42');
  });
}
