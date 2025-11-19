import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:waseet/constants/constants.dart';
import 'package:waseet/features/brokers/domain/entities/golden_brokers_entity.dart';
import 'package:waseet/res/assets/assets.gen.dart';
import 'package:waseet/res/helper_method.dart';
import 'package:waseet/router/screens.dart';

class GoldenUserItem extends StatelessWidget {
  const GoldenUserItem({
    super.key,
    required this.list,
  });
  final List<GoldenBrokersEntity> list;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 500,
      child: ListView.builder(
        padding: const EdgeInsets.only(
          left: 24,
          right: 24,
          top: 8,
        ).r,
        itemCount: list.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final goldenBroker = list[index];
          return Column(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Constants.secondaryColor.withOpacity(0.1),
                      blurRadius: 4,
                      spreadRadius: 7,
                      offset: const Offset(2, 3),
                    ),
                  ],
                  borderRadius: const BorderRadius.all(
                    Radius.circular(
                      20,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 36,
                        top: 25,
                        bottom: 20,
                      ).r,
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 30.r,
                            backgroundImage: goldenBroker.photo.isNotEmpty
                                ? NetworkImage(
                                    goldenBroker.photo,
                                  )
                                : null,
                            child: goldenBroker.photo.isEmpty
                                ? Icon(
                                    Icons.person,
                                    size: 30.sp,
                                  )
                                : null,
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: SizedBox(
                              child: Assets.icons.star.svg(
                                width: 16.w,
                                height: 16.h,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '  ${list[index].name}',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(
                      flex: 5,
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          const Radius.circular(
                            8,
                          ).r,
                        ),
                        color: Constants.secondaryColor.withOpacity(0.2),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8).r,
                        child: InkWell(
                          onTap: () {
                            context.pushNamed(
                              Screens.myPersonalOffice.name,
                              extra: {
                                'brokerId': int.parse(
                                  goldenBroker.customerId,
                                ),
                              },
                            );
                          },
                          child: SvgPicture.asset(
                            Assets.icons.user.path,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          const Radius.circular(
                            8,
                          ).r,
                        ),
                        color: Constants.secondaryColor.withOpacity(0.2),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5).r,
                        child: InkWell(
                          onTap: () {
                            HelperMethod.createChatRoom(
                              int.parse(
                                goldenBroker.customerId,
                              ),
                              context,
                            );
                          },
                          child: SvgPicture.asset(
                            Assets.icons.contactWithUs.path,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
