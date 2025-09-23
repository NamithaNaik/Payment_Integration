import 'package:payment_gateway_integration/payment_service.dart';
import 'package:payment_gateway_integration/razorpay/razor_options.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';


class RazorpayPaymentService implements PaymentService<RazorpayOptions> {
  late Razorpay _razorpay;

  @override
  Future<void> initialize() async {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  Future<void> openCheckout(RazorpayOptions options) async {
    _razorpay.open(options.toMap());
  }

  @override
  void dispose() {
    _razorpay.clear();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Success callback
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Error callback
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Wallet callback
  }
}
