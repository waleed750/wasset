// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:waseet/app/bloc/app_bloc.dart';
// import 'package:waseet/constants/constants.dart';

// class CustomBottomMenu extends StatelessWidget {
//   CustomBottomMenu({
//     super.key,
//   });
//   final PageController pageController = PageController(viewportFraction: 1);
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: BlocBuilder<AppBloc, AppState>(
//         builder: (context, state) {
//           final isBusy = state.isBusy;
//           final isAuthenticated = state.status;
//           return Container(
//             width: double.infinity,
//             padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20)
// ,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const MenuItem(
//                   text: 'الرئسية',
//                   image: Constants.mainFilled,
//                 ),
//                 if (isAuthenticated == AppStatus.unauthenticated)
//                   const MenuItem(
//                     text: 'الأعلانات',
//                     image: Constants.adEmpty,
//                   ),
//                 if (isAuthenticated == AppStatus.authenticated)
//                   const MenuItem(
//                     text: 'إضافة إعلان',
//                     image: Constants.addAd,
//                   ),
//                 const MenuItem(
//                   text: 'الرسايل',
//                   image: Constants.messageEmpty,
//                 ),
//                 if (isAuthenticated == AppStatus.unauthenticated)
//                   const MenuItem(
//                     text: 'طلباتي',
//                     image: Constants.myOrderEmpty,
//                   ),
//                 if (isAuthenticated == AppStatus.authenticated &&
//                     isBusy == false)
//                   const MenuItem(
//                     text: 'التحالفات ',
//                     image: Constants.alliance,
//                   ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class MenuItem extends StatelessWidget {
//   const MenuItem({
//     super.key,
//     required this.image,
//     required this.text,
//   });
//   final String image;
//   final String text;
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [SvgPicture.asset(image), Text(text)],
//     );
//   }
// }
