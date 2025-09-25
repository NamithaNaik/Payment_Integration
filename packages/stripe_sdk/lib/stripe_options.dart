import 'package:payment_gateway_integration/payment_gateway_integration.dart';

class StripeOptions implements PaymentOptions {
  final String? publishableKey;
  final String? paymentIntentClientSecret;
  final int amount; // cents
  final String currency;
  final String customerEmail;
  final Map<String, dynamic>? extra;

  StripeOptions({
    this.publishableKey,
    this.paymentIntentClientSecret,
    required this.amount,
    required this.currency,
    required this.customerEmail,
    this.extra,
  });

  Map<String, dynamic> toMap() {
    return {
      'publishableKey': publishableKey,
      'paymentIntentClientSecret': paymentIntentClientSecret,
      'amount': amount,
      'currency': currency,
      'customerEmail': customerEmail,
      if (extra != null) ...extra!,
    };
  }
}

// class StripeOptions {
//   final String? paymentIntentClientSecret; // must be passed from client
//   final String? customerEmail;
//   final int? amount;
//   final String? currency;

//   StripeOptions({
//     this.paymentIntentClientSecret,
//     this.customerEmail,
//     this.amount,
//     this.currency,
//   });
// }
