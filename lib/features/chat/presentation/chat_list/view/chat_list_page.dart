import 'package:flutter/material.dart';
import 'package:waseet/app/bloc/app_bloc.dart';
import 'package:waseet/features/chat/domain/repositories/chat_repository.dart';
import 'package:waseet/features/chat/presentation/chat_list/bloc/bloc.dart';
import 'package:waseet/features/chat/presentation/chat_list/widgets/chat_list_body.dart';
import 'package:waseet/features/user/domain/repositories/authentication_repository.dart';

/// {@template chat_list_page}
/// A description for ChatListPage
/// {@endtemplate}
class ChatListPage extends StatelessWidget {
  /// {@macro chat_list_page}
  const ChatListPage({super.key});

  /// The static route for ChatListPage
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const ChatListPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatListBloc(
        chatRepository: context.read<ChatRepository>(),
        authenticationRepository: context.read<AuthenticationRepository>(),
        myId: context.read<AppBloc>().state.user!.id,
      ),
      child: const Scaffold(
        body: ChatListView(),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {

        //   },
        //   child: const Icon(Icons.add),
        // )
      ),
    );
  } 
}

/// {@template chat_list_view}
/// Displays the Body of ChatListView
/// {@endtemplate}
class ChatListView extends StatelessWidget {
  /// {@macro chat_list_view}
  const ChatListView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ChatListBody();
  }
}
