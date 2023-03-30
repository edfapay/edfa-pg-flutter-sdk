import 'package:collection/collection.dart';
/*
 * Property of Expresspay (https://expresspay.sa).
 */


/// Status – actual status of transaction in Payment Platform.
/// @see com.expresspay.sdk.model.response.base.result.IExpresspayResult
///
/// @property status the status value.
enum ExpresspayStatus{
    /// The transaction awaits 3D-Secure validation.
    SECURE_3D("3DS"),

    /// The transaction is redirected.
    REDIRECT("REDIRECT"),

    /// The transaction awaits CAPTURE.
    PENDING("PENDING"),

    /// Successful transaction.
    SETTLED("SETTLED"),

    /// Transaction for which reversal was made.
    REVERSAL("REVERSAL"),

    /// Transaction for which refund was made.
    REFUND("REFUND"),

    /// Transaction for which chargeback was made.
    CHARGEBACK("CHARGEBACK"),

    /// Not successful transaction.
    DECLINED("DECLINED"),

    NONE("NONE");

    final String status;
    const ExpresspayStatus(this.status);


    factory ExpresspayStatus.of(String? id) {
        return values.firstWhereOrNull((e) => e.status == id) ?? NONE;
    }
}
