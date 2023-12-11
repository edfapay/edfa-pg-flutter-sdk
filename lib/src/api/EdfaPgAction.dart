import 'package:collection/collection.dart';
/*
 * Property of  EdfaPg (https://edfapay.com).
 */

/// When you make request to Payment Platform, you need to specify action, that needs to be done.
/// Basically, every action is represented by its Adapter.
/// @see com.edfapg.flutter.sdk.core. EdfaPgSdk
/// @see com.edfapg.flutter.sdk.feature.adapter
/// @see com.edfapg.flutter.sdk.model.response.base.result.I EdfaPgResult
///
/// @property action the action value.
enum EdfaPgAction{
    /// Creates SALE or AUTH transaction.
    SALE("SALE"),

    /// Creates CAPTURE transaction.
    CAPTURE("CAPTURE"),

    /// Creates REVERSAL or REFUND transaction.
    CREDITVOID("CREDITVOID"),

    /// Gets status of transaction in Payment Platform.
    GET_TRANS_STATUS("GET_TRANS_STATUS"),

    /// Gets details of the order from Payment platform.
    GET_TRANS_DETAILS("GET_TRANS_DETAILS"),

    /// Creates SALE or AUTH transaction using previously used cardholder data.
    RECURRING_SALE("RECURRING_SALE"),

    /// Following actions can not be made by request, they are created by Payment Platform in certain circumstances
    /// (e.g. issuer initiated chargeback) and you receive callback as a result.
    CHARGEBACK("CHARGEBACK"),

    NONE("NONE");

    final String action;
    const EdfaPgAction(this.action);


    factory EdfaPgAction.of(String? id) {
        return values.firstWhereOrNull((e) => e.action == id) ?? NONE;
    }
}
