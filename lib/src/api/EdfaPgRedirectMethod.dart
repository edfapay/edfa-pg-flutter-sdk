/*
 * Property of  EdfaPg (https://edfapay.com).
 */

/// The method of transferring parameters (POST/GET).
/// @see com.edfapg.flutter.sdk.model.response.sale. EdfaPgSale3Ds
///
/// @property redirectMethod the redirect method value.
enum EdfaPgRedirectMethod{
    /// GET redirect method value.
    GET("GET"),

    /// POST redirect method value.
    POST("POST");

    final String redirectMethod;
    const EdfaPgRedirectMethod(this.redirectMethod);


    factory EdfaPgRedirectMethod.of(String? id) {
        return values.firstWhere((e) => e.redirectMethod == id);
    }
}
