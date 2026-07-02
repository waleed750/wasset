import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waseet/common_widgets/wasset_text_field.dart';
import 'package:waseet/features/user/presentation/register/widgets/wasset_button.dart';
import 'package:waseet/res/res.dart';

class ClientInfoSection extends StatefulWidget {
  const ClientInfoSection({
    required this.onSubmit,
    super.key,
  });

  final Future<String?> Function(String customerName, String customerPhone)
      onSubmit;

  @override
  State<ClientInfoSection> createState() => _ClientInfoSectionState();
}

class _ClientInfoSectionState extends State<ClientInfoSection> {
  final _customerNameController = TextEditingController();
  final _customerPhoneController = TextEditingController();

  String? _customerNameError;
  String? _customerPhoneError;
  String? _submissionError;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _customerNameController.addListener(_handleCustomerNameChanged);
    _customerPhoneController.addListener(_handleCustomerPhoneChanged);
  }

  @override
  void dispose() {
    _customerNameController.dispose();
    _customerPhoneController.dispose();
    super.dispose();
  }

  void _handleCustomerNameChanged() {
    if (_customerNameError == null && _submissionError == null) return;
    setState(() {
      _customerNameError = null;
      _submissionError = null;
    });
  }

  void _handleCustomerPhoneChanged() {
    if (_customerPhoneError == null && _submissionError == null) return;
    setState(() {
      _customerPhoneError = null;
      _submissionError = null;
    });
  }

  Future<void> _submit() async {
    final customerName = _customerNameController.text.trim();
    final customerPhone = _customerPhoneController.text.trim();

    setState(() {
      _customerNameError = customerName.isEmpty ? 'اسم العميل مطلوب' : null;
      _customerPhoneError =
          customerPhone.isEmpty ? 'رقم جوال العميل مطلوب' : null;
      _submissionError = null;
    });

    if (_customerNameError != null || _customerPhoneError != null) return;

    setState(() => _isSubmitting = true);
    final error = await widget.onSubmit(customerName, customerPhone);
    if (!mounted) return;

    if (error == null) {
      Navigator.of(context).pop(true);
      return;
    }

    setState(() {
      _isSubmitting = false;
      _submissionError = error;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          16.w,
          12.h,
          16.w,
          16.h + MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                width: 44.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(99).r,
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                const Icon(
                  Icons.contact_phone_outlined,
                  color: AppColors.primaryColor,
                ),
                SizedBox(width: 8.w),
                Text(
                  'إضافة عميل محتمل',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            WassetTextField(
              title: 'اسم العميل',
              hintText: 'أدخل اسم العميل',
              controller: _customerNameController,
              keyboardType: TextInputType.name,
              enabled: !_isSubmitting,
              errorText: _customerNameError,
              prefixIcon: const Icon(Icons.person_outline),
            ),
            SizedBox(height: 16.h),
            WassetTextField(
              title: 'رقم جوال العميل',
              hintText: 'أدخل رقم جوال العميل',
              controller: _customerPhoneController,
              keyboardType: TextInputType.phone,
              enabled: !_isSubmitting,
              errorText: _customerPhoneError,
              prefixIcon: const Icon(Icons.phone_outlined),
            ),
            if (_submissionError != null) ...[
              SizedBox(height: 12.h),
              Text(
                _submissionError!,
                style: TextStyle(color: Colors.red, fontSize: 13.sp),
              ),
            ],
            SizedBox(height: 20.h),
            SizedBox(
              width: double.infinity,
              child: WassetButton(
                text: 'إضافة العميل',
                isLoading: _isSubmitting,
                onTap: _submit,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
