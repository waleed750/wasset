import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:waseet/app/bloc/app_bloc.dart';
import 'package:waseet/common_widgets/broker_item_icon.dart';
import 'package:waseet/features/user/presentation/register/widgets/wasset_button.dart';
import 'package:waseet/router/screens.dart';

PopupMenuItem<dynamic> cardPopupMenuItem({
  required BuildContext context,
  required String menuItemTitle,
  required String dialogTitle,
  required String buttonText,
  required void Function() dailogButtonFunc,
  required IconData icon,
  Widget? dialogBody,
}) {
  return PopupMenuItem(
    onTap: () {
      final isAuth =
          context.read<AppBloc>().state.status == AppStatus.authenticated;
      !isAuth
          ? context.pushNamed(Screens.login.name)
          : showCustomDialog(
              context: context,
              title: dialogTitle,
              buttonText: buttonText,
              body: dialogBody ?? const SizedBox.shrink(),
              dailogButtonFunc: dailogButtonFunc,
            );
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BrokerItemIcon(
          icon: icon,
        ),
        Text(menuItemTitle),
      ],
    ),
  );
}

Future<dynamic> showCustomDialog({
  required BuildContext context,
  required Widget body,
  required String title,
  required String buttonText,
  required void Function() dailogButtonFunc,
}) =>
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8).r,
              color: Colors.white,
            ),
            padding: const EdgeInsets.all(20).r,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    BrokerItemIcon(
                      onTap: () {
                        context.pop();
                      },
                      icon: Icons.close,
                    ),
                  ],
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp,
                  ),
                ),
                body,
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  width: double.infinity,
                  child: WassetButton(
                    text: buttonText,
                    onTap: dailogButtonFunc,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
