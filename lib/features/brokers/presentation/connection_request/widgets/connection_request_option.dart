import 'package:flutter/material.dart';
import 'package:waseet/common_widgets/broker_item_icon.dart';
import 'package:waseet/features/brokers/domain/entities/connection_request_entity.dart';
import 'package:waseet/features/brokers/presentation/connection_request/widgets/request_popup_menu_button.dart';
import 'package:waseet/features/brokers/presentation/my_connection_request/widgets/request_popup_menu_button.dart';

class ConnectionRequestOption extends StatelessWidget {
  const ConnectionRequestOption({
    super.key,
    required this.name,
    required this.number,
    this.image,
    required this.connectionRequest,
    required this.onFavTap,
    this.onCallTap,
  });
  final String name;
  final String number;
  final String? image;
  final ConnectionRequestEntity connectionRequest;
  final void Function(int) onFavTap;
  final Function? onCallTap;
  @override
  Widget build(BuildContext context) {
    if (onCallTap != null) {
      return Row(
        children: [
          BrokerItemIcon(
            icon: Icons.phone,
            onTap: () {
              if (onCallTap != null) {
                onCallTap!();
              }
            },
          ),
          BrokerItemIcon(
            icon: connectionRequest.isFav
                ? Icons.favorite
                : Icons.favorite_border,
            onTap: () {
              onFavTap(connectionRequest.id);
            },
          ),
          RequestPopupMenuButton(
            connectionRequest: connectionRequest,
          ),
        ],
      );
    }
    return MyRequestPopupMenuButton(
      connectionRequest: connectionRequest,
    );
  }
}
