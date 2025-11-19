import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:waseet/common_widgets/broker_item_icon.dart';
import 'package:waseet/common_widgets/card_popup_menu_item.dart';
import 'package:waseet/common_widgets/wasset_text_field.dart';
import 'package:waseet/core/helpers/deep_link_helper.dart';
import 'package:waseet/features/advertisement/domain/entities/ad_entity.dart';
import 'package:waseet/features/advertisement/presentation/advertisements/cubit/advertisements_cubit.dart';
import 'package:waseet/res/res.dart';

class AdvertisementPopupMenuButton extends StatelessWidget {
  const AdvertisementPopupMenuButton({
    super.key,
    required this.ad,
  });
  final AdEntity ad;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdvertisementsCubit, AdvertisementsState>(
      builder: (context, state) {
        return PopupMenuButton(
          color: Colors.white,
          elevation: 1,
          padding: const EdgeInsets.all(-10),
          iconColor: AppColors.primaryColor,
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                onTap: () async {
                  DeepLinkHelper.instance.shareAd(ad.id!);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BrokerItemIcon(
                      onTap: () {
                        DeepLinkHelper.instance.shareAd(ad.id!);
                      },
                      icon: Icons.share,
                    ),
                    const Text('مشاركة '),
                  ],
                ),
              ),
              cardPopupMenuItem(
                icon: Icons.report,
                context: context,
                menuItemTitle: 'بلاغ ',
                dialogTitle: 'بلاغ عن إعلان ',
                buttonText: 'ارسال',
                dialogBody: WassetTextField(
                  maxLines: 3,
                  hintText: 'اكتب السبب هنا ',
                  onChanged: (description) {
                    context
                        .read<AdvertisementsCubit>()
                        .setDescription(description);
                  },
                ),
                dailogButtonFunc: () {
                  context
                    ..read<AdvertisementsCubit>().createComplaint(adId: ad.id!)
                    ..pop();
                },
              ),
            ];
          },
        );
      },
    );
  }
}
