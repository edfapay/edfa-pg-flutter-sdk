
import 'package:flutter/services.dart';

const SALE_EVENT_CHANNEL = "com.edfapg.flutter.sdk.sale" ;
const RECURRING_SALE_EVENT_CHANNEL = "com.edfapg.flutter.sdk.recurringsale";
const CAPTURE_EVENT_CHANNEL = "com.edfapg.flutter.sdk.capture" ;
const CREDIT_VOID_EVENT_CHANNEL = "com.edfapg.flutter.sdk.creditvoid" ;
const TRANSACTION_STATUS_EVENT_CHANNEL = "com.edfapg.flutter.sdk.transactionstatus";
const TRANSACTION_DETAILS_EVENT_CHANNEL = "com.edfapg.flutter.sdk.transactiondetail";
const TRANSACTION_LOGS_EVENT_CHANNEL = "com.edfapg.flutter.sdk.transactionlogs";

const CARD_PAY_EVENT_CHANNEL = "com.edfapg.flutter.sdk.cardpay";
const CARD_DETAIL_PAY_EVENT_CHANNEL = "com.edfapg.flutter.sdk.cardDetailPay";
const APPLE_PAY_EVENT_CHANNEL = "com.edfapg.flutter.sdk.applepay";

abstract class EdfaPgPlatformChannels{

  final sale = const EventChannel(SALE_EVENT_CHANNEL);
  final recurringSale = const EventChannel(RECURRING_SALE_EVENT_CHANNEL);
  final capture = const EventChannel(CAPTURE_EVENT_CHANNEL);
  final creditVoid = const EventChannel(CREDIT_VOID_EVENT_CHANNEL);
  final transactionsStatus = const EventChannel(TRANSACTION_STATUS_EVENT_CHANNEL);
  final transactionsDetail = const EventChannel(TRANSACTION_DETAILS_EVENT_CHANNEL);
  final transactionsLogs = const EventChannel(TRANSACTION_LOGS_EVENT_CHANNEL);

  final cardPay = const EventChannel(CARD_PAY_EVENT_CHANNEL);
  final cardDetailPay = const EventChannel(CARD_DETAIL_PAY_EVENT_CHANNEL);
  final applePay = const EventChannel(APPLE_PAY_EVENT_CHANNEL);

}