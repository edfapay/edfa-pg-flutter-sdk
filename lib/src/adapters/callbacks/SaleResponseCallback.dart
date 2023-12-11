
import 'package:edfapg_sdk/edfapg_sdk.dart';
import 'package:edfapg_sdk/src/adapters/callbacks/BaseResponseCallback.dart';

class SaleResponseCallback extends BaseResponseCallback{
  final Function(EdfaPgSaleSuccess result) success;
  final Function(EdfaPgSaleDecline result) decline;
  final Function(EdfaPgSaleRecurring result) recurring;
  final Function(EdfaPgSaleRedirect result) redirect;
  final Function(EdfaPgSale3DS result) secure3d;

  SaleResponseCallback({
    required this.success,
    required this.decline,
    required this.recurring,
    required this.redirect,
    required this.secure3d,
    required super.error
  });
}