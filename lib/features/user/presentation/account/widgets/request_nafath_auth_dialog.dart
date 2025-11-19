// ignore_for_file: public_member_api_docs, sort_ructors_first

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waseet/app/bloc/app_bloc.dart';
import 'package:waseet/features/brokers/presentation/update_connection_request/cubit/cubit.dart';
import 'package:waseet/features/user/presentation/register/widgets/wasset_button.dart';

class RequestNafathAuthDialog extends StatefulWidget {
  const RequestNafathAuthDialog({
    super.key,
    required this.onDone,
  });
  final void Function(String nationalId) onDone;

  @override
  State<RequestNafathAuthDialog> createState() =>
      _RequestNafathAuthDialogState();
}

class _RequestNafathAuthDialogState extends State<RequestNafathAuthDialog> {
  final TextEditingController _nationalIdController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20).r,
      margin: const EdgeInsets.symmetric(horizontal: 20).r,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            'سوف يتم إرسال رمز التحقق إلى رقم الهوية الوطنية الخاص بك المسجل لدينا (${context.read<AppBloc>().state.user?.profile?.identityNumber})',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          // const SizedBox(
          //   height: 20,
          // ),
          // WassetTextField(
          //   controller: _nationalIdController,
          //   hintText: 'رقم الهوية الوطنية',
          //   keyboardType: TextInputType.number,
          // ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.infinity,
            child: WassetButton(
              text: 'تأكيد',
              onTap: () {
                widget.onDone(_nationalIdController.text);
                Navigator.pop(context);
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
