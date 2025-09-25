# Payment Method

A Flutter project that provides a unified interface for multiple payment gateways, making it easy to switch between different payment providers.

## Project Structure

This project is organized into several packages:

- **`packages/payment_gateway_integration`**: This is the core package that defines the abstract interface for all payment gateways. It includes:
  - `PaymentService`: An abstract class that defines the contract for a payment service.
  - `PaymentOptions`: An abstract class for payment options.
  - `PaymentResult`: A set of classes representing the outcome of a payment.
  - `PaymentManager`: A class to manage a `PaymentService`.

- **`packages/razorpay_sdk`**: An implementation of the payment gateway interface for Razorpay. It uses the `razorpay_flutter` package.

- **`packages/stripe_sdk`**: An implementation of the payment gateway interface for Stripe. It uses the `flutter_stripe` package.

## How to Use

To use the payment functionality, you need to initialize a `PaymentManager` with a specific `PaymentService`.

### Example

Here's how you can initiate a payment with Razorpay:

```dart
import 'package:flutter/material.dart';
import 'package:payment_gateway_integration/payment_gateway_integration.dart';
import 'package:razorpay_sdk/razorpay_sdk.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Payment Demo',
      home: PaymentScreen(),
    );
  }
}

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late PaymentManager<RazorpayOptions> _paymentManager;

  @override
  void initState() {
    super.initState();
    final razorpayService = RazorpayPaymentService();
    _paymentManager = PaymentManager(razorpayService);
    _paymentManager.initialize();

    razorpayService.onPaymentSuccess.listen((result) {
      // Handle success
      print('Payment successful: ${result.paymentId}');
    });

    razorpayService.onPaymentError.listen((result) {
      // Handle error
      print('Payment error: ${result.code} - ${result.message}');
    });
  }

  @override
  void dispose() {
    _paymentManager.dispose();
    super.dispose();
  }

  void _startPayment() {
    final options = RazorpayOptions(
      key: 'YOUR_RAZORPAY_KEY', // Replace with your key
      amount: 10000, // in paise (e.g., 100.00)
      name: 'Sample Product',
      description: 'A test payment',
      contact: '9876543210',
      email: 'test@example.com',
    );
    _paymentManager.openCheckout(options);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Demo'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _startPayment,
          child: const Text('Pay with Razorpay'),
        ),
      ),
    );
  }
}
```

## Adding a New Payment Gateway

To add a new payment gateway, you need to:

1.  **Create a new package** in the `packages` directory.
2.  **Add the required dependencies** for the new payment gateway's SDK in its `pubspec.yaml`.
3.  **Create a `PaymentOptions` implementation** for the new gateway.
4.  **Create a `PaymentService` implementation** that uses the new gateway's SDK to process payments.

## Getting Started with Flutter

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.