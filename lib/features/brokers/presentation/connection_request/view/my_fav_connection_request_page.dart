import 'package:flutter/material.dart';
import 'package:waseet/common_widgets/wasset_app_bar.dart';
import 'package:waseet/features/advertisement/presentation/add_new_ad/add_new_ad.dart';
import 'package:waseet/features/brokers/domain/repositories/communication_repository.dart';
import 'package:waseet/features/brokers/presentation/connection_request/cubit/connection_request_cubit.dart';
import 'package:waseet/features/brokers/presentation/connection_request/widgets/favorite_communication_requests.dart';
import 'package:waseet/features/user/domain/repositories/complaints_repository.dart';
import 'package:waseet/res/helper_method.dart';

class MyFavConnectionRequestPage extends StatelessWidget {
  const MyFavConnectionRequestPage({super.key});

  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const MyFavConnectionRequestPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ConnectionRequestCubit(
        complaintRepository: context.read<ComplaintRepository>(),
        communicationRepository: context.read<CommunicationRepository>(),
      ),
      child: const Scaffold(
        appBar: WassetAppBar(title: 'طلبات تهمني'),
        body: FavoriteCommunicationRequestsView(),
      ),
    );
  }
}

class FavoriteCommunicationRequestsView extends StatelessWidget {
  const FavoriteCommunicationRequestsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectionRequestCubit, ConnectionRequestState>(
      listener: (context, state) {
        if (state.status == ConnectionRequestStatus.removeLoading) {
          HelperMethod.showSnackBar(
            context,
            '  جاري حذف الطلب من المفضل....',
          );
        }
        if (state.status == ConnectionRequestStatus.addAndRemoveSuccess) {
          HelperMethod.showSnackBar(
            context,
            state.processMessage ?? 'تم بنجاح ',
            type: SnackBarType.success,
          );
        }
        if (state.status == ConnectionRequestStatus.addAndRemoveFailure) {
          HelperMethod.showSnackBar(
            context,
            state.errorMessage,
            type: SnackBarType.error,
          );
        }
        if (state.status == ConnectionRequestStatus.processLoading) {
          HelperMethod.showSnackBar(
            context,
            ' جاري تقديم البلاغ ....',
          );
        }
        if (state.status == ConnectionRequestStatus.processSuccess) {
          HelperMethod.showSnackBar(
            context,
            state.processMessage ?? 'تم تقديم البلاغ بنجاح ',
            type: SnackBarType.success,
          );
        }
        if (state.status == ConnectionRequestStatus.processFailure) {
          HelperMethod.showSnackBar(
            context,
            state.processMessage ?? 'حدث خطأ ما ',
            type: SnackBarType.error,
          );
        }
      },
      child: const FavoriteCommunicationRequestsViewBody(),
    );
  }
}
