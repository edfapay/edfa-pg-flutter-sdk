/*
 * Property of Expresspay (https://expresspay.sa).
 */


/// "Y" or "N" value holder.
///
/// @property option the option value.
enum ExpresspayOption{
    /// "Y" value.
    YES("Y"),

    /// "N" value.
    NO("N");

    final String option;
    const ExpresspayOption(this.option);


    factory ExpresspayOption.of(String? id) {
        return values.firstWhere((e) => e.option == id);
    }
}
