import 'package:flutter/material.dart';
import 'package:waseet/features/user/presentation/packages/cubit/cubit.dart';
import 'package:waseet/features/user/presentation/packages/widgets/payment_body.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key, this.cubit});
  final PackagesCubit? cubit;
  static Route<dynamic> route({
    PackagesCubit? package,
  }) {
    return MaterialPageRoute<dynamic>(
      builder: (_) => PaymentPage(
        cubit: package,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit!,
      child: const Scaffold(
        body: PaymentView(),
      ),
    );
  }
}

class PaymentView extends StatelessWidget {
  const PaymentView({super.key});
  @override
  Widget build(BuildContext context) {
    return PaymentBody();
  }
}
