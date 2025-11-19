import 'package:flutter/material.dart';
import 'package:waseet/features/advertisement/presentation/add_new_ad/add_new_ad.dart';
import 'package:waseet/features/brokers/domain/entities/connection_request_entity.dart';
import 'package:waseet/features/brokers/domain/repositories/communication_repository.dart';
import 'package:waseet/features/brokers/presentation/update_connection_request/cubit/update_connection_request_cubit.dart';
import 'package:waseet/features/brokers/presentation/update_connection_request/widgets/update_connection_request_body.dart';
import 'package:waseet/features/user/domain/repositories/home_repository.dart';
import 'package:waseet/res/helper_method.dart';

class UpdateConnectionRequestPage extends StatelessWidget {
  const UpdateConnectionRequestPage({super.key, required this.request});
  final ConnectionRequestEntity request;
  static Route<dynamic> route(ConnectionRequestEntity request) {
    return MaterialPageRoute<dynamic>(
      builder: (_) => UpdateConnectionRequestPage(
        request: request,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateConnectionRequestCubit(
        request: request,
        homeRepository: context.read<HomeRepository>(),
        communicationRepository: context.read<CommunicationRepository>(),
      ),
      child: const Scaffold(
        body: UpdateConnectionRequestView(),
      ),
    );
  }
}

class UpdateConnectionRequestView extends StatelessWidget {
  const UpdateConnectionRequestView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateConnectionRequestCubit,
        UpdateConnectionRequestState>(
      listener: (context, state) {
        if (state.status == UpdateConnectionRequestStatus.error) {
          HelperMethod.showSnackBar(
            context,
            state.errorMessage,
            type: SnackBarType.error,
          );
        }

        if (state.status == UpdateConnectionRequestStatus.success) {
          HelperMethod.showSnackBar(
            context,
            'تم تعديل الطلب بنجاح',
            type: SnackBarType.success,
          );
          Navigator.of(context).pop();
        }
      },
      child: const UpdateConnectionRequestBody(),
    );
  }
}
