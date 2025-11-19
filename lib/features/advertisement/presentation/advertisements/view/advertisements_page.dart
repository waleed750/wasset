import 'package:flutter/material.dart';
import 'package:waseet/constants/constants.dart';
import 'package:waseet/features/advertisement/domain/repositories/ad_repository.dart';
import 'package:waseet/features/advertisement/presentation/advertisements/cubit/cubit.dart';
import 'package:waseet/features/advertisement/presentation/advertisements/widgets/advertisements_body.dart';
import 'package:waseet/features/advertisement/presentation/advertisements/widgets/fav_advertisements_body.dart';
import 'package:waseet/features/user/domain/repositories/complaints_repository.dart';
import 'package:waseet/features/user/domain/repositories/home_repository.dart';
import 'package:waseet/res/helper_method.dart';

/// {@template advertisements_page}
/// A description for AdvertisementsPage
/// {@endtemplate}
class AdvertisementsPage extends StatelessWidget {
  /// {@macro advertisements_page}
  const AdvertisementsPage({super.key});

  /// The static route for AdvertisementsPage
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const AdvertisementsPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdvertisementsCubit(
        adRepository: context.read<AdRepository>(),
        homeRepository: context.read<HomeRepository>(),
        complaintRepository: context.read<ComplaintRepository>(),
      ),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: const Text(
              'الاعلانات',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            bottom: const TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: Color(0xFf8282DD),
              labelColor: Constants.primaryColor,
              unselectedLabelColor: Color(0xFFADB5BD),
              tabs: <Tab>[
                Tab(
                  text: 'جميع الاعلانات',
                ),
                Tab(
                  text: 'اعلانات مهتم فيها',
                ),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              AdvertisementsView(),
              FavAdvertisementsView(),
            ],
          ),
        ),
      ),
    );
  }
}

class AdvertisementsView extends StatelessWidget {
  const AdvertisementsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AdvertisementsCubit, AdvertisementsState>(
      listener: (context, state) {
        if (state.status == AdvertisementsStatus.removeLoading) {
          HelperMethod.showSnackBar(
            context,
            '  جاري حذف الإعلان للمفضلة ....',
          );
        }
        if (state.status == AdvertisementsStatus.addLoading) {
          HelperMethod.showSnackBar(
            context,
            ' جاري اضافة الإعلان للمفضلة ....',
          );
        }
        if (state.status == AdvertisementsStatus.addAndRemoveSuccess) {
          HelperMethod.showSnackBar(
            context,
            state.addAndRemoveMessage ?? 'تم بنجاح ',
            type: SnackBarType.success,
          );
        }
        if (state.status == AdvertisementsStatus.addAndRemoveError) {
          HelperMethod.showSnackBar(
            context,
            state.errorMessage,
            type: SnackBarType.error,
          );
        }
        if (state.status == AdvertisementsStatus.processLoading) {
          HelperMethod.showSnackBar(
            context,
            ' جاري تقديم البلاغ ....',
          );
        }
        if (state.status == AdvertisementsStatus.processSuccess) {
          HelperMethod.showSnackBar(
            context,
            state.addAndRemoveMessage ?? 'تم تقديم البلاغ ',
            type: SnackBarType.success,
          );
        }
        if (state.status == AdvertisementsStatus.processFailure) {
          HelperMethod.showSnackBar(
            context,
            state.processMessage,
            type: SnackBarType.error,
          );
        }
      },
      child: const AdvertisementsBody(),
    );
  }
}

class FavAdvertisementsView extends StatelessWidget {
  const FavAdvertisementsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AdvertisementsCubit, AdvertisementsState>(
      listener: (context, state) {
        if (state.status == AdvertisementsStatus.removeLoading) {
          HelperMethod.showSnackBar(
            context,
            '  جاري حذف الإعلان للمفضلة ....',
          );
        }
        if (state.status == AdvertisementsStatus.addLoading) {
          HelperMethod.showSnackBar(
            context,
            ' جاري اضافة الإعلان للمفضلة ....',
          );
        }
        if (state.status == AdvertisementsStatus.addAndRemoveSuccess) {
          HelperMethod.showSnackBar(
            context,
            state.addAndRemoveMessage ?? 'تم بنجاح ',
            type: SnackBarType.success,
          );
        }
        if (state.status == AdvertisementsStatus.addAndRemoveError) {
          HelperMethod.showSnackBar(
            context,
            state.errorMessage,
            type: SnackBarType.error,
          );
        }
        if (state.status == AdvertisementsStatus.processLoading) {
          HelperMethod.showSnackBar(
            context,
            ' جاري تقديم البلاغ ....',
          );
        }
        if (state.status == AdvertisementsStatus.processSuccess) {
          HelperMethod.showSnackBar(
            context,
            state.addAndRemoveMessage ?? 'تم تقديم البلاغ ',
            type: SnackBarType.success,
          );
        }
        if (state.status == AdvertisementsStatus.processFailure) {
          HelperMethod.showSnackBar(
            context,
            state.processMessage,
            type: SnackBarType.error,
          );
        }
      },
      child: const FavAdvertisementsBody(),
    );
  }
}
