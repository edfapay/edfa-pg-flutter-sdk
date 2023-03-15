/*
 * Property of Expresspay (https://expresspay.sa).
 */


/// The transaction status types.
/// @see com.expresspay.sdk.model.response.gettransactiondetails.ExpresspayTransaction
///
/// @property transactionStatus the transaction status value.
enum ExpresspayTransactionStatus{
    /// Failed or "0" status.
    FAIL("fail"),

    /// Success or "1" status.
    SUCCESS("success");

    final String transactionStatus;
    const ExpresspayTransactionStatus(this.transactionStatus);


    factory ExpresspayTransactionStatus.of(String? id) {
        return values.firstWhere((e) => e.transactionStatus == id);
    }
}
