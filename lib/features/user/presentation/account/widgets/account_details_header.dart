// ignore_for_file: public_member_api_docs, sort_ructors_first

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:waseet/app/bloc/app_bloc.dart';
import 'package:waseet/features/user/presentation/account/widgets/curve_clipper.dart';
import 'package:waseet/features/user/presentation/profile_info/profile_info.dart';
import 'package:waseet/res/assets/assets.gen.dart';
import 'package:waseet/res/enums/broker_type.dart';
import 'package:waseet/router/screens.dart';

class AccountDetailsHeader extends StatelessWidget {
  const AccountDetailsHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return ClipPath(
          clipper: CurveClipper(),
          child: Container(
            width: double.infinity,
            color: const Color(0xffead6ff).withOpacity(0.38),
            padding: const EdgeInsets.all(26),
            child: InkWell(
              onTap: () {
                context.pushNamed(Screens.profileInfo.name);
              },
              child: Stack(
                children: [
                  Positioned(
                    right: 0,
                    top: 0,
                    left: 0,
                    bottom: 0,
                    child: FittedBox(
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 30.r,
                            backgroundColor: Colors.white,
                            child: state.user?.profile?.profileImage != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(50.r),
                                    child: Image.network(
                                      state.user!.profile!.profileImage!,
                                      width: 60.w,
                                      height: 60.h,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Assets.icons.user.svg(
                                    width: 30.w,
                                    height: 30.h,
                                  ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            state.user?.name ?? '',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: 'IBM Plex Sans',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          if (state.user!.profile?.officeType != null)
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Assets.icons.user.svg(
                                  width: 12.w,
                                  height: 12.h,
                                ),
                                SizedBox(
                                  width: 4.w,
                                ),
                                Text(
                                  state.user!.profile?.officeType?.toBrokerType
                                          .arabicName ??
                                      '',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          SizedBox(
                            height: 10.h,
                          ),
                          if (state.user!.profile?.cities?.isNotEmpty ?? false)
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Assets.icons.user.svg(
                                  width: 12.w,
                                  height: 12.h,
                                ),
                                SizedBox(
                                  width: 4.w,
                                ),
                                Text(
                                  state.user!.profile?.cities?.first.name ?? '',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
