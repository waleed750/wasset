import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:waseet/constants/constants.dart';
import 'package:waseet/features/user/domain/entities/notification_entity.dart';

class LoadedNotificationsItem extends StatelessWidget {
  const LoadedNotificationsItem({
    super.key,
    required this.notification,
  });
  final NotificationEntity notification;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding:
              const EdgeInsets.only(top: 25, left: 30, right: 20, bottom: 7).r,
          width: double.infinity,
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(blurRadius: 5, color: Color.fromARGB(69, 115, 50, 255)),
            ],
            borderRadius: BorderRadius.circular(15.5).r,
            color: Colors.white,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(5).r,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEAD6FF),
                      borderRadius: BorderRadius.circular(10).r,
                    ),
                    child: SvgPicture.asset(Constants.notificationItemIcon),
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          notification.title!,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          notification.body!,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.schedule_sharp,
                    color: const Color(
                      0xff999999,
                    ),
                    size: 15.sp,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    DateFormat('yyyy-MM-dd – hh:mm a').format(
                      DateTime.parse(
                        notification.createdAt!,
                      ),
                    ),
                    style: TextStyle(
                      color: const Color(
                        0xff999999,
                      ),
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 15.h,
        ),
      ],
    );
  }
}
