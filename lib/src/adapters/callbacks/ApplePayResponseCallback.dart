

class ApplePayResponseCallback{
  final Function(Map result) authentication;
  final Function(Map result) success;
  final Function(Map result) failure;
  final Function(Map result) error;

  ApplePayResponseCallback({
    required this.authentication,
    required this.success,
    required this.failure,
    required this.error
  });
}