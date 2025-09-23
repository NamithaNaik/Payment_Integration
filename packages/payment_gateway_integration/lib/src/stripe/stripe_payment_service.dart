import 'dart:async';

import '../../src/core/payment_service.dart';
import '../../src/core/payment_result.dart';
import 'stripe_options.dart';

class StripePaymentService implements PaymentService<StripeOptions> {
  bool _initialized = false;

  final _successController = StreamController<PaymentResultSuccess>.broadcast();
  final _errorController = StreamController<PaymentResultError>.broadcast();

  Stream<PaymentResultSuccess> get onPaymentSuccess => _successController.stream;
  Stream<PaymentResultError> get onPaymentError => _errorController.stream;

  @override
  Future<void> initialize() async {
    if (_initialized) return;
    // TODO: Initialize flutter_stripe or your stripe SDK here (e.g. Stripe.publishableKey = ...)
    _initialized = true;
  }

  @override
  Future<void> openCheckout(StripeOptions options) async {
    if (!_initialized) await initialize();
    final data = options.toMap();
    // TODO: Implement stripe checkout flow using flutter_stripe (create payment intent on server, confirm payment)
    // For now we just simulate:
    _successController.add(PaymentResultSuccess(paymentId: 'stripe_fake_123', orderId: null));
  }

  @override
  void dispose() {
    _successController.close();
    _errorController.close();
  }
}
