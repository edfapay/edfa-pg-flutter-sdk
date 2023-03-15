/*
 * Property of Expresspay (https://expresspay.sa).
 */


/// The transaction type types.
/// @see com.expresspay.sdk.model.response.gettransactiondetails.ExpresspayTransaction
///
/// @property transactionType the transaction type value.
enum ExpresspayTransactionType{
    /// 3DS transaction type.
    SECURE_3D("3DS"),

    /// SALE transaction type.
    SALE("SALE"),

    /// AUTH transaction type.
    AUTH("AUTH"),

    /// CAPTURE transaction type.
    CAPTURE("CAPTURE"),

    /// REVERSAL transaction type.
    REVERSAL("REVERSAL"),

    /// REFUND transaction type.
    REFUND("REFUND"),

    /// REDIRECT transaction type.
    REDIRECT("REDIRECT"),

    /// CHARGEBACK transaction type.
    CHARGEBACK("CHARGEBACK");

    final String transactionType;
    const ExpresspayTransactionType(this.transactionType);

    factory ExpresspayTransactionType.of(String? id) {
        return values.firstWhere((e) => e.transactionType == id);
    }
}
