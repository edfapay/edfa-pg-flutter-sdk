import 'package:collection/collection.dart';
/*
 * Property of  EdfaPg (https://edfapay.com).
 */


/// Status – actual status of transaction in Payment Platform.
/// @see com.edfapg.flutter.sdk.model.response.base.result.I EdfaPgResult
///
/// @property status the status value.
enum EdfaPgStatus{
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
    const EdfaPgStatus(this.status);


    factory EdfaPgStatus.of(String? id) {
        return values.firstWhereOrNull((e) => e.status == id) ?? NONE;
    }
}
