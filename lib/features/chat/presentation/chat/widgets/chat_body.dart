import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:waseet/app/bloc/app_bloc.dart';
import 'package:waseet/features/chat/domain/entities/request/add_message_request.dart';
import 'package:waseet/features/chat/presentation/chat/bloc/bloc.dart';
import 'package:waseet/res/helper_method.dart';
import 'package:waseet/res/res.dart';

/// {@template chat_body}
/// Body of the ChatPage.
///
/// Add what it does
/// {@endtemplate}
class ChatBody extends StatefulWidget {
  /// {@macro chat_body}
  const ChatBody({super.key});

  @override
  State<ChatBody> createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        return SafeArea(
          bottom: false,
          child: Column(
            children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      size: 18,
                    ),
                    onPressed: () {
                      context.pop();
                    },
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircleAvatar(
                        backgroundColor: AppColors.primaryColor,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        child: Text(
                          state.name ?? '',
                          textDirection: TextDirection.ltr,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: ListView.builder(
                    reverse: true,
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      final isMe = state.messages[index].userId ==
                          context
                              .read<AppBloc>()
                              .state
                              .user!
                              .profile
                              ?.userId
                              .toString();
                      final isTahalfChat = state.chatType == 'tahalf';
                      final message = state.messages[index];

                      return Row(
                        mainAxisAlignment: isMe
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(76, 115, 50, 255),
                              borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(8).r,
                                topRight: const Radius.circular(8).r,
                                bottomRight: isMe
                                    ? const Radius.circular(0).r
                                    : const Radius.circular(8).r,
                                bottomLeft: isMe
                                    ? const Radius.circular(8).r
                                    : const Radius.circular(0).r,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: isMe
                                  ? CrossAxisAlignment.start
                                  : CrossAxisAlignment.end,
                              children: [
                                if (isTahalfChat)
                                  Text(
                                    message.sender?.name.toString() ?? '',
                                    textDirection: TextDirection.ltr,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                Text(
                                  message.message ?? '',
                                  textDirection: TextDirection.ltr,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // const CircleAvatar(
                          //   backgroundColor: AppColors.primaryColor,
                          // ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              DecoratedBox(
                // padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: SafeArea(
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _messageController,
                          decoration: const InputDecoration(
                            hintText: 'أكتب رسالة',
                            hintStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFCFD2D4),
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.send,
                          color: AppColors.primaryColor,
                        ),
                        onPressed: () {
                          if (_messageController.text.isNotEmpty) {
                            context.read<ChatBloc>().add(
                                  SendMessageEvent(
                                    AddMessageRequest(
                                      message: _messageController.text,
                                      userId: context
                                          .read<AppBloc>()
                                          .state
                                          .user!
                                          .profile
                                          ?.userId
                                          .toString(),
                                      createdAt: DateTime.now(),
                                      type: 'text',
                                      chatId: state.chat.id,
                                    ),
                                  ),
                                );
                            _messageController.clear();
                            return;
                          }
                          HelperMethod.showSnackBar(
                            context,
                            'الرجاء كتابة رسالة',
                            type: SnackBarType.error,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
