/*
 * Property of  EdfaPg (https://edfapay.com).
 */


/// "Y" or "N" value holder.
///
/// @property option the option value.
enum EdfaPgOption{
    /// "Y" value.
    YES("Y"),

    /// "N" value.
    NO("N");

    final String option;
    const EdfaPgOption(this.option);


    factory EdfaPgOption.of(String? id) {
        return values.firstWhere((e) => e.option == id);
    }
}
