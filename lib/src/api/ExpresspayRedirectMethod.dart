/*
 * Property of Expresspay (https://expresspay.sa).
 */

/// The method of transferring parameters (POST/GET).
/// @see com.expresspay.sdk.model.response.sale.ExpresspaySale3Ds
///
/// @property redirectMethod the redirect method value.
enum ExpresspayRedirectMethod{
    /// GET redirect method value.
    GET("GET"),

    /// POST redirect method value.
    POST("POST");

    final String redirectMethod;
    const ExpresspayRedirectMethod(this.redirectMethod);


    factory ExpresspayRedirectMethod.of(String? id) {
        return values.firstWhere((e) => e.redirectMethod == id);
    }
}
