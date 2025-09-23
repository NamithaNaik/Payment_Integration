import 'payment_service.dart';
import 'payment_options.dart';

class PaymentManager<T extends PaymentOptions> {
  final PaymentService<T> service;

  PaymentManager(this.service);

  Future<void> initialize() => service.initialize();

  Future<void> openCheckout(T options) => service.openCheckout(options);

  void dispose() => service.dispose();
}
