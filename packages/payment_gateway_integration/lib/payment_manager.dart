import 'package:payment_gateway_integration/payment_options.dart';
import 'package:payment_gateway_integration/payment_service.dart';
import 'package:payment_gateway_integration/razorpay/razorpay_payment_service.dart';
import 'package:payment_gateway_integration/stripe_payment.dart/stripe_payment_service.dart';

enum PaymentProvider { razorpay, stripe }

class PaymentManager {
  final PaymentProvider provider;
  late final PaymentService _service;

  PaymentManager(this.provider) {
    switch (provider) {
      case PaymentProvider.razorpay:
        _service = RazorpayPaymentService();
        break;
      case PaymentProvider.stripe:
        _service = StripePaymentService();
        break;
    }
  }

  Future<void> initialize() => _service.initialize();

  Future<void> openCheckout(PaymentOptions options) =>
      _service.openCheckout(options);

  void dispose() => _service.dispose();
}
