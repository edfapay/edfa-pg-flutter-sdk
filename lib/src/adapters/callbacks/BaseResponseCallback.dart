
import 'package:edfapg_sdk/edfapg_sdk.dart';

class BaseResponseCallback{
  final Function(EdfaPgError result) error;

  BaseResponseCallback({
    required this.error
  });
}