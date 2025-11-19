import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:waseet/app/bloc/app_bloc.dart';
import 'package:waseet/common_widgets/broker_item_icon.dart';
import 'package:waseet/features/brokers/presentation/kingdom_broker/cubit/kingdom_broker_cubit.dart';
import 'package:waseet/features/brokers/presentation/kingdom_broker/widgets/broker_popup_menu_button.dart';
import 'package:waseet/features/user/domain/entities/wasset_profile_entity.dart';
import 'package:waseet/res/enums/broker_type.dart';
import 'package:waseet/res/helper_method.dart';
import 'package:waseet/res/res.dart';
import 'package:waseet/router/screens.dart';

class BrokerCard extends StatelessWidget {
  const BrokerCard({
    super.key,
    required this.broker,
  });
  final WassetProfileEntity broker;

  @override
  Widget build(BuildContext context) {
    final width = (MediaQuery.sizeOf(context).width - 60).w;

    return Stack(
      children: [
        InkWell(
          onTap: () {
            context.pushNamed(
              Screens.myPersonalOffice.name,
              extra: {
                'brokerId': broker.userId,
              },
            );
          },
          child: Container(
            margin: const EdgeInsets.only(top: 15, left: 15, right: 15).r,
            width: double.infinity,
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              bottom: 10,
            ).r,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(101, 115, 50, 255),
                  blurRadius: 4,
                  offset: Offset(0, 1.68),
                ),
              ],
              border: const Border(),
              borderRadius: BorderRadius.circular(16).r,
              color: Colors.white,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    BrokerItemIcon(
                      onTap: () {
                        HelperMethod.createChatRoom(broker.userId!, context);
                      },
                      icon: Icons.message,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    BrokerItemIcon(
                      onTap: () {
                        final isAuth = context.read<AppBloc>().state.status ==
                            AppStatus.authenticated;
                        broker.isFav == true
                            ? context
                                .read<KingdomBrokerCubit>()
                                .removeFavBrokers(broker.userId!)
                            : !isAuth
                                ? context.pushNamed(Screens.login.name)
                                : context
                                    .read<KingdomBrokerCubit>()
                                    .addFavBrokers(broker.userId!);
                      },
                      icon: broker.isFav == true
                          ? Icons.favorite
                          : Icons.favorite_border,
                    ),
                    BrokerPopupMenuButton(
                      broker: broker,
                    ),
                  ],
                ),
                // SizedBox(
                //   height: 4.h,
                // ),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.primaryColor,
                      radius: 25.r,
                      backgroundImage: broker.profileImage == null
                          ? null
                          : NetworkImage(broker.profileImage!),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FittedBox(
                            child: Row(
                              children: [
                                Text(
                                  broker.name!,
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 15.sp,
                                ),
                                SizedBox(
                                  width: 30.w,
                                ),
                                Text(
                                  'نوعه : ',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  broker.officeType == null
                                      ? 'غير محدد '
                                      : (broker.officeType ==
                                              BrokerType.office.name
                                          ? BrokerType.office.arabicName
                                          : BrokerType.wasset.arabicName),
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          FittedBox(
                            child: Row(
                              children: [
                                Text(
                                  'التقييم : ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13.sp,
                                  ),
                                ),
                                Text(
                                  broker.averageRating == null
                                      ? 'غير محدد'
                                      : broker.averageRating! <= 1.6
                                          ? 'سيئ'
                                          : broker.averageRating! <= 3.4
                                              ? 'متوسط'
                                              : 'ممتاز',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                  ),
                                ),
                                SizedBox(
                                  width: 30.w,
                                ),
                                Text(
                                  'تخصص الوسيط : ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13.sp,
                                  ),
                                ),
                                Text(
                                  broker.wassetSpecialization != null &&
                                          broker
                                              .wassetSpecialization!.isNotEmpty
                                      ? broker.wassetSpecialization![0].name!
                                      : 'لم يتم تحديد',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                  ],
                ),
                Wrap(
                  children: List.generate(
                    broker.wassetSpecialization != null &&
                            broker.wassetSpecialization!.isNotEmpty
                        ? broker.wassetSpecialization!.length
                        : 0,
                    (index) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 3.5,
                      ).r,
                      margin: const EdgeInsets.all(5).r,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8).r,
                        color: const Color.fromARGB(255, 240, 244, 255),
                      ),
                      child: Text(
                        broker.wassetSpecialization![index].name!,
                        style: TextStyle(
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Positioned(
        //   left: 0,
        //   top: 10,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.end,
        //     children: [
        //       BrokerItemIcon(
        //         onTap: () {
        //           HelperMethod.createChatRoom(broker.userId!, context);
        //         },
        //         icon: Icons.message,
        //       ),
        //       SizedBox(
        //         width: 5.w,
        //       ),
        //       BrokerItemIcon(
        //         onTap: () {
        //           final isAuth = context.read<AppBloc>().state.status ==
        //               AppStatus.authenticated;
        //           broker.isFav == true
        //               ? context
        //                   .read<KingdomBrokerCubit>()
        //                   .removeFavBrokers(broker.userId!)
        //               : !isAuth
        //                   ? context.pushNamed(Screens.login.name)
        //                   : context
        //                       .read<KingdomBrokerCubit>()
        //                       .addFavBrokers(broker.userId!);
        //         },
        //         icon: broker.isFav == true
        //             ? Icons.favorite
        //             : Icons.favorite_border,
        //       ),
        //       BrokerPopupMenuButton(
        //         broker: broker,
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
