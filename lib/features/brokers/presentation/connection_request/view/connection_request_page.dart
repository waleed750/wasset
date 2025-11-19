import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:waseet/constants/constants.dart';
import 'package:waseet/features/advertisement/presentation/add_new_ad/add_new_ad.dart';
import 'package:waseet/features/brokers/domain/repositories/communication_repository.dart';
import 'package:waseet/features/brokers/presentation/connection_request/cubit/connection_request_cubit.dart';
import 'package:waseet/features/brokers/presentation/connection_request/widgets/all_connection_requests.dart';
import 'package:waseet/features/brokers/presentation/connection_request/widgets/favorite_communication_requests.dart';
import 'package:waseet/features/brokers/presentation/connection_request/widgets/today_connection_request_body.dart';
import 'package:waseet/features/user/domain/repositories/complaints_repository.dart';
import 'package:waseet/res/helper_method.dart';
import 'package:waseet/router/screens.dart';

class ConnectionRequestPage extends StatelessWidget {
  const ConnectionRequestPage({super.key});

  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const ConnectionRequestPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ConnectionRequestCubit(
        complaintRepository: context.read<ComplaintRepository>(),
        communicationRepository: context.read<CommunicationRepository>(),
      ),
      child: Scaffold(
        body: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                'طلبات التواصل',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              bottom: const TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: Color(0xFf8282DD),
                labelColor: Constants.primaryColor,
                unselectedLabelColor: Color(0xFFADB5BD),
                tabs: [
                  Tab(
                    text: 'طلبات اليوم',
                  ),
                  Tab(
                    text: 'جميع الطلبات',
                  ),
                  Tab(
                    text: 'المفضلة',
                  ),
                ],
              ),
            ),
            body: const TabBarView(
              children: [
                ConnectionRequestsTodayView(),
                AllConnectionRequestsView(),
                FavoriteCommunicationRequestsView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ConnectionRequestsTodayView extends StatelessWidget {
  const ConnectionRequestsTodayView({super.key});

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
        if (state.status == ConnectionRequestStatus.addLoading) {
          HelperMethod.showSnackBar(
            context,
            ' جاري اضافة الطلب للمفضلة ....',
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
        if (state.status == ConnectionRequestStatus.addAndRemoveFailure) {
          HelperMethod.showSnackBar(
            context,
            state.errorMessage,
            type: SnackBarType.error,
          );
        }

        if (state.status == ConnectionRequestStatus.processFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.processMessage ?? 'حدث خطأ ما '),
              ),
            );
          HelperMethod.showSnackBar(
            context,
            state.errorMessage,
            type: SnackBarType.error,
          );
        }

        if (state.status == ConnectionRequestStatus.startingChatLoading) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text('جاري فتح الدردشة ....'),
              ),
            );
          HelperMethod.showSnackBar(
            context,
            state.errorMessage,
            type: SnackBarType.error,
          );
        }

        if (state.status == ConnectionRequestStatus.startingChatSuccess) {
          context.pushReplacementNamed(
            Screens.chat.name,
            pathParameters: {
              'chatId': state.chatAndDetails?.chat.id.toString() ?? '',
              'chatType': 'p2p',
            },
            queryParameters: {
              'name': state.chatAndDetails?.chat.user?.name ?? 'Rashed',
            },
          );
        }
      },
      child: const ConnectionRequestsTodayViewBody(),
    );
  }
}

class AllConnectionRequestsView extends StatelessWidget {
  const AllConnectionRequestsView({super.key});

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
        if (state.status == ConnectionRequestStatus.addLoading) {
          HelperMethod.showSnackBar(
            context,
            ' جاري اضافة الطلب للمفضلة ....',
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
      child: const AllConnectionRequestsViewBody(),
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
        if (state.status == ConnectionRequestStatus.addLoading) {
          HelperMethod.showSnackBar(
            context,
            ' جاري اضافة الطلب للمفضلة ....',
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
