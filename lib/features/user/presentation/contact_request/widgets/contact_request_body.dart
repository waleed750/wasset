import 'package:flutter/material.dart';
import 'package:waseet/features/user/presentation/contact_request/cubit/cubit.dart';

/// {@template contact_request_body}
/// Body of the ContactRequestPage.
///
/// Add what it does
/// {@endtemplate}
class ContactRequestBody extends StatelessWidget {
  /// {@macro contact_request_body}
  const ContactRequestBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactRequestCubit, ContactRequestState>(
      builder: (context, state) {
        return Center(child: Text(state.customProperty));
      },
    );
  }
}
