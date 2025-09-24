import 'package:payment_gateway_integration/payment_gateway_integration.dart';

class RazorpayOptions implements PaymentOptions {
  final String key;
  final int amount; // in paise
  final String name;
  final String description;
  final String? contact;
  final String? email;
  final Map<String, dynamic>? additionalOptions;

  RazorpayOptions({
    required this.key,
    required this.amount,
    required this.name,
    required this.description,
    this.contact,
    this.email,
    this.additionalOptions,
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'key': key,
      'amount': amount,
      'name': name,
      'description': description,
    };

    final prefill = <String, dynamic>{};
    if (contact != null) prefill['contact'] = contact;
    if (email != null) prefill['email'] = email;
    if (prefill.isNotEmpty) map['prefill'] = prefill;

    if (additionalOptions != null) {
      map.addAll(additionalOptions!);
    }
    return map;
  }
}
