import 'package:payment_gateway_integration/payment_options.dart';

class RazorpayOptions implements PaymentOptions {
  final String key;
  final int amount; // in paise
  final String name;
  final String description;
  final String contact;
  final String email;

  RazorpayOptions({
    required this.key,
    required this.amount,
    required this.name,
    required this.description,
    required this.contact,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'key': key,
      'amount': amount,
      'name': name,
      'description': description,
      'prefill': {
        'contact': contact,
        'email': email,
      }
    };
  }
}
