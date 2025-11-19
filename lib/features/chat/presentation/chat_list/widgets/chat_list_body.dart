import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:waseet/features/advertisement/presentation/add_new_ad/cubit/cubit.dart';
import 'package:waseet/features/chat/presentation/chat_list/bloc/chat_list_bloc.dart';
import 'package:waseet/features/chat/presentation/chat_list/widgets/chat_card.dart';
import 'package:waseet/router/screens.dart';

/// {@template chat_body}
/// Body of the ChatPage.
///
/// Add what it does
/// {@endtemplate}
class ChatListBody extends StatelessWidget {
  /// {@macro chat_body}
  const ChatListBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatListBloc, ChatListState>(
      builder: (context, state) {
        if (state is ChatListInitial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ChatListLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ChatListError) {
          return Center(
            child: Text(state.message),
          );
        }
        if (state is ChatListLoaded) {
          if (state.chats.isEmpty) {
            return const Center(
              child: Text('لا توجد محادثات'),
            );
          }
          return SafeArea(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'المحادثات',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: List.generate(
                        state.chats.length,
                        (index) => ChatCard(
                          name: state.chats[index].user?.name ?? '',
                          message:
                              state.chats[index].lastMessage?.message ?? '',
                          time: state.chats[index].lastMessageDate != null
                              ? state.chats[index].lastMessageDate != null &&
                                      state.chats[index].lastMessageDate?.day ==
                                          DateTime.now().day &&
                                      state.chats[index].lastMessageDate
                                              ?.month ==
                                          DateTime.now().month &&
                                      state.chats[index].lastMessageDate
                                              ?.year ==
                                          DateTime.now().year
                                  ? DateFormat('hh:mm a').format(
                                      state.chats[index].lastMessageDate!,
                                    )
                                  : DateFormat('dd/MM/yyyy').format(
                                      state.chats[index].lastMessageDate!,
                                    )
                              : '',
                          onTap: () {
                            context.pushNamed(
                              Screens.chat.name,
                              pathParameters: {
                                'chatId': state.chats[index].id.toString(),
                                'chatType': 'p2p',
                              },
                              queryParameters: {
                                'name': state.chats[index].user?.name ?? '',
                              },
                            );
                          },
                          imageUrl: state.chats[index].user?.profileImage,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
