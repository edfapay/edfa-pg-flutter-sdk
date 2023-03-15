
import 'package:expresspay_sdk/expresspay_sdk.dart';
import 'package:expresspay_sdk/src/adapters/callbacks/BaseResponseCallback.dart';

class SaleResponseCallback extends BaseResponseCallback{
  final Function(ExpresspaySaleSuccess result) success;
  final Function(ExpresspaySaleDecline result) decline;
  final Function(ExpresspaySaleRecurring result) recurring;
  final Function(ExpresspaySaleRedirect result) redirect;
  final Function(ExpresspaySale3DS result) secure3d;

  SaleResponseCallback({
    required this.success,
    required this.decline,
    required this.recurring,
    required this.redirect,
    required this.secure3d,
    required super.error
  });
}