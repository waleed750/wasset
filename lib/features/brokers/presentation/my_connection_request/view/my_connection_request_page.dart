import 'package:flutter/material.dart';
import 'package:waseet/app/bloc/app_bloc.dart';
import 'package:waseet/common_widgets/wasset_app_bar.dart';
import 'package:waseet/features/advertisement/presentation/add_new_ad/add_new_ad.dart';
import 'package:waseet/features/brokers/domain/repositories/communication_repository.dart';
import 'package:waseet/features/brokers/presentation/my_connection_request/cubit/my_connection_request_cubit.dart';
import 'package:waseet/features/brokers/presentation/my_connection_request/widgets/my_connection_request_body.dart';
import 'package:waseet/res/helper_method.dart';

class MyConnectionRequestPage extends StatelessWidget {
  const MyConnectionRequestPage({super.key});

  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const MyConnectionRequestPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyConnectionRequestCubit(
        userId: context.read<AppBloc>().state.user!.id,
        communicationRepository: context.read<CommunicationRepository>(),
      ),
      child: const Scaffold(
        appBar: WassetAppBar(
          title: 'طلباتي',
        ),
        body: MyConnectionRequestView(),
      ),
    );
  }
}

class MyConnectionRequestView extends StatelessWidget {
  const MyConnectionRequestView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<MyConnectionRequestCubit, MyConnectionRequestState>(
      listener: (context, state) {
        if (state.status == MyConnectionRequestStatus.processLoading) {
          HelperMethod.showSnackBar(
            context,
            'جاري الحذف ....',
          );
        }
        if (state.status == MyConnectionRequestStatus.processFailure) {
          HelperMethod.showSnackBar(
            context,
            state.processMessage ?? 'حدث خطأ ما اعد المحاولة',
            type: SnackBarType.error,
          );
        }

        if (state.status == MyConnectionRequestStatus.processSuccess) {
          HelperMethod.showSnackBar(
            context,
            'تم حذف الطلب بنجاح',
            type: SnackBarType.success,
          );
        }
      },
      child: const MyConnectionRequestBody(),
    );
  }
}
