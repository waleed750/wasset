import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:waseet/common_widgets/broker_item_icon.dart';
import 'package:waseet/common_widgets/card_popup_menu_item.dart';
import 'package:waseet/features/brokers/domain/entities/connection_request_entity.dart';
import 'package:waseet/features/brokers/presentation/my_connection_request/cubit/my_connection_request_cubit.dart';
import 'package:waseet/res/res.dart';
import 'package:waseet/router/screens.dart';

class MyRequestPopupMenuButton extends StatelessWidget {
  const MyRequestPopupMenuButton({
    super.key,
    required this.connectionRequest,
  });
  final ConnectionRequestEntity connectionRequest;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyConnectionRequestCubit, MyConnectionRequestState>(
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
                  final m = context.read<MyConnectionRequestCubit>();
                  await context.pushNamed(
                    Screens.updateConnectionRequest.name,
                    extra: connectionRequest,
                  );
                  m.update();
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
                dialogTitle: 'هل أنت متأكد من حذف الطلب ؟ ',
                buttonText: 'حذف',
                dailogButtonFunc: () {
                  context.pop();
                  context
                      .read<MyConnectionRequestCubit>()
                      .deleteRequest(connectionRequest.id);
                },
              ),
            ];
          },
        );
      },
    );
  }
}
