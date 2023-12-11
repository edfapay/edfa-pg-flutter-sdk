import 'package:collection/collection.dart';

/*
 * Property of  EdfaPg (https://edfapay.com).
 */


/// Result – value that system returns on request.
/// @see com.edfapg.flutter.sdk.model.response.base.result.I EdfaPgResult
///
/// @property result the result value.
enum  EdfaPgResult{
    /// Action was successfully completed  in Payment Platform.
    SUCCESS("SUCCESS"),

    /// Result of unsuccessful action in Payment Platform.
    DECLINED("DECLINED"),

    /// Additional action required from requester (Redirect to 3ds).
    REDIRECT("REDIRECT"),

    /// Action was accepted by Payment Platform, but will be completed later.
    ACCEPTED("ACCEPTED"),

    /// Request has errors and was not validated by Payment Platform.
    ERROR("ERROR"),

    NONE("NONE");

    final String result;
    const EdfaPgResult(this.result);


    factory EdfaPgResult.of(String? id) {
        return values.firstWhereOrNull((e) => e.result == id) ?? NONE;
    }
}
