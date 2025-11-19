import 'package:flutter/material.dart';
import 'package:waseet/features/brokers/domain/repositories/brokers_repository.dart';
import 'package:waseet/features/brokers/presentation/kingdom_broker/cubit/cubit.dart';
import 'package:waseet/features/brokers/presentation/kingdom_broker/widgets/my_broker_body.dart';
import 'package:waseet/features/user/domain/repositories/complaints_repository.dart';
import 'package:waseet/features/user/domain/repositories/home_repository.dart';
import 'package:waseet/res/helper_method.dart';

class MyBrokerPage extends StatelessWidget {
  const MyBrokerPage({
    super.key,
  });

  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const MyBrokerPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => KingdomBrokerCubit(
        complaintRepository: context.read<ComplaintRepository>(),
        brokerRepository: context.read<BrokerRepository>(),
        homeRepository: context.read<HomeRepository>(),
      ),
      child: const Scaffold(body: MyBrokerPageView()),
    );
  }
}

class MyBrokerPageView extends StatelessWidget {
  const MyBrokerPageView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<KingdomBrokerCubit, KingdomBrokerState>(
      listener: (context, state) {
        if (state.status == BrokerStatus.removeLoading) {
          HelperMethod.showSnackBar(
            context,
            ' جاري حذف الوسيط ....',
          );
        }
        if (state.status == BrokerStatus.addLoading) {
          HelperMethod.showSnackBar(
            context,
            ' جاري اضافة الوسيط ....',
          );
        }
        if (state.status == BrokerStatus.addAndRemoveSuccess) {
          HelperMethod.showSnackBar(
            context,
            state.addAndRemoveBrokerMessage ?? 'تم بنجاح ',
            type: SnackBarType.success,
          );
        }
        if (state.status == BrokerStatus.addAndRemoveError) {
          HelperMethod.showSnackBar(
            context,
            state.errorMessage,
            type: SnackBarType.error,
          );
        }
        if (state.status == BrokerStatus.processLoading) {
          HelperMethod.showSnackBar(
            context,
            ' جاري تقديم البلاغ ....',
          );
        }
        if (state.status == BrokerStatus.processSuccess) {
          HelperMethod.showSnackBar(
            context,
            state.processMessage ?? 'تم تقديم البلاغ ',
            type: SnackBarType.success,
          );
        }
        if (state.status == BrokerStatus.processFailure) {
          HelperMethod.showSnackBar(
            context,
            state.processMessage ?? 'حدث خطأ ما',
            type: SnackBarType.error,
          );
        }
      },
      child: const MyBrokerBody(),
    );
  }
}
