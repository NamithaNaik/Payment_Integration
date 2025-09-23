
import 'package:payment_gateway_integration/payment_service.dart';
import 'package:payment_gateway_integration/stripe_payment.dart/strip_options.dart';

class StripePaymentService implements PaymentService<StripeOptions> {
  @override
  Future<void> initialize() async {
    // TODO: Initialize Stripe SDK here
  }

  @override
  Future<void> openCheckout(StripeOptions options) async {
    // TODO: Call Stripe SDK checkout
    final data = options.toMap();
    print("Opening Stripe Checkout with: $data");
  }

  @override
  void dispose() {
    // TODO: Cleanup if needed
  }
}
