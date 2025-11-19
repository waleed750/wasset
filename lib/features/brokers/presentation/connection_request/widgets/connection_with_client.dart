import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:waseet/constants/constants.dart';
import 'package:waseet/features/brokers/domain/entities/connection_request_entity.dart';
import 'package:waseet/features/brokers/presentation/connection_request/connection_request.dart';
import 'package:waseet/res/assets/assets.gen.dart';
import 'package:waseet/res/helper_method.dart';

class ConnectionWithClient extends StatelessWidget {
  const ConnectionWithClient({
    super.key,
    required this.name,
    required this.number,
    this.image,
    this.isActive = false,
    required this.connectionRequest,
  });

  final String name;
  final String number;
  final String? image;
  final ConnectionRequestEntity connectionRequest;
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          10,
        ).r,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
        ).r,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Align(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 15.h,
                            ),
                            Text(
                              'تواصل مع العميل',
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ).r,
                          height: 25.h,
                          width: 25.w,
                          padding: const EdgeInsets.all(5).r,
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(5).r,
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: SvgPicture.asset(
                              Assets.icons.vector.path,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20).r,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 25.r,
                        backgroundImage:
                            image != null ? NetworkImage(image!) : null,
                      ),
                      if (isActive)
                        Positioned(
                          top: 10,
                          child: SizedBox(
                            width: 8.w,
                            height: 8.h,
                            child: SvgPicture.asset(
                              Assets.icons.ellipse.path,
                            ),
                          ),
                        )
                      else
                        const SizedBox.shrink(),
                    ],
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              children: [
                const Spacer(),
                if (connectionRequest.showChatOption) ...[
                  ContactMethod(
                    assetName: Assets.icons.contactWithUs.path,
                    // todo: add connection with client via in app chat
                    onTap: () {
                      context.read<ConnectionRequestCubit>().addChatRequest(
                            connectionRequest.createdBy.userId!,
                          );
                    },
                  ),
                ],
                if (number.isNotEmpty) ...[
                  if (connectionRequest.showCallOption) ...[
                    SizedBox(
                      width: 14.w,
                    ),
                    ContactMethod(
                      assetName: Assets.icons.phoneFlip.path,
                      onTap: () {
                        HelperMethod.openCall(number);
                      },
                    ),
                  ],
                  if (connectionRequest.showWhatsappOption) ...[
                    SizedBox(
                      width: 14.w,
                    ),
                    ContactMethod(
                      assetName: Assets.icons.whatsapp.path,
                      onTap: () {
                        HelperMethod.openWhatsapp(number);
                      },
                    ),
                  ],
                ],
                const Spacer(),
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
          ],
        ),
      ),
    );
  }
}

class ContactMethod extends StatelessWidget {
  const ContactMethod({
    super.key,
    this.onTap,
    required this.assetName,
  });
  final void Function()? onTap;
  final String assetName;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            const Radius.circular(8).r,
          ),
          color: Constants.secondaryColor.withOpacity(0.2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(
            8,
          ).r,
          child: SvgPicture.asset(assetName),
        ),
      ),
    );
  }
}
