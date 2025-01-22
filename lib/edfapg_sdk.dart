library intl;

import 'package:edfapg_sdk/src/Helpers.dart';
import 'package:edfapg_sdk/src/adapters/EdfaPgAdapters.dart';

import 'edfapg_sdk_platform_interface.dart';

import 'dart:async';

export 'src/adapters/EdfaPgAdapters.dart';
export 'src/adapters/callbacks/SaleResponseCallback.dart';
export 'src/adapters/callbacks/RecurringSaleResponseCallback.dart';
export 'src/adapters/callbacks/CaptureResponseCallback.dart';
export 'src/adapters/callbacks/CreditVoidResponseCallback.dart';
export 'src/adapters/callbacks/TransactionStatusResponseCallback.dart';
export 'src/adapters/callbacks/TransactionDetailsResponseCallback.dart';

export 'src/request/EdfaPgCard.dart';
export 'src/request/EdfaPgTestCards.dart';
export 'src/request/EdfaPgOrder.dart';
export 'src/request/EdfaPgPayer.dart';
export 'src/request/EdfaPgPayerOption.dart';
export 'src/request/EdfaPgRecurringOptions.dart';
export 'src/request/EdfaPgSaleOptions.dart';
export 'src/request/EdfaPgSaleOrder.dart';


export 'src/response/base/result/IDetailsResult.dart';
export 'src/response/base/result/IResult.dart';
export 'src/response/base/result/IOrderResult.dart';


export 'src/response/base/error/Error.dart';
export 'src/response/base/error/ExactError.dart';


export 'src/response/capture/CaptureSuccess.dart';
export 'src/response/capture/CaptureDecline.dart';
export 'src/response/capture/CaptureResult.dart';


export 'src/response/creditvoid/CreditvoidSuccess.dart';
export 'src/response/creditvoid/CreditVoidResult.dart';


export 'src/response/gettransactiondetails/Transaction.dart';
export 'src/response/gettransactiondetails/TransactionDetailsSuccess.dart';
export 'src/response/gettransactiondetails/TransactionDetailResult.dart';

export 'src/response/gettransactionstatus/TransactionStatusSuccess.dart';
export 'src/response/gettransactionstatus/TransactionStatusResult.dart';


export 'src/response/sale/RedirectParams.dart';
export 'src/response/sale/Sale3DS.dart';
export 'src/response/sale/Sale3dsRedirectParams.dart';
export 'src/response/sale/SaleDecline.dart';
export 'src/response/sale/SaleRecurring.dart';
export 'src/response/sale/SaleRedirect.dart';
export 'src/response/sale/SaleSuccess.dart';
export 'src/response/sale/SaleResult.dart';

export 'src/cardpay/EdfaCardPay.dart';
export 'src/cardpay/EdfaPayWithCardDetails.dart';
export 'src/applepay/EdfaApplePay.dart';


export 'src/api/EdfaPgAction.dart';
export 'src/api/EdfaPgStatus.dart';
export 'src/api/EdfaPgResult.dart';

export 'src/enum/DesignType.dart';

class EdfaPgSdk {
  static final EdfaPgSdk _instance = EdfaPgSdk();
  static EdfaPgSdk get instance => _instance;

  Future<String?> getPlatformVersion() {
    return EdfaPgSdkPlatform.instance.getPlatformVersion();
  }

  Future<bool> config({required String key, required String password, bool enableDebug = false}){
    return EdfaPgSdkPlatform.instance.config(key, password, enableDebug);
  }


  EdfaPgAdapters ADAPTER = EdfaPgAdapters();
  Helpers HELPER = Helpers();
}
