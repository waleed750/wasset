import 'package:flutter/material.dart';
import 'package:waseet/common_widgets/wasset_app_bar.dart';
import 'package:waseet/features/advertisement/domain/repositories/ad_repository.dart';
import 'package:waseet/features/advertisement/presentation/add_new_ad/cubit/cubit.dart';
import 'package:waseet/features/advertisement/presentation/add_new_ad/widgets/add_new_ad_body.dart';
import 'package:waseet/features/user/domain/repositories/home_repository.dart';
import 'package:waseet/res/helper_method.dart';

/// {@template add_new_ad_page}
/// A description for AddNewAdPage
/// {@endtemplate}
class AddNewAdPage extends StatelessWidget {
  /// {@macro add_new_ad_page}
  const AddNewAdPage({super.key});

  /// The static route for AddNewAdPage
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const AddNewAdPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddNewAdCubit(
        homeRepository: context.read<HomeRepository>(),
        adRepository: context.read<AdRepository>(),
      ),
      child: const Scaffold(
        appBar: WassetAppBar(
          title: 'اضافة اعلان',
          showBackButton: false,
        ),
        body: AddNewAdView(),
      ),
    );
  }
}

/// {@template add_new_ad_view}
/// Displays the Body of AddNewAdView
/// {@endtemplate}
class AddNewAdView extends StatelessWidget {
  /// {@macro add_new_ad_view}
  const AddNewAdView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddNewAdCubit, AddNewAdState>(
      listener: (context, state) {
        if (state.status == AddNewAdStatus.success) {
          HelperMethod.showSnackBar(
            context,
            'تم اضافة الاعلان بنجاح',
            type: SnackBarType.success,
          );
          Navigator.of(context).pop();
        }

        if (state.status == AddNewAdStatus.error) {
          HelperMethod.showSnackBar(
            context,
            state.errorMessage,
            type: SnackBarType.error,
          );
        }
      },
      child: const AddNewAdBody(),
    );
  }
}
