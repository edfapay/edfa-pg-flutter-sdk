/*
 * Property of Expresspay (https://expresspay.sa).
 */


import 'package:expresspay_sdk/expresspay_sdk.dart';

/// The test environment cards.
/// @see ExpresspayCard
String _TEST_CARD_NUMBER = "4111111111111111";
int _TEST_CARD_EXPIRE_YEAR = 2025;
String _TEST_CARD_CVV = "411";

class ExpresspayTestCards {

 /// This card number and card expiration date must be used for testing successful sale.
 ///
 /// Response on successful SALE request: "action": "SALE", "result": "SUCCESS", "status": "SETTLED".
 /// Response on successful AUTH request: "action": "SALE", "result": "SUCCESS", "status": "PENDING".
 ExpresspayCard SALE_SUCCESS = ExpresspayCard.test("SALE_SUCCESS", number: _TEST_CARD_NUMBER, expireMonth: 1, expireYear: _TEST_CARD_EXPIRE_YEAR, cvv: _TEST_CARD_CVV);

 /// This card number and card expiration date must be used for testing unsuccessful sale.
 ///
 /// Response on unsuccessful SALE request: "action": "SALE", "result": "DECLINED", "status": "DECLINED".
 /// Response on unsuccessful AUTH request: "action": "SALE", "result": "DECLINED", "status": "DECLINED".
 ExpresspayCard SALE_FAILURE = ExpresspayCard.test("SALE_FAILURE", number: _TEST_CARD_NUMBER, expireMonth: 2, expireYear: _TEST_CARD_EXPIRE_YEAR, cvv: _TEST_CARD_CVV);

 /// This card number and card expiration date must be used for testing unsuccessful CAPTURE after successful AUTH.
 ///
 /// Response on successful AUTH request: "action": "SALE", "result": "SUCCESS", "status": "PENDING".
 /// Response on unsuccessful CAPTURE request: "action": "CAPTURE", "result": "DECLINED", "status": "PENDING".
 ExpresspayCard CAPTURE_FAILURE = ExpresspayCard.test("SECURE_3D_SUCCESS", number: _TEST_CARD_NUMBER, expireMonth: 3, expireYear: _TEST_CARD_EXPIRE_YEAR, cvv: _TEST_CARD_CVV);

 /// This card number and card expiration date must be used for testing  successful sale after 3DS verification.
 ///
 /// Response on VERIFY request: "action": "SALE", "result": "REDIRECT", "status": "3DS".
 /// After return from ACS: "action": "SALE", "result": "SUCCESS", "status": "SETTLED".
 ExpresspayCard SECURE_3D_SUCCESS = ExpresspayCard.test("SECURE_3D_SUCCESS", number: _TEST_CARD_NUMBER, expireMonth: 5, expireYear: _TEST_CARD_EXPIRE_YEAR, cvv: _TEST_CARD_CVV);

 /// This card number and card expiration date must be used for testing unsuccessful sale after 3DS verification.
 ///
 /// Response on VERIFY request: "action": "SALE", "result": "REDIRECT", "status": "3DS".
 /// After return from ACS: "action": "SALE", "result": "DECLINED", "status": "DECLINED".
 ExpresspayCard SECURE_3D_FAILURE = ExpresspayCard.test("SECURE_3D_FAILURE", number: _TEST_CARD_NUMBER, expireMonth: 6, expireYear: _TEST_CARD_EXPIRE_YEAR, cvv: _TEST_CARD_CVV);

 List<ExpresspayCard> all(){
  return [
   SALE_SUCCESS,
   SALE_FAILURE,
   CAPTURE_FAILURE,
   SECURE_3D_SUCCESS,
   SECURE_3D_FAILURE,
  ];
 }
}
