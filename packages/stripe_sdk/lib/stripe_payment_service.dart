import 'dart:async';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'stripe_options.dart';

class StripePaymentService {
  bool _initialized = false;

  final _successController = StreamController<String>.broadcast();
  final _errorController = StreamController<String>.broadcast();

  /// Streams to listen to payment results
  Stream<String> get onPaymentSuccess => _successController.stream;
  Stream<String> get onPaymentError => _errorController.stream;

  /// Initialize Stripe with publishable key (provided by client)
  Future<void> initialize({required String publishableKey}) async {
    if (_initialized) return;

    Stripe.publishableKey = publishableKey;
    await Stripe.instance.applySettings();
    _initialized = true;
  }

  /// Open Stripe Payment Sheet
  Future<void> openCheckout(StripeOptions options) async {
    if (!_initialized) {
      throw Exception("StripePaymentService not initialized. Pass publishableKey first.");
    }

    try {
      final clientSecret = options.paymentIntentClientSecret ??
          'pi_demo_client_secret_123'; // demo fallback

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: options.customerEmail ?? 'Demo Store',
          customerId: options.customerEmail,
        ),
      );

      await Stripe.instance.presentPaymentSheet();
      _successController.add('Payment successful: ${clientSecret}');
    } catch (e) {
      _errorController.add(e.toString());
    }
  }

  void dispose() {
    _successController.close();
    _errorController.close();
  }
}
