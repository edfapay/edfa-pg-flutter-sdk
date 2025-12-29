import 'dart:io';
import 'dart:isolate';
import 'package:yaml/yaml.dart';

void main() async{
  // Locate plugin root
  final pluginUri = await Isolate.resolvePackageUri(
    Uri.parse('package:edfapg_sdk/edfapg_sdk.dart'),
  );

  if (pluginUri == null) {
    throw Exception('Could not resolve edfapg_sdk package root');
  }

  final pluginRoot = Directory(pluginUri.toFilePath())
      .parent  // lib
      .parent
      .path; // plugin root

  final pubspec = loadYaml(
    File('pubspec.yaml').readAsStringSync(),
  );

  final native = pubspec['edfapay_properties'];
  if (native == null) {
    throw Exception('edfapay_properties not found in pubspec.yaml');
  }

  // ANDROID
  final androidVersion = native['pg_android'];
  File('${pluginRoot}/android/edfapay_properties.properties')
      .writeAsStringSync('''
EDFAPG_SDK_VERSION=$androidVersion
''');

  // IOS
  final iosVersion = native['pg_ios'];
  File('${pluginRoot}/ios/edfapay_properties.rb')
      .writeAsStringSync('''
EDFAPG_SDK_VERSION = '$iosVersion'
''');

  print('✅ Edfapay Payment Gateway Configured Successfully');
}
