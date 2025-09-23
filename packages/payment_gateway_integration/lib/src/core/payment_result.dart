class PaymentResultSuccess {
  final String paymentId;
  final String? orderId;
  final String? signature;

  PaymentResultSuccess({
    required this.paymentId,
    this.orderId,
    this.signature,
  });
}

class PaymentResultError {
  final int code;
  final String message;

  PaymentResultError({
    required this.code,
    required this.message,
  });
}

class PaymentExternalWallet {
  final String name;
  PaymentExternalWallet({required this.name});
}
