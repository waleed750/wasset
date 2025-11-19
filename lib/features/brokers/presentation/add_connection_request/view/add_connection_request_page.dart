import 'package:flutter/material.dart';
import 'package:waseet/features/advertisement/presentation/add_new_ad/add_new_ad.dart';
import 'package:waseet/features/brokers/domain/repositories/communication_repository.dart';
import 'package:waseet/features/brokers/presentation/add_connection_request/cubit/add_connection_request_cubit.dart';
import 'package:waseet/features/brokers/presentation/add_connection_request/widgets/add_connection_request_body.dart';
import 'package:waseet/features/user/domain/repositories/home_repository.dart';
import 'package:waseet/res/helper_method.dart';

class AddConnectionRequestPage extends StatelessWidget {
  const AddConnectionRequestPage({super.key});
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const AddConnectionRequestPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddConnectionRequestCubit(
        homeRepository: context.read<HomeRepository>(),
        communicationRepository: context.read<CommunicationRepository>(),
      ),
      child: const Scaffold(
        body: AddConnectionRequestView(),
      ),
    );
  }
}

class AddConnectionRequestView extends StatelessWidget {
  const AddConnectionRequestView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddConnectionRequestCubit, AddConnectionRequestState>(
      listener: (context, state) {
        if (state.status == AddConnectionRequestStatus.error) {
          HelperMethod.showSnackBar(
            context,
            state.errorMessage,
            type: SnackBarType.error,
          );
        }

        if (state.status == AddConnectionRequestStatus.success) {
          HelperMethod.showSnackBar(
            context,
            'تم انشاء الطلب بنجاح',
            type: SnackBarType.success,
          );
          Navigator.of(context).pop();
        }
      },
      child: const AddConnectionRequestBody(),
    );
  }
}
