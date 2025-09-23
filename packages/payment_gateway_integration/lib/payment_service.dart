import 'package:payment_gateway_integration/payment_options.dart';

abstract class PaymentService<T extends PaymentOptions> {
  Future<void> initialize();
  Future<void> openCheckout(T options);
  void dispose();
}
