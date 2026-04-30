// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:waseet/res/res.dart';

// class ClientInfoDisplay extends StatelessWidget {
//   const ClientInfoDisplay({
//     super.key,
//     this.clientName,
//     this.clientPhone,
//   });

//   final String? clientName;
//   final String? clientPhone;

//   @override
//   Widget build(BuildContext context) {
//     final hasClientData = (clientName?.isNotEmpty ?? false) ||
//         (clientPhone?.isNotEmpty ?? false);

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
//           SizedBox(height: 12.h),
//           if (!hasClientData)
//             Center(
//               child: Text(
//                 'لا توجد بيانات عميل',
//                 style: TextStyle(
//                   fontSize: 14.sp,
//                   color: Colors.grey.shade600,
//                 ),
//               ),
//             )
//           else ...[
//             if (clientName?.isNotEmpty ?? false)
//               _InfoField(
//                 label: 'اسم العميل',
//                 value: clientName ?? '',
//               ),
//             if (clientName?.isNotEmpty ?? false) SizedBox(height: 12.h),
//             if (clientPhone?.isNotEmpty ?? false)
//               _InfoField(
//                 label: 'رقم الجوال',
//                 value: clientPhone ?? '',
//               ),
//           ],
//         ],
//       ),
//     );
//   }
// }

// class _InfoField extends StatelessWidget {
//   const _InfoField({
//     required this.label,
//     required this.value,
//   });

//   final String label;
//   final String value;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8).r,
//         color: Colors.white,
//         border: Border.all(color: Colors.grey.withOpacity(0.2)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: 12.sp,
//               color: Colors.grey.shade700,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           SizedBox(height: 4.h),
//           Text(
//             value,
//             style: TextStyle(
//               fontSize: 14.sp,
//               fontWeight: FontWeight.w600,
//               color: Colors.black87,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
