import 'package:expresspay_sdk/src/adapters/ExpressApplePayAdapter.dart';
import 'package:expresspay_sdk/src/adapters/ExpressCardPayAdapter.dart';
import 'package:expresspay_sdk/src/adapters/ExpresspayCaptureAdapter.dart';
import 'package:expresspay_sdk/src/adapters/ExpresspayCreditVoidAdapter.dart';
import 'package:expresspay_sdk/src/adapters/ExpresspayRecurringSaleAdapter.dart';
import 'package:expresspay_sdk/src/adapters/ExpresspaySaleAdapter.dart';
import 'package:expresspay_sdk/src/adapters/ExpresspayTransactionDetailAdapter.dart';
import 'package:expresspay_sdk/src/adapters/ExpresspayTransactionStatusAdapter.dart';

class ExpressPayAdapters{
  final CARD_PAY = ExpressCardPayAdapter();
  final APPLE_PAY = ExpressApplePayAdapter();

  final SALE = ExpresspaySaleAdapter();
  final RECURRING_SALE = ExpresspayRecurringSaleAdapter();
  final CAPTURE = ExpresspayCaptureAdapter();
  final CREDIT_VOID = ExpresspayCreditVoidAdapter();
  final TRANSACTION_STATUS = ExpresspayTransactionStatusAdapter();
  final TRANSACTION_DETAILS = ExpresspayTransactionDetailAdapter();

}