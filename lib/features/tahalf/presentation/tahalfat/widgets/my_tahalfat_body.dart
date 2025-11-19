// ignore_for_file: inference_failure_on_instance_creation

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:waseet/common_widgets/broker_item_icon.dart';
import 'package:waseet/common_widgets/card_popup_menu_item.dart';
import 'package:waseet/common_widgets/error.dart';
import 'package:waseet/features/tahalf/domain/entities/tahalf_entity.dart';
import 'package:waseet/features/tahalf/presentation/tahalfat/cubit/tahalfat_cubit.dart';
import 'package:waseet/features/tahalf/presentation/tahalfat/widgets/my_tahalf_card.dart';
import 'package:waseet/features/tahalf/presentation/tahalfat/widgets/no_tahalfat.dart';
import 'package:waseet/features/tahalf/presentation/tahalfat/widgets/tahalfat_skeleton.dart';
import 'package:waseet/features/user/presentation/profile_info/profile_info.dart';
import 'package:waseet/res/enums/tahalf_type.dart';
import 'package:waseet/res/res.dart';
import 'package:waseet/router/screens.dart';

class MyTahalfatBody extends StatelessWidget {
  const MyTahalfatBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TahalfatCubit, TahalfatState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              if (state.status == TahalfatStatus.loading)
                const TahalfatSkeleton(),
              if (state.status == TahalfatStatus.error)
                ErrorPage(
                  onTap: () {
                    context.read<TahalfatCubit>().init();
                  },
                ),
              if (state.status == TahalfatStatus.loaded &&
                  state.myTahalfList.isEmpty)
                const NoTahalfat(),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.myTahalfList.length,
                itemBuilder: (context, index) {
                  final tahalf = state.myTahalfList[index];
                  final int limit;
                  if (tahalf.allianceType == TahalfType.public.name) {
                    limit = 50;
                  } else {
                    limit = 5;
                  }
                  return Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ).r,
                        padding: const EdgeInsets.all(15).r,
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(101, 115, 50, 255),
                              blurRadius: 4,
                              offset: Offset(0, 1.68),
                            ),
                          ],
                          border: Border(
                            right: BorderSide(
                              width: 20.w,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          borderRadius: BorderRadius.circular(16).r,
                          color: Colors.white,
                        ),
                        width: double.infinity,
                        child: MyTahalfCard(tahalf: tahalf, limit: limit),
                      ),
                      Positioned(
                        top: 10,
                        left: 10,
                        child: Row(
                          children: [
                            BrokerItemIcon(
                              onTap: () {
                                if (tahalf.chatRoomId != null) {
                                  context.pushNamed(
                                    Screens.chat.name,
                                    pathParameters: {
                                      'chatId': tahalf.chatRoomId ?? '',
                                      'chatType': 'tahalf',
                                    },
                                    queryParameters: {
                                      'name': tahalf.name,
                                    },
                                  );
                                }
                              },
                              icon: Icons.message,
                            ),
                            CustomPopupMenuButton(
                              tahalf: tahalf,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class CustomPopupMenuButton extends StatelessWidget {
  const CustomPopupMenuButton({
    super.key,
    required this.tahalf,
  });
  final TahalfEntity tahalf;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TahalfatCubit, TahalfatState>(
      builder: (context, state) {
        return PopupMenuButton(
          color: Colors.white,
          padding: EdgeInsets.zero,
          //   iconColor: AppColors.primaryColor,
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                onTap: () async {
                  final m = context.read<TahalfatCubit>();
                  await context.pushNamed(
                    Screens.updateTahalf.name,
                    extra: tahalf,
                  );
                  m.updateScreen();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BrokerItemIcon(
                      onTap: () {},
                      icon: Icons.edit,
                    ),
                    const Text('تعديل '),
                  ],
                ),
              ),
              cardPopupMenuItem(
                icon: Icons.delete,
                context: context,
                menuItemTitle: 'حذف ',
                dialogTitle: 'هل أنت متأكد من حذف التحالف ؟ ',
                buttonText: 'حذف',
                dailogButtonFunc: () {
                  context.pop();
                  context.read<TahalfatCubit>().deleteTahalf(tahalf.id!);
                },
              ),
            ];
          },
        );
      },
    );
  }
}
