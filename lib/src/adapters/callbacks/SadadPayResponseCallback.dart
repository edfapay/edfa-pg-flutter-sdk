
import 'package:edfapg_sdk/edfapg_sdk.dart';
import 'package:edfapg_sdk/src/adapters/callbacks/BaseResponseCallback.dart';
import 'package:edfapg_sdk/src/response/sadad/EdfaPgSadadSuccess.dart';

class SadadPayResponseCallback{
  final Function(EdfaPgSadadSuccess result) success;
  final Function(EdfaPgError? errors, Exception? exception) failure;
  final Function(List<String> errors) error;


  SadadPayResponseCallback({
    required this.success,
    required this.failure,
    required this.error
  });
}