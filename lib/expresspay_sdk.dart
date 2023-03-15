library intl;

import 'package:expresspay_sdk/src/Helpers.dart';
import 'package:expresspay_sdk/src/adapters/ExpressPayAdapters.dart';

import 'expresspay_sdk_platform_interface.dart';

import 'dart:async';

export 'src/adapters/ExpressPayAdapters.dart';
export 'src/adapters/callbacks/SaleResponseCallback.dart';

export 'src/request/ExpresspayCard.dart';
export 'src/request/ExpresspayTestCards.dart';
export 'src/request/ExpresspayOrder.dart';
export 'src/request/ExpresspayPayer.dart';
export 'src/request/ExpresspayPayerOption.dart';
export 'src/request/ExpresspayRecurringOptions.dart';
export 'src/request/ExpresspaySaleOptions.dart';
export 'src/request/ExpresspaySaleOrder.dart';


export 'src/response/base/result/IDetailsExpresspayResult.dart';
export 'src/response/base/result/IExpresspayResult.dart';
export 'src/response/base/result/IOrderExpresspayResult.dart';


export 'src/response/base/error/ExpresspayError.dart';
export 'src/response/base/error/ExpresspayExactError.dart';


export 'src/response/capture/ExpresspayCaptureSuccess.dart';
export 'src/response/capture/ExpresspayCaptureDecline.dart';
export 'src/response/capture/ExpresspayCaptureResult.dart';


export 'src/response/creditvoid/ExpresspayCreditvoidSuccess.dart';
export 'src/response/creditvoid/ExpresspayCreditVoidResult.dart';


export 'src/response/gettransactiondetails/ExpresspayTransaction.dart';
export 'src/response/gettransactiondetails/ExpresspayTransactionDetailsSuccess.dart';
export 'src/response/gettransactiondetails/ExpresspayTransactionDetailResult.dart';


export 'src/response/sale/ExpresspayRedirectParams.dart';
export 'src/response/sale/ExpresspaySale3DS.dart';
export 'src/response/sale/ExpresspaySale3dsRedirectParams.dart';
export 'src/response/sale/ExpresspaySaleDecline.dart';
export 'src/response/sale/ExpresspaySaleRecurring.dart';
export 'src/response/sale/ExpresspaySaleRedirect.dart';
export 'src/response/sale/ExpresspaySaleSuccess.dart';
export 'src/response/sale/ExpresspaySaleResult.dart';

export 'src/cardpay/ExpressCardPay.dart';
export 'src/applepay/ExpressApplePay.dart';




class ExpresspaySdk {
  static final ExpresspaySdk _instance = ExpresspaySdk();
  static ExpresspaySdk get instance => _instance;

  Future<String?> getPlatformVersion() {
    return ExpresspaySdkPlatform.instance.getPlatformVersion();
  }

  Future<bool> config({required String key, required String password, bool enableDebug = false}){
    return ExpresspaySdkPlatform.instance.config(key, password, enableDebug);
  }


  ExpressPayAdapters ADAPTER = ExpressPayAdapters();
  Helpers HELPER = Helpers();
}
