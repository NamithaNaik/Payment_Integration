import 'dart:async';

import 'package:flutter_stripe/flutter_stripe.dart';

import '../../src/core/payment_service.dart';
import '../../src/core/payment_result.dart';
import 'stripe_options.dart';

class StripePaymentService implements PaymentService<StripeOptions> {
  bool _initialized = false;

  final _successController = StreamController<PaymentResultSuccess>.broadcast();
  final _errorController = StreamController<PaymentResultError>.broadcast();

  Stream<PaymentResultSuccess> get onPaymentSuccess =>
      _successController.stream;
  Stream<PaymentResultError> get onPaymentError => _errorController.stream;

  @override
  Future<void> initialize() async {
    if (_initialized) return;

    // Set your Stripe publishable key (test key for now)
    Stripe.publishableKey =
        'pk_test_XXXXXXXXXXXXXXXXXXXX'; // replace with your test key

    // Optional: set default merchant country, style, etc.
    await Stripe.instance.applySettings();

    _initialized = true;
  }

  @override
  Future<void> openCheckout(StripeOptions options) async {
    if (!_initialized) await initialize();

    try {
      // Use dummy client secret if null (demo mode)
      final clientSecret =
          options.publishableKey ?? 'pi_demo_client_secret_123';

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: options.customerEmail ?? 'Demo Store',
          customerId: options.customerEmail,
          // style: ThemeMode.light,
        ),
      );

      await Stripe.instance.presentPaymentSheet();
      _successController.add(
        PaymentResultSuccess(paymentId: 'stripe_demo_123', orderId: null),
      );
    } catch (e) {
      _errorController.add(PaymentResultError(code: 0, message: e.toString()));
    }
  }

  @override
  void dispose() {
    _successController.close();
    _errorController.close();
  }
}
