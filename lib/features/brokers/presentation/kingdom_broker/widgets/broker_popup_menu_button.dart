import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:waseet/common_widgets/broker_item_icon.dart';
import 'package:waseet/common_widgets/card_popup_menu_item.dart';
import 'package:waseet/common_widgets/wasset_text_field.dart';
import 'package:waseet/core/helpers/deep_link_helper.dart';
import 'package:waseet/features/brokers/presentation/kingdom_broker/cubit/kingdom_broker_cubit.dart';
import 'package:waseet/features/user/domain/entities/wasset_profile_entity.dart';
import 'package:waseet/res/res.dart';

class BrokerPopupMenuButton extends StatelessWidget {
  const BrokerPopupMenuButton({
    super.key,
    required this.broker,
  });
  final WassetProfileEntity broker;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KingdomBrokerCubit, KingdomBrokerState>(
      builder: (context, state) {
        return PopupMenuButton(
          color: Colors.white,
          elevation: 1,
          padding: EdgeInsets.zero,
          iconColor: AppColors.primaryColor,
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                //TODO : share
                onTap: () async {
                  DeepLinkHelper.instance.sharePersonalOffice(
                    broker.userId!,
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BrokerItemIcon(
                      onTap: () {
                        DeepLinkHelper.instance.sharePersonalOffice(
                          broker.userId!,
                        );
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
                dialogTitle: 'بلاغ عن وسيط ',
                buttonText: 'ارسال',
                dialogBody: WassetTextField(
                  maxLines: 3,
                  hintText: 'اكتب السبب هنا ',
                  onChanged: (description) {
                    context
                        .read<KingdomBrokerCubit>()
                        .setDescription(description);
                  },
                ),
                dailogButtonFunc: () {
                  context
                    ..read<KingdomBrokerCubit>()
                        .createComplaint(brokerId: broker.userId!)
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
