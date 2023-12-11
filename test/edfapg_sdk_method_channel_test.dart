import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:edfapg_sdk/edfapg_sdk_method_channel.dart';

void main() {
  MethodChannelEdfaPgSdk platform = MethodChannelEdfaPgSdk();
  const MethodChannel channel = MethodChannel('com.edfapg.flutter.sdk');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
