import 'package:flutter/material.dart';
import 'package:waseet/app/bloc/app_bloc.dart';
import 'package:waseet/common_widgets/wasset_app_bar.dart';
import 'package:waseet/features/user/domain/repositories/authentication_repository.dart';
import 'package:waseet/features/user/domain/repositories/home_repository.dart';
import 'package:waseet/features/user/presentation/profile_info/cubit/cubit.dart';
import 'package:waseet/features/user/presentation/profile_info/widgets/profile_info_body.dart';
import 'package:waseet/res/helper_method.dart';

/// {@template profile_info_page}
/// A description for ProfileInfoPage
/// {@endtemplate}
class ProfileInfoPage extends StatelessWidget {
  /// {@macro profile_info_page}
  const ProfileInfoPage({super.key});

  /// The static route for ProfileInfoPage
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const ProfileInfoPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileInfoCubit(
        homeRepository: context.read<HomeRepository>(),
        authenticationRepository: context.read<AuthenticationRepository>(),
        profile: context.read<AppBloc>().state.user,
      ),
      child: const Scaffold(
        appBar: WassetAppBar(
          title: 'الملف الشخصي',
        ),
        body: ProfileInfoView(),
      ),
    );
  }
}

/// {@template profile_info_view}
/// Displays the Body of ProfileInfoView
/// {@endtemplate}
class ProfileInfoView extends StatelessWidget {
  /// {@macro profile_info_view}
  const ProfileInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileInfoCubit, ProfileInfoState>(
      listener: (context, state) {
        if (state.status == ProfileInfoStatus.updated) {
          context.read<AppBloc>().add(
                UpdateAccountProfileEvent(
                  state.profile!,
                ),
              );
          HelperMethod.showSnackBar(
            context,
            'تم تحديث البيانات بنجاح',
            type: SnackBarType.success,
          );
        } else if (state.status == ProfileInfoStatus.error) {
          HelperMethod.showSnackBar(
            context,
            state.errorMessage.isNotEmpty ? state.errorMessage : 'حدث خطأ ما',
            type: SnackBarType.error,
          );
        }
      },
      child: const ProfileInfoBody(),
    );
  }
}
