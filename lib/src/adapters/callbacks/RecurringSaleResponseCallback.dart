
import 'package:edfapg_sdk/edfapg_sdk.dart';

class RecurringSaleResponseCallback extends SaleResponseCallback{

  RecurringSaleResponseCallback({
    required super.success,
    required super.decline,
    required super.recurring,
    required super.redirect,
    required super.secure3d,
    required super.error
  });
}