import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:waseet/common_widgets/card_popup_menu_item.dart';
import 'package:waseet/common_widgets/wasset_text_field.dart';
import 'package:waseet/features/brokers/domain/entities/connection_request_entity.dart';
import 'package:waseet/features/brokers/presentation/connection_request/cubit/connection_request_cubit.dart';
import 'package:waseet/res/res.dart';

class RequestPopupMenuButton extends StatelessWidget {
  const RequestPopupMenuButton({
    super.key,
    required this.connectionRequest,
  });
  final ConnectionRequestEntity connectionRequest;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectionRequestCubit, ConnectionRequestState>(
      builder: (context, state) {
        return PopupMenuButton(
          color: Colors.white,
          elevation: 1,
          iconColor: AppColors.primaryColor,
          itemBuilder: (context) {
            return [
              cardPopupMenuItem(
                icon: Icons.report,
                context: context,
                menuItemTitle: 'بلاغ ',
                dialogTitle: 'بلاغ عن طلب التواصل',
                buttonText: 'ارسال',
                dialogBody: WassetTextField(
                  onChanged: (value) {
                    context
                        .read<ConnectionRequestCubit>()
                        .setDescription(value);
                  },
                  maxLines: 3,
                ),
                dailogButtonFunc: () {
                  context.pop();
                  context
                      .read<ConnectionRequestCubit>()
                      .createComplaint(requestId: connectionRequest.id);
                },
              ),
            ];
          },
        );
      },
    );
  }
}
