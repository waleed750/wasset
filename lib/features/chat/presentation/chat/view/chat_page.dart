import 'package:flutter/material.dart';
import 'package:waseet/features/chat/domain/repositories/chat_repository.dart';
import 'package:waseet/features/chat/presentation/chat/bloc/bloc.dart';
import 'package:waseet/features/chat/presentation/chat/widgets/chat_body.dart';

/// {@template chat_page}
/// A description for ChatPage
/// {@endtemplate}
class ChatPage extends StatelessWidget {
  /// {@macro chat_page}
  const ChatPage({super.key, required this.chatId, this.chatType, this.name});

  final String chatId;
  final String? chatType;
  final String? name;

  /// The static route for ChatPage
  static Route<dynamic> route(String chatId) {
    return MaterialPageRoute<dynamic>(
      builder: (_) => ChatPage(
        chatId: chatId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatBloc(
        chatRepository: context.read<ChatRepository>(),
        chatId: chatId,
        chatType: chatType,
        name: name,
      ),
      child: const Scaffold(
        body: ChatView(),
      ),
    );
  }
}

/// {@template chat_view}
/// Displays the Body of ChatView
/// {@endtemplate}
class ChatView extends StatelessWidget {
  /// {@macro chat_view}
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ChatBody();
  }
}
