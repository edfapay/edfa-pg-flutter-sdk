/*
 * Property of  EdfaPg (https://edfapay.com).
 */


import 'package:edfapg_sdk/src/request/EdfaPgCard.dart';

/// The test environment cards.
/// @see  EdfaPgCard
String _TEST_CARD_NUMBER = "4111111111111111";
int _TEST_CARD_EXPIRE_YEAR = 2025;
String _TEST_CARD_CVV = "411";

class EdfaPgTestCards {

 /// This card number and card expiration date must be used for testing successful sale.
 ///
 /// Response on successful SALE request: "action": "SALE", "result": "SUCCESS", "status": "SETTLED".
 /// Response on successful AUTH request: "action": "SALE", "result": "SUCCESS", "status": "PENDING".
 EdfaPgCard SALE_SUCCESS = EdfaPgCard.test("SALE_SUCCESS", number: _TEST_CARD_NUMBER, expireMonth: 1, expireYear: _TEST_CARD_EXPIRE_YEAR, cvv: _TEST_CARD_CVV);

 /// This card number and card expiration date must be used for testing unsuccessful sale.
 ///
 /// Response on unsuccessful SALE request: "action": "SALE", "result": "DECLINED", "status": "DECLINED".
 /// Response on unsuccessful AUTH request: "action": "SALE", "result": "DECLINED", "status": "DECLINED".
 EdfaPgCard SALE_FAILURE = EdfaPgCard.test("SALE_FAILURE", number: _TEST_CARD_NUMBER, expireMonth: 2, expireYear: _TEST_CARD_EXPIRE_YEAR, cvv: _TEST_CARD_CVV);

 /// This card number and card expiration date must be used for testing unsuccessful CAPTURE after successful AUTH.
 ///
 /// Response on successful AUTH request: "action": "SALE", "result": "SUCCESS", "status": "PENDING".
 /// Response on unsuccessful CAPTURE request: "action": "CAPTURE", "result": "DECLINED", "status": "PENDING".
 EdfaPgCard CAPTURE_FAILURE = EdfaPgCard.test("SECURE_3D_SUCCESS", number: _TEST_CARD_NUMBER, expireMonth: 3, expireYear: _TEST_CARD_EXPIRE_YEAR, cvv: _TEST_CARD_CVV);

 /// This card number and card expiration date must be used for testing  successful sale after 3DS verification.
 ///
 /// Response on VERIFY request: "action": "SALE", "result": "REDIRECT", "status": "3DS".
 /// After return from ACS: "action": "SALE", "result": "SUCCESS", "status": "SETTLED".
 EdfaPgCard SECURE_3D_SUCCESS = EdfaPgCard.test("SECURE_3D_SUCCESS", number: _TEST_CARD_NUMBER, expireMonth: 5, expireYear: _TEST_CARD_EXPIRE_YEAR, cvv: _TEST_CARD_CVV);

 /// This card number and card expiration date must be used for testing unsuccessful sale after 3DS verification.
 ///
 /// Response on VERIFY request: "action": "SALE", "result": "REDIRECT", "status": "3DS".
 /// After return from ACS: "action": "SALE", "result": "DECLINED", "status": "DECLINED".
 EdfaPgCard SECURE_3D_FAILURE = EdfaPgCard.test("SECURE_3D_FAILURE", number: _TEST_CARD_NUMBER, expireMonth: 6, expireYear: _TEST_CARD_EXPIRE_YEAR, cvv: _TEST_CARD_CVV);

 List<EdfaPgCard> all(){
  return [
   SALE_SUCCESS,
   SALE_FAILURE,
   CAPTURE_FAILURE,
   SECURE_3D_SUCCESS,
   SECURE_3D_FAILURE,
  ];
 }
}
