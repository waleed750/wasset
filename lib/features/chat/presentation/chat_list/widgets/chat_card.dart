import 'package:flutter/material.dart';
import 'package:waseet/res/res.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({
    super.key,
    required this.onTap,
    required this.name,
    required this.message,
    required this.time,
    this.imageUrl,
  });
  final void Function() onTap;
  final String name;
  final String message;
  final String time;
  final String? imageUrl;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          trailing: Text(
            time,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xff4460F6),
            ),
          ),
          title: Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: AppColors.primaryColor,
            child: imageUrl != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.network(
                      imageUrl!,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  )
                : const Icon(
                    Icons.person,
                    size: 30,
                    color: Colors.white,
                  ),
          ),
          subtitle: Text(
            message.isNotEmpty
                ? message
                : time.isEmpty
                    ? 'لم يتم ارسال رسالة'
                    : 'لم يتم ارسال رسالة',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: AppColors.secondaryTextColor),
          ),
        ),
        const Divider(
          endIndent: 20,
          indent: 20,
          color: Color.fromARGB(52, 117, 117, 117),
        ),
      ],
    );
  }
}
