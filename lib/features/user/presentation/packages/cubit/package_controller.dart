import 'package:flutter/material.dart';
import 'package:moyasar/moyasar.dart';
import 'package:waseet/features/user/presentation/packages/view/payment_webview.dart';

class PackageController {
  static Future<bool> pay(
    String payLink,
    BuildContext context,
  ) async {
    final result = <String, dynamic>{};
    await Navigator.push(
      context,
      MaterialPageRoute<dynamic>(
        fullscreenDialog: true,
        maintainState: false,
        builder: (context) => ThreeDSWebView(
          callbackUri: Uri.parse('https://wasset.morph.sa/thanks'),
          transactionUrl: payLink,
          on3dsDone: (String status, String message) async {
            if (status == PaymentStatus.paid.name) {
              result['status'] = PaymentStatus.paid;
            } else if (status == PaymentStatus.authorized.name) {
              result['status'] = PaymentStatus.authorized;
            } else {
              result['status'] = PaymentStatus.failed;
              result['source'].message = message;
            }
            Navigator.pop(context, result);
          },
        ),
      ),
    );
    return result['status'] == PaymentStatus.paid ||
        result['status'] == PaymentStatus.authorized;
  }
}
