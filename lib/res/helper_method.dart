import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:waseet/features/brokers/domain/repositories/communication_repository.dart';
import 'package:waseet/features/brokers/presentation/update_connection_request/cubit/cubit.dart';
import 'package:waseet/router/screens.dart';

class HelperMethod {
  static OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(
      color: Color(0xFFC4C4C4),
    ),
  );

  static void showSnackBar(
    BuildContext context,
    String message, {
    SnackBarType type = SnackBarType.info,
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: TextStyle(color: type.textColor),
          ),
          backgroundColor: type.color,
          action: SnackBarAction(
            label: 'اغلاق',
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
          // behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          duration: const Duration(seconds: 3),
          elevation: 5,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10).r,
        ),
      );
  }

  static Future<void> openWhatsapp(String phoneNumber) async {
    final uri =
        Uri.parse("https://wa.me/966${phoneNumber.replaceFirst('0', '')}");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      // showSnackBar(context, message)
    }
  }

  static Future<void> openCall(String phoneNumber) async {
    final uri = Uri.parse('tel:$phoneNumber');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      // showSnackBar(context, message)
    }
  }

  static Future<void> createChatRoom(
    int userId,
    BuildContext context,
  ) async {
    showSnackBar(context, 'جاري انشاء غرفة دردشة');
    final chat =
        await context.read<CommunicationRepository>().acceptRequest(userId);
    if (chat.data?.chat == null) {
      showSnackBar(
        context,
        'حدث خطأ اثناء انشاء الغرفة',
        type: SnackBarType.error,
      );
      return;
    }
    showSnackBar(context, 'تم انشاء غرفة دردشة');
    context.pushNamed(
      Screens.chat.name,
      pathParameters: {
        'chatId': chat.data!.chat.id!,
        'chatType': 'p2p',
      },
      queryParameters: {
        'name': chat.data!.chat.user?.name,
      },
    );
  }

  static void contactUs(BuildContext context) {
    openWhatsapp('966500000000');
  }
}

enum SnackBarType { error, success, warning, info }

extension SnackBarTypeX on SnackBarType {
  Color get color {
    switch (this) {
      case SnackBarType.error:
        return Colors.red;
      case SnackBarType.success:
        return Colors.green;
      case SnackBarType.warning:
        return Colors.orange;
      case SnackBarType.info:
        return Colors.blue;
    }
  }

  Color get textColor {
    switch (this) {
      case SnackBarType.error:
        return Colors.white;
      case SnackBarType.success:
        return Colors.white;
      case SnackBarType.warning:
        return Colors.white;
      case SnackBarType.info:
        return Colors.white;
    }
  }

  IconData get icon {
    switch (this) {
      case SnackBarType.error:
        return Icons.error;
      case SnackBarType.success:
        return Icons.check;
      case SnackBarType.warning:
        return Icons.warning;
      case SnackBarType.info:
        return Icons.info;
    }
  }
}
