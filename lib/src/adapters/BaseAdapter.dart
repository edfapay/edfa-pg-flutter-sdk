import 'package:edfapg_sdk/src/event_channels.dart';


typedef StreamReturnType = Stream<Map>;

abstract class BaseAdapter extends EdfaPgPlatformChannels{
  StreamReturnType startSale(Map<String,dynamic> params) => sale.receiveBroadcastStream(params).map((event) => event as Map);
  StreamReturnType startRecurringSale(Map<String,dynamic> params) => recurringSale.receiveBroadcastStream(params).map((event) => event as Map);
  StreamReturnType startCapture(Map<String,dynamic> params) => capture.receiveBroadcastStream(params).map((event) => event as Map);
  StreamReturnType startCreditVoid(Map<String,dynamic> params) => creditVoid.receiveBroadcastStream(params).map((event) => event as Map);
  StreamReturnType startTransactionsStatus(Map<String,dynamic> params) => transactionsStatus.receiveBroadcastStream(params).map((event) => event as Map);
  StreamReturnType startTransactionsDetail(Map<String,dynamic> params) => transactionsDetail.receiveBroadcastStream(params).map((event) => event as Map);

  StreamReturnType startCardPay(Map<String,dynamic> params) => cardPay.receiveBroadcastStream(params).map((event) => event as Map);
  StreamReturnType startPayWithCardDetail(Map<String,dynamic> params) => cardDetailPay.receiveBroadcastStream(params).map((event) => event as Map);
  StreamReturnType startApplePay(Map<String,dynamic> params) => applePay.receiveBroadcastStream(params).map((event) => event as Map);
}