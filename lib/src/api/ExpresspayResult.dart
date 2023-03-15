/*
 * Property of Expresspay (https://expresspay.sa).
 */


/// Result – value that system returns on request.
/// @see com.expresspay.sdk.model.response.base.result.IExpresspayResult
///
/// @property result the result value.
enum  ExpresspayResult{
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
    const ExpresspayResult(this.result);


    factory ExpresspayResult.of(String? id) {
        return values.firstWhere((e) => e.result == (id ?? "NONE"));
    }
}
