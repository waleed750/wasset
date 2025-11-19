import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:waseet/app/bloc/app_bloc.dart';
import 'package:waseet/constants/constants.dart';
import 'package:waseet/features/user/presentation/home_page/home_page.dart';
import 'package:waseet/features/user/presentation/home_page/widgets/user_status.dart';
import 'package:waseet/res/res.dart';
import 'package:waseet/router/screens.dart';

class HomeCustomAppBar extends StatelessWidget {
  const HomeCustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          if (state.status == AppStatus.unauthenticated) {
            return Container(
              color: AppColors.primaryColor,
              padding:
                  const EdgeInsets.symmetric(vertical: 5, horizontal: 25).r,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    Constants.logoWhite,
                  ),
                  TextButton(
                    onPressed: () {
                      context.pushNamed(Screens.login.name);
                    },
                    child: Text(
                      'تسجيل/ دخول',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFFF5F9FF),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 24,
            ).r,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.pushNamed(Screens.account.name);
                      },
                      child: Text(
                        'حسابي',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        context.pushNamed(Screens.account.name);
                      },
                      child: Icon(
                        Icons.account_circle,
                        color: Constants.primaryColor,
                        size: 30.sp,
                      ),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    const UserStatus(),
                  ],
                ),
                BlocBuilder<HomePageCubit, HomePageState>(
                  builder: (context, state) {
                    return GestureDetector(
                      onTap: () {
                        context.pushNamed(Screens.notifications.name);
                      },
                      child: state.unreadNothfication.isEmpty
                          ? SvgPicture.asset(
                              Constants.bell,
                              height: 20.w,
                              width: 20.w,
                            )
                          : Badge(
                              //TODO Replace with unread noti or delete
                              isLabelVisible: state.unreadNothfication.isEmpty,
                              smallSize: 9,
                              child: SvgPicture.asset(
                                Constants.bell,
                                height: 20.w,
                                width: 20.w,
                              ),
                            ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
