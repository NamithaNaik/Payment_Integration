import '../core/payment_options.dart';

class StripeOptions implements PaymentOptions {
  final String? publishableKey;
  final int amount; // cents
  final String currency;
  final String customerEmail;
  final Map<String, dynamic>? extra;

  StripeOptions({
    required this.publishableKey,
    required this.amount,
    required this.currency,
    required this.customerEmail,
    this.extra,
  });

  Map<String, dynamic> toMap() {
    return {
      'publishableKey': publishableKey,
      'amount': amount,
      'currency': currency,
      'customerEmail': customerEmail,
      if (extra != null) ...extra!,
    };
  }
}
