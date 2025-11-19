import 'package:flutter/material.dart';
import 'package:waseet/app/bloc/app_bloc.dart';
import 'package:waseet/features/user/domain/repositories/complaints_repository.dart';
import 'package:waseet/features/user/presentation/complaint/cubit/complaint_cubit.dart';
import 'package:waseet/features/user/presentation/complaint/widgets/complaint_body.dart';
import 'package:waseet/features/user/presentation/contact_request/cubit/cubit.dart';

class ComplaintPage extends StatelessWidget {
  const ComplaintPage({super.key});
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const ComplaintPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ComplaintCubit(
        userId: context.read<AppBloc>().state.user!.id,
        complaintRepository: context.read<ComplaintRepository>(),
      ),
      child: const Scaffold(
        body: ComplaintView(),
      ),
    );
  }
}

class ComplaintView extends StatelessWidget {
  const ComplaintView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComplaintViewBody();
  }
}
