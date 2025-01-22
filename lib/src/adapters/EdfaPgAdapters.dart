import 'package:edfapg_sdk/src/adapters/EdfaApplePayAdapter.dart';
import 'package:edfapg_sdk/src/adapters/EdfaCardPayAdapter.dart';
import 'package:edfapg_sdk/src/adapters/EdfaPgGetTransactionDetailsAdapter.dart';
import 'package:edfapg_sdk/src/adapters/EdfaPgGetTransactionStatusAdapter.dart';

import 'EdfaCardDetailPayAdapter.dart';
import 'EdfaPgCaptureAdapter.dart';
import 'EdfaPgCreditVoidAdapter.dart';
import 'EdfaPgRecurringSaleAdapter.dart';
import 'EdfaPgSaleAdapter.dart';

class EdfaPgAdapters{
  final CARD_PAY = EdfaCardPayAdapter();
  final CARD_DETAIL_PAY = EdfaCardDetailPayAdapter();
  final APPLE_PAY = EdfaApplePayAdapter();

  final SALE = EdfaPgSaleAdapter();
  final RECURRING_SALE = EdfaPgRecurringSaleAdapter();
  final CAPTURE = EdfaPgCaptureAdapter();
  final CREDIT_VOID = EdfaPgCreditVoidAdapter();
  final TRANSACTION_STATUS = EdfaPgGetTransactionStatusAdapter();
  final TRANSACTION_DETAILS = EdfaPgGetTransactionDetailsAdapter();

}