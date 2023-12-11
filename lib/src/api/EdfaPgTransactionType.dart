/*
 * Property of  EdfaPg (https://edfapay.com).
 */


/// The transaction type types.
/// @see com.edfapg.flutter.sdk.model.response.gettransactiondetails. EdfaPgTransaction
///
/// @property transactionType the transaction type value.
enum EdfaPgTransactionType{
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
    const EdfaPgTransactionType(this.transactionType);

    factory EdfaPgTransactionType.of(String? id) {
        return values.firstWhere((e) => e.transactionType == id);
    }
}
