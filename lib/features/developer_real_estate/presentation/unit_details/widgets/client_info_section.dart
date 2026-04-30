// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:waseet/common_widgets/wasset_text_field.dart';
// import 'package:waseet/features/user/presentation/register/widgets/wasset_button.dart';
// import 'package:waseet/res/res.dart';

// class ClientInfoSection extends StatefulWidget {
//   const ClientInfoSection({
//     super.key,
//     this.onClientAdded,
//   });

//   final void Function(String clientName, String clientPhone)? onClientAdded;

//   @override
//   State<ClientInfoSection> createState() => _ClientInfoSectionState();
// }

// class _ClientInfoSectionState extends State<ClientInfoSection> {
//   final TextEditingController _clientNameController = TextEditingController();
//   final TextEditingController _clientPhoneController = TextEditingController();
//   String? _clientNameError;
//   String? _clientPhoneError;
//   bool _isSubmitting = false;

//   @override
//   void dispose() {
//     _clientNameController.dispose();
//     _clientPhoneController.dispose();
//     super.dispose();
//   }

//   bool _validateFields() {
//     bool isValid = true;
//     setState(() {
//       _clientNameError = null;
//       _clientPhoneError = null;
//     });

//     final clientName = _clientNameController.text.trim();
//     final clientPhone = _clientPhoneController.text.trim();

//     // Validate client name
//     if (clientName.isEmpty) {
//       setState(() {
//         _clientNameError = 'اسم العميل مطلوب';
//       });
//       isValid = false;
//     } else if (clientName.length < 3) {
//       setState(() {
//         _clientNameError = 'اسم العميل يجب أن يكون 3 أحرف على الأقل';
//       });
//       isValid = false;
//     }

//     // Validate client phone
//     if (clientPhone.isEmpty) {
//       setState(() {
//         _clientPhoneError = 'رقم الجوال مطلوب';
//       });
//       isValid = false;
//     } else if (!_isValidSaudiPhoneNumber(clientPhone)) {
//       setState(() {
//         _clientPhoneError = 'رقم الجوال غير صحيح (يجب أن يبدأ برقم 5 وتسعة أرقام)';
//       });
//       isValid = false;
//     }

//     return isValid;
//   }

//   bool _isValidSaudiPhoneNumber(String phone) {
//     // Remove all non-digit characters
//     final cleaned = phone.replaceAll(RegExp(r'\D'), '');
    
//     // Saudi mobile number: starts with 5 and exactly 9 digits total
//     final regex = RegExp(r'^5[0-9]{8}$');
//     return regex.hasMatch(cleaned);
//   }

//   void _submitClientInfo() {
//     if (!_validateFields()) {
//       return;
//     }

//     setState(() {
//       _isSubmitting = true;
//     });

//     // Simulate submission delay
//     Future.delayed(const Duration(milliseconds: 500), () {
//       if (!mounted) return;

//       final clientName = _clientNameController.text.trim();
//       final clientPhone = _clientPhoneController.text.trim();

//       // Call callback if provided
//       widget.onClientAdded?.call(clientName, clientPhone);

//       // Show success feedback
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             'تم إضافة العميل "$clientName" بنجاح ✓',
//             style: TextStyle(
//               fontSize: 14.sp,
//               color: Colors.white,
//             ),
//           ),
//           backgroundColor: Colors.green.shade600,
//           duration: const Duration(seconds: 2),
//           behavior: SnackBarBehavior.floating,
//           margin: EdgeInsets.all(16.r),
//         ),
//       );

//       // Clear fields after successful submission
//       _clientNameController.clear();
//       _clientPhoneController.clear();

//       setState(() {
//         _isSubmitting = false;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(12.r),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10).r,
//         border: Border.all(
//           color: AppColors.primaryColor.withOpacity(0.2),
//         ),
//         color: AppColors.primaryColor.withOpacity(0.04),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Section Title
//           Text(
//             'بيانات العميل',
//             style: TextStyle(
//               fontSize: 16.sp,
//               fontWeight: FontWeight.bold,
//               color: AppColors.primaryColor,
//             ),
//           ),
//           SizedBox(height: 16.h),

//           // Client Name Field
//           WassetTextField(
//             title: 'اسم العميل',
//             hintText: 'أدخل اسم العميل',
//             controller: _clientNameController,
//             keyboardType: TextInputType.name,
//             enabled: !_isSubmitting,
//             errorText: _clientNameError,
//             prefixIcon: Icon(
//               Icons.person,
//               color: AppColors.primaryColor,
//             ),
//             onChanged: (_) {
//               if (_clientNameError != null) {
//                 setState(() {
//                   _clientNameError = null;
//                 });
//               }
//             },
//           ),
//           SizedBox(height: 16.h),

//           // Client Phone Field
//           WassetTextField(
//             title: 'رقم الجوال',
//             hintText: 'أدخل رقم الجوال (مثال: 551234567)',
//             controller: _clientPhoneController,
//             keyboardType: TextInputType.phone,
//             enabled: !_isSubmitting,
//             errorText: _clientPhoneError,
//             prefixIcon: Icon(
//               Icons.phone,
//               color: AppColors.primaryColor,
//             ),
//             onChanged: (_) {
//               if (_clientPhoneError != null) {
//                 setState(() {
//                   _clientPhoneError = null;
//                 });
//               }
//             },
//           ),
//           SizedBox(height: 20.h),

//           // Submit Button
//           WassetButton(
//             text: _isSubmitting ? 'جاري الحفظ...' : 'إضافة العميل',
//             onTap: _isSubmitting ? null : _submitClientInfo,
//             backgroundColor: AppColors.primaryColor,
//             textColor: Colors.white,
//           ),
//         ],
//       ),
//     );
//   }
// }
