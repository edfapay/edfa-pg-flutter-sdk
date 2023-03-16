import 'package:expresspay_sdk/src/adapters/ExpressApplePayAdapter.dart';
import 'package:expresspay_sdk/src/adapters/ExpressCardPayAdapter.dart';
import 'package:expresspay_sdk/src/adapters/ExpressPayGetTransactionDetailsAdapter.dart';
import 'package:expresspay_sdk/src/adapters/ExpressPayGetTransactionStatusAdapter.dart';

import 'ExpressPayCaptureAdapter.dart';
import 'ExpressPayCreditVoidAdapter.dart';
import 'ExpressPayRecurringSaleAdapter.dart';
import 'ExpressPaySaleAdapter.dart';

class ExpressPayAdapters{
  final CARD_PAY = ExpressCardPayAdapter();
  final APPLE_PAY = ExpressApplePayAdapter();

  final SALE = ExpressPaySaleAdapter();
  final RECURRING_SALE = ExpressPayRecurringSaleAdapter();
  final CAPTURE = ExpressPayCaptureAdapter();
  final CREDIT_VOID = ExpressPayCreditVoidAdapter();
  final TRANSACTION_STATUS = ExpressPayGetTransactionStatusAdapter();
  final TRANSACTION_DETAILS = ExpressPayGetTransactionDetailsAdapter();

}