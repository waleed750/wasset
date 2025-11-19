import 'package:flutter/material.dart';
import 'package:waseet/app/bloc/app_bloc.dart';
import 'package:waseet/features/user/domain/repositories/authentication_repository.dart';
import 'package:waseet/features/user/presentation/contact_request/cubit/cubit.dart';
import 'package:waseet/features/user/presentation/contact_request/widgets/contact_request_body.dart';

/// {@template contact_request_page}
/// A description for ContactRequestPage
/// {@endtemplate}
class ContactRequestPage extends StatelessWidget {
  /// {@macro contact_request_page}
  const ContactRequestPage({super.key});

  /// The static route for ContactRequestPage
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
        builder: (_) => const ContactRequestPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactRequestCubit(),
      child: const Scaffold(
        body: ContactRequestView(),
      ),
    );
  }
}

/// {@template contact_request_view}
/// Displays the Body of ContactRequestView
/// {@endtemplate}
class ContactRequestView extends StatelessWidget {
  /// {@macro contact_request_view}
  const ContactRequestView({super.key});

  @override
  Widget build(BuildContext context) {
    return ContactRequestBody();
  }
}
