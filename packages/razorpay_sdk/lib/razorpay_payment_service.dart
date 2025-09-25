// import 'dart:async';

// import 'package:razorpay_flutter/razorpay_flutter.dart';

// import 'package:payment_gateway_integration/payment_gateway_integration.dart';
// import 'razorpay_options.dart';

// class RazorpayPaymentService implements PaymentService<RazorpayOptions> {
//   late Razorpay _razorpay;
//   bool _initialized = false;

//   final _successController = StreamController<PaymentResultSuccess>.broadcast();
//   final _errorController = StreamController<PaymentResultError>.broadcast();
//   final _externalController =
//       StreamController<PaymentExternalWallet>.broadcast();

//   /// Streams to listen to payment events:
//   Stream<PaymentResultSuccess> get onPaymentSuccess =>
//       _successController.stream;
//   Stream<PaymentResultError> get onPaymentError => _errorController.stream;
//   Stream<PaymentExternalWallet> get onExternalWallet =>
//       _externalController.stream;

//   @override
//   Future<void> initialize() async {
//     if (_initialized) return;
//     _razorpay = Razorpay();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//     _initialized = true;
//   }

//   void _handlePaymentSuccess(PaymentSuccessResponse response) {
//     _successController.add(
//       PaymentResultSuccess(
//         paymentId: response.paymentId ?? '',
//         orderId: response.orderId,
//         signature: response.signature,
//       ),
//     );
//   }

//   void _handlePaymentError(PaymentFailureResponse response) {
//     _errorController.add(
//       PaymentResultError(
//         code: response.code ?? 0,
//         message: response.message ?? 'Unknown error',
//       ),
//     );
//   }

//   void _handleExternalWallet(ExternalWalletResponse response) {
//     _externalController.add(
//       PaymentExternalWallet(name: response.walletName ?? ''),
//     );
//   }

//   @override
//   Future<void> openCheckout(RazorpayOptions options) async {
//     if (!_initialized) await initialize();
//     _razorpay.open(options.toMap());
//   }

//   @override
//   void dispose() {
//     try {
//       _razorpay.clear();
//     } catch (_) {}
//     _successController.close();
//     _errorController.close();
//     _externalController.close();
//   }
// }

import 'dart:async';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'razorpay_options.dart'; // keep your RazorpayOptions class

class RazorpayPaymentService {
  late Razorpay _razorpay;
  bool _initialized = false;

  final _successController =
      StreamController<PaymentSuccessResponse>.broadcast();
  final _errorController = StreamController<PaymentFailureResponse>.broadcast();
  final _externalController =
      StreamController<ExternalWalletResponse>.broadcast();

  Stream<PaymentSuccessResponse> get onPaymentSuccess =>
      _successController.stream;
  Stream<PaymentFailureResponse> get onPaymentError => _errorController.stream;
  Stream<ExternalWalletResponse> get onExternalWallet =>
      _externalController.stream;

  Future<void> initialize() async {
    if (_initialized) return;

    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _successController.add);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _errorController.add);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _externalController.add);

    _initialized = true;
  }

  Future<void> openCheckout(RazorpayOptions options) async {
    if (!_initialized) await initialize();
    _razorpay.open(options.toMap());
  }

  void dispose() {
    try {
      _razorpay.clear();
    } catch (_) {}
    _successController.close();
    _errorController.close();
    _externalController.close();
  }
}
