/*
 * Property of  EdfaPg (https://edfapay.com).
 */


/// The transaction status types.
/// @see com.edfapg.flutter.sdk.model.response.gettransactiondetails. EdfaPgTransaction
///
/// @property transactionStatus the transaction status value.
enum EdfaPgTransactionStatus{
    /// Failed or "0" status.
    FAIL("fail"),

    /// Success or "1" status.
    SUCCESS("success");

    final String transactionStatus;
    const EdfaPgTransactionStatus(this.transactionStatus);


    factory EdfaPgTransactionStatus.of(String? id) {
        return values.firstWhere((e) => e.transactionStatus == id);
    }
}
