import 'package:payment_gateway_integration/payment_options.dart';

class StripeOptions implements PaymentOptions {
  final String publishableKey;
  final int amount; // in cents
  final String currency;
  final String customerEmail;

  StripeOptions({
    required this.publishableKey,
    required this.amount,
    required this.currency,
    required this.customerEmail,
  });

  Map<String, dynamic> toMap() {
    return {
      'publishableKey': publishableKey,
      'amount': amount,
      'currency': currency,
      'customerEmail': customerEmail,
    };
  }
}
