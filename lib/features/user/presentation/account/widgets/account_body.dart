// ignore_for_file: public_member_api_docs, sort_ructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:waseet/app/bloc/app_bloc.dart';
import 'package:waseet/features/user/presentation/account/widgets/account_details_header.dart';
import 'package:waseet/features/user/presentation/account/widgets/account_list_item.dart';
import 'package:waseet/features/user/presentation/account/widgets/request_nafath_auth_dialog.dart';
import 'package:waseet/features/user/presentation/policies_and_provisions/widgets/terms_of_use.dart';
import 'package:waseet/features/user/presentation/profile_info/profile_info.dart';
import 'package:waseet/res/assets/assets.gen.dart';
import 'package:waseet/res/helper_method.dart';
import 'package:waseet/res/res.dart';
import 'package:waseet/router/screens.dart';

/// {@template account_body}
/// Body of the AccountPage.
///
/// Add what it does
/// {@endtemplate}
class AccountBody extends StatefulWidget {
  /// {@macro account_body}
  const AccountBody({super.key});

  @override
  State<AccountBody> createState() => _AccountBodyState();
}

class _AccountBodyState extends State<AccountBody> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      final user = context.read<AppBloc>().state.user;
      if (user != null && !user.profile!.isVerified! && isTryingToVerify) {
        context.read<AppBloc>().add(GetAccountProfileEvent());
      }
    }
  }

  bool isTryingToVerify = false;
  bool isDialogShown = false;
  Timer? _timer;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listenWhen: (previous, current) {
        return current.user?.profile?.isVerified !=
            previous.user?.profile?.isVerified;
      },
      listener: (context, state) {
        if (state.user?.profile?.isVerified == true && isTryingToVerify) {
          _timer?.cancel();
          isTryingToVerify = false;
          if (isDialogShown) {
            context.pop();
          }
          HelperMethod.showSnackBar(context, 'تم توثيق حسابك بنجاح');
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 0.23.sh,
                  width: 1.sw,
                  child: const AccountDetailsHeader(),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20).r,
                  child: state.isWasset == true
                      ? Column(
                          children: [
                            ListTile(
                              onTap: state.user?.profile?.isVerified != true
                                  ? () {
                                      if (state.user?.profile?.identityNumber ==
                                          null) {
                                        HelperMethod.showSnackBar(
                                          context,
                                          'الرجاء تحديث بياناتك الشخصية وإضافة رقم الهوية/الإقامة',
                                        );
                                        context.pushNamed(
                                          Screens.profileInfo.name,
                                        );
                                        return;
                                      }
                                      showDialog(
                                        context: context,
                                        builder: (_) => SizedBox(
                                          height: 200.h,
                                          child: Center(
                                            child: RequestNafathAuthDialog(
                                              onDone: (String nationalId) {
                                                isTryingToVerify = true;
                                                context.read<AppBloc>().add(
                                                      RequestNafathAuthenticationEvent(
                                                        nationalId,
                                                        onException: (e) {
                                                          HelperMethod
                                                              .showSnackBar(
                                                            context,
                                                            e,
                                                            type: SnackBarType
                                                                .error,
                                                          );
                                                        },
                                                        onRequestDone:
                                                            (code) async {
                                                          _timer =
                                                              Timer.periodic(
                                                            const Duration(
                                                              seconds: 5,
                                                            ),
                                                            (timer) {
                                                              context
                                                                  .read<
                                                                      AppBloc>()
                                                                  .add(
                                                                    GetAccountProfileEvent(),
                                                                  );
                                                              final user = context
                                                                  .read<
                                                                      AppBloc>()
                                                                  .state
                                                                  .user;
                                                              if (user?.profile
                                                                      ?.isVerified ==
                                                                  true) {
                                                                _timer
                                                                    ?.cancel();
                                                                isTryingToVerify =
                                                                    false;
                                                              }
                                                            },
                                                          );
                                                          isDialogShown = true;
                                                          final dialog =
                                                              await showDialog<
                                                                  void>(
                                                            context: context,
                                                            builder:
                                                                (context) =>
                                                                    AlertDialog(
                                                              title: const Text(
                                                                'تم ارسال الكود',
                                                              ),
                                                              content: Text(
                                                                'قم بالضغط على الرقم $code في تطبيق النفاذ الوطني لتأكيد الربط',
                                                              ),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator
                                                                        .pop(
                                                                      context,
                                                                    );
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                    'حسنا',
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                          isDialogShown = false;
                                                          // keep calling the api to check if the user is verified every 5 seconds
                                                        },
                                                      ),
                                                    );
                                              },
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  : null,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  15,
                                ).r,
                              ),
                              tileColor: const Color(0x3353B175),
                              leading: Assets.images.nafath.image(
                                width: 30.w,
                                height: 30.w,
                                fit: BoxFit.cover,
                              ),
                              title: Text(
                                state.user?.profile?.isVerified != true
                                    ? 'وثق حسابك عبر النفاذ الوطني '
                                    : 'تم توثيق حسابك بنجاح',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 18.h,
                            ),
                            AccountListItem(
                              leadingPath: Assets.icons.idBadge.path,
                              text: 'مكتبي الشخصي ',
                              onTap: () {
                                context.pushNamed(
                                  Screens.myPersonalOffice.name,
                                );
                              },
                            ),
                            SizedBox(
                              height: 18.h,
                            ),
                            AccountListItem(
                              leadingPath: Assets.icons.speaker.path,
                              text: 'اعلاناتي ',
                              onTap: () {
                                context.pushNamed(Screens.myAds.name);
                              },
                            ),
                            SizedBox(
                              height: 18.h,
                            ),
                            AccountListItem(
                              leadingPath: Assets.icons.privacy.path,
                              text: 'السياسات والأحكام ',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const TermsOfUse(),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              height: 18.h,
                            ),
                            AccountListItem(
                              leadingPath: Assets.icons.packages.path,
                              text: 'الباقات',
                              onTap: () {
                                context.pushNamed(Screens.packages.name);
                              },
                            ),
                            SizedBox(
                              height: 18.h,
                            ),
                            AccountListItem(
                              leadingPath: Assets.icons.wallet.path,
                              text: 'الاشتراكات',
                              onTap: () {
                                context.pushNamed(Screens.subscriptions.name);
                              },
                            ),
                            SizedBox(
                              height: 18.h,
                            ),
                            AccountListItem(
                              leadingPath: Assets.icons.questionSquare.path,
                              text: 'البلاغات  ',
                              onTap: () {
                                context.pushNamed(Screens.complaint.name);
                              },
                            ),
                            SizedBox(
                              height: 18.h,
                            ),
                            AccountListItem(
                              leadingPath: Assets.icons.privacy.path,
                              text: 'عن وسيط',
                              onTap: () {
                                context.pushNamed(Screens.aboutUs.name);
                              },
                            ),
                            //  SizedBox(
                            //   height: 18.h,
                            // ),
                            // AccountListItem(
                            //   leadingPath: Assets.icons.idBadge.path,
                            //   text: 'مكتبي الشخصي ',
                            // ),
                            SizedBox(
                              height: 18.h,
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            SizedBox(
                              height: 18.h,
                            ),
                            AccountListItem(
                              leadingPath: Assets.icons.privacy.path,
                              text: 'السياسات والأحكام ',
                              onTap: () {
                                context.pushNamed(
                                  Screens.policiesAndProvisions.name,
                                );
                              },
                            ),
                            SizedBox(
                              height: 18.h,
                            ),
                            AccountListItem(
                              leadingPath: Assets.icons.questionSquare.path,
                              text: 'البلاغات  ',
                              onTap: () {
                                context.pushNamed(Screens.complaint.name);
                              },
                            ),
                            SizedBox(
                              height: 18.h,
                            ),
                            AccountListItem(
                              leadingPath: Assets.icons.privacy.path,
                              text: 'عن وسيط',
                              onTap: () {
                                context.pushNamed(Screens.aboutUs.name);
                              },
                            ),
                          ],
                        ),
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    context.read<AppBloc>().add(AppLoggedOut());
                    context.goNamed(Screens.home.name);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 20).r,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        'تسجيل الخروج',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'حذف الحساب',
                    style: TextStyle(
                      color: const Color(0xFFEE5253),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.underline,
                      decorationColor: const Color(0xFFEE5253),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
