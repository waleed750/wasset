// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:waseet/features/brokers/presentation/my_personal_office/cubit/cubit.dart';
import 'package:waseet/features/brokers/presentation/my_personal_office/widgets/add_new_post.dart';
import 'package:waseet/features/brokers/presentation/my_personal_office/widgets/curve_clipper.dart';
import 'package:waseet/features/brokers/presentation/my_personal_office/widgets/statistics_column.dart';
import 'package:waseet/res/assets/assets.gen.dart';
import 'package:waseet/res/enums/broker_type.dart';
import 'package:waseet/res/helper_method.dart';
import 'package:waseet/res/res.dart';
import 'package:waseet/router/screens.dart';

/// {@template my_personal_office_body}
/// Body of the MyPersonalOfficePage.
///
/// Add what it does
/// {@endtemplate}
class MyPersonalOfficeBody extends StatelessWidget {
  /// {@macro my_personal_office_body}
  const MyPersonalOfficeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyPersonalOfficeCubit, MyPersonalOfficeState>(
      builder: (context, state) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 200.h,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: ClipPath(
                          clipper: CurveClipper(),
                          child: Container(
                            // height: 150,
                            child: state.wassetProfile?.profileImage != null
                                ? Image.network(
                                    state.wassetProfile?.profileImage ?? '',
                                    fit: BoxFit.cover,
                                  )
                                : DecoratedBox(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          AppColors.primaryColor,
                                          AppColors.primaryColor.withOpacity(
                                            0.5,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 50.r,
                          backgroundColor: AppColors.primaryColor,
                          backgroundImage:
                              state.wassetProfile?.profileImage != null
                                  ? NetworkImage(
                                      state.wassetProfile?.profileImage ?? '',
                                    )
                                  : null,
                          child: state.wassetProfile?.profileImage != null
                              ? null
                              : Assets.icons.user.svg(
                                  color: Colors.white,
                                  width: 50.w,
                                  height: 50.h,
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  state.wassetProfile?.name ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8.h),
                Visibility(
                  visible: state.wassetProfile?.officeType?.isNotEmpty ?? false,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Assets.icons.user.svg(
                        color: AppColors.primaryColor,
                        width: 16.w,
                        height: 16.h,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        state.wassetProfile?.officeType?.toBrokerType
                                .arabicName ??
                            '',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                if (state.wassetProfile?.officeType?.isNotEmpty ?? false)
                  SizedBox(height: 8.h),
                Visibility(
                  visible: state.wassetProfile?.cities?.isNotEmpty ?? false,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_on,
                        color: AppColors.primaryColor,
                        size: 16.sp,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        state.wassetProfile?.cities?.join(', ') ?? '',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                if (state.wassetProfile?.cities?.isNotEmpty ?? false)
                  SizedBox(height: 8.h),
                Visibility(
                  visible:
                      state.wassetProfile?.wassetSpecialization?.isNotEmpty ??
                          false,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.tag,
                        color: AppColors.primaryColor,
                        size: 16.sp,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        state.wassetProfile?.wassetSpecialization?.join(', ') ??
                            '',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                if (state.wassetProfile?.wassetSpecialization?.isNotEmpty ??
                    false)
                  SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.phone,
                      color: AppColors.primaryColor,
                      size: 16.sp,
                    ),
                    SizedBox(width: 8.w),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Text(
                        state.wassetProfile?.phone ?? '',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // contact with broker
                ElevatedButton(
                  onPressed: () {
                    // open phone app and call broker
                    if (state.isUserProfile) {
                      HelperMethod.showSnackBar(
                        context,
                        'لا يمكن الاتصال بنفسك',
                        type: SnackBarType.error,
                      );
                      return;
                    }
                    HelperMethod.openCall(
                      state.wassetProfile?.phone ?? '',
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    // foregroundColor: AppColors.primaryColor,
                    backgroundColor: AppColors.primaryColor.withOpacity(0.2),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.phone,
                        color: AppColors.primaryColor,
                        size: 16.sp,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'تواصل مع الوسيط',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8.h),
                // statistics Row with 3 columns
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StatisticsColumn(
                      title: state.isUserProfile ? 'زوار مكتبي' : 'عدد الزوار',
                      value:
                          state.wassetProfile?.visitorsCount?.toString() ?? '',
                    ),
                    SizedBox(
                      width: 16.w,
                    ),
                    SizedBox(
                      height: 50.h,
                      child: VerticalDivider(
                        color: Colors.grey.withOpacity(0.5),
                        thickness: 1,
                      ),
                    ),
                    SizedBox(
                      width: 16.w,
                    ),
                    StatisticsColumn(
                      title: state.isUserProfile ? 'تقييمي' : 'متوسط التقييم',
                      value:
                          state.wassetProfile?.averageRating?.toString() ?? '0',
                    ),
                    SizedBox(
                      width: 16.w,
                    ),
                    SizedBox(
                      height: 50.h,
                      child: VerticalDivider(
                        color: Colors.grey.withOpacity(0.5),
                        thickness: 1,
                      ),
                    ),
                    SizedBox(
                      width: 16.w,
                    ),
                    StatisticsColumn(
                      title: state.isUserProfile ? 'اعلاناتي' : 'عدد الاعلانات',
                      value: state.ads.length.toString(),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Divider(
                  color: Colors.grey.withOpacity(0.5),
                  thickness: 1,
                ),
                SizedBox(height: 16.h),
                // my published content (horizontal list of posts)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16).r,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'المحتوى الاثرائي',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (state.isUserProfile)
                        GestureDetector(
                          onTap: () {
                            // open pop up to add content
                            showDialog<void>(
                              context: context,
                              builder: (_) => AddNewPost(
                                onAddNewPost: (content) {
                                  context
                                      .read<MyPersonalOfficeCubit>()
                                      .addNewPost(content);
                                },
                              ),
                            );
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.add,
                                color: AppColors.primaryColor,
                                size: 16.sp,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                'اضافة محتوى',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryColor,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 4.h),
                SizedBox(
                  height: 120.h,
                  child: Visibility(
                    visible: state.posts.isNotEmpty,
                    replacement: Center(
                      child: Text(
                        state.isUserProfile
                            ? 'لا يوجد محتوى، اضف محتوى جديد'
                            : 'لم يقم بنشر محتوى بعد',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.posts.length,
                      itemBuilder: (context, index) {
                        final post = state.posts[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              // open pop up and show post just text
                              showDialog<void>(
                                context: context,
                                builder: (_) => Dialog(
                                  child: Container(
                                    width: (MediaQuery.of(context).size.width *
                                            0.8)
                                        .w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8).r,
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.primaryColor
                                              .withOpacity(0.5),
                                          blurRadius: 3,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    padding: const EdgeInsets.all(16).r,
                                    child: Text(
                                      post.content,
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 16).r,
                              width: 0.7.sw,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        AppColors.primaryColor.withOpacity(0.5),
                                    blurRadius: 3,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.all(16).r,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Icon(
                                      //   Icons.remove_red_eye,
                                      //   color: AppColors.primaryColor,
                                      //   size: 16,
                                      // ),
                                      // SizedBox(width: 8),
                                      // Text(
                                      //   '100',
                                      //   style: TextStyle(
                                      //     fontSize: 14,
                                      //     fontWeight: FontWeight.normal,
                                      //   ),
                                      // ),
                                      // SizedBox(width: 16),
                                      if (state.isUserProfile)
                                        GestureDetector(
                                          onTap: () {
                                            // open pop up to edit post
                                            showDialog<void>(
                                              context: context,
                                              builder: (_) => AddNewPost(
                                                onAddNewPost: (content) {
                                                  context
                                                      .read<
                                                          MyPersonalOfficeCubit>()
                                                      .editPost(
                                                        post.id,
                                                        content,
                                                      );
                                                },
                                                content: post.content,
                                              ),
                                            );
                                          },
                                          child: Icon(
                                            Icons.edit,
                                            color: AppColors.primaryColor,
                                            size: 16.sp,
                                          ),
                                        ),
                                      if (state.isUserProfile)
                                        SizedBox(width: 8.w),
                                      if (state.isUserProfile)
                                        GestureDetector(
                                          onTap: () {
                                            context
                                                .read<MyPersonalOfficeCubit>()
                                                .deletePost(post.id);
                                          },
                                          child: Icon(
                                            Icons.delete,
                                            color: AppColors.primaryColor,
                                            size: 16.sp,
                                          ),
                                        ),
                                    ],
                                  ),
                                  Text(
                                    post.content,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    textAlign: TextAlign.start,
                                    maxLines: 2,
                                  ),
                                  // read more
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        'اقرأ المزيد',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.primaryColor,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                      SizedBox(width: 8.w),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: AppColors.primaryColor,
                                        size: 12.sp,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(width: 0);
                      },
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                // my ads
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16).r,
                    child: Text(
                      state.isUserProfile ? 'اعلاناتي' : 'اعلانات الوسيط',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                // my ads (horizontal list of posts)
                SizedBox(
                  height: 190.h,
                  child: Visibility(
                    visible: state.ads.isNotEmpty,
                    replacement: Center(
                      child: Text.rich(
                        TextSpan(
                          text: state.isUserProfile
                              ? 'لم تقم بإضافة اعلانات بعد'
                              : 'لم يقم بإضافة اعلانات بعد',
                          children: [
                            if (state.isUserProfile)
                              TextSpan(
                                text: '، اضف اعلان جديد',
                                style: const TextStyle(
                                  color: AppColors.primaryColor,
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    context.pushNamed(
                                      Screens.addNewAd.name,
                                    );
                                  },
                              ),
                          ],
                        ),
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.ads.length,
                      itemBuilder: (context, index) {
                        final ad = state.ads[index];
                        // column with picture stack have 2 children (picture and since) and 1 grandchild (since text)
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 16,
                          ).r,
                          child: GestureDetector(
                            onTap: () {
                              context.pushNamed(
                                Screens.adDetails.name,
                                extra: ad,
                              );
                            },
                            child: Container(
                              width: 0.4.sw,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        AppColors.primaryColor.withOpacity(0.5),
                                    blurRadius: 3,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.only(bottom: 8).r,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Stack(
                                      children: [
                                        Positioned.fill(
                                          child: ad.images?.isEmpty ?? true
                                              ? Image.asset(
                                                  Assets.images.buildings.path,
                                                  width: double.infinity,
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.network(
                                                  ad.images?.first ?? '',
                                                  width: double.infinity,
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                        //! since text
                                        // Positioned(
                                        //   bottom: 0,
                                        //   left: 0,
                                        //   right: 0,
                                        //   child: Container(
                                        //     padding:
                                        //         const EdgeInsets.symmetric(
                                        //       horizontal: 8,
                                        //       vertical: 4,
                                        //     ).r,
                                        //     decoration: BoxDecoration(
                                        //       color: Colors.black
                                        //           .withOpacity(0.5),
                                        //     ),
                                        //     child: Text(
                                        //       'منذ 3 ايام',
                                        //       style: TextStyle(
                                        //         fontSize: 12.sp,
                                        //         fontWeight: FontWeight.w600,
                                        //         color: Colors.white,
                                        //       ),
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ).r,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          ad.category?.name ?? '',
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(height: 8.h),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              'اقرأ المزيد',
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.primaryColor,
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                            ),
                                            SizedBox(width: 8.w),
                                            Icon(
                                              Icons.arrow_forward_ios,
                                              color: AppColors.primaryColor,
                                              size: 12.sp,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(width: 16.w);
                      },
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                // my favorite clients
                // const Align(
                //   alignment: Alignment.centerRight,
                //   child: Padding(
                //     padding: EdgeInsets.symmetric(horizontal: 16),
                //     child: Text(
                //       'عملائي المميزين',
                //       style: TextStyle(
                //         fontSize: 16,
                //         fontWeight: FontWeight.w600,
                //       ),
                //     ),
                //   ),
                // ),
                // const SizedBox(height: 16),
                // // my favorite clients (horizontal list of clients) (column(avatar, name) Avatar is circle and have star at top right)
                // SizedBox(
                //   height: MediaQuery.of(context).size.width * 0.3,
                //   child: ListView.separated(
                //     scrollDirection: Axis.horizontal,
                //     itemCount: 10,
                //     itemBuilder: (context, index) {
                //       return Padding(
                //         padding: const EdgeInsets.symmetric(
                //           vertical: 8,
                //         ),
                //         child: Container(
                //           width: MediaQuery.of(context).size.width * 0.3,
                //           decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(8),
                //             color: Colors.white,
                //             boxShadow: [
                //               BoxShadow(
                //                 color: AppColors.primaryColor.withOpacity(0.5),
                //                 blurRadius: 3,
                //                 offset: const Offset(0, 2),
                //               ),
                //             ],
                //           ),
                //           padding: const EdgeInsets.all(4),
                //           child: const Column(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             children: [
                //               Stack(
                //                 children: [
                //                   CircleAvatar(
                //                     radius: 24,
                //                     backgroundImage: NetworkImage(
                //                       'https://picsum.photos/200',
                //                     ),
                //                   ),
                //                   Icon(
                //                     Icons.star,
                //                     color: Colors.amber,
                //                     size: 16,
                //                   ),
                //                 ],
                //               ),
                //               SizedBox(height: 8),
                //               AutoSizeText(
                //                 'محمد احمد',
                //                 maxLines: 1,
                //                 maxFontSize: 16,
                //                 style: TextStyle(
                //                   fontWeight: FontWeight.w600,
                //                   overflow: TextOverflow.ellipsis,
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       );
                //     },
                //     separatorBuilder: (context, index) {
                //       return const SizedBox(width: 16);
                //     },
                //   ),
                // ),
                // const SizedBox(height: 16),
                // my clients opinions
                //   Align(
                //     alignment: Alignment.centerRight,
                //     child: Padding(
                //       padding: const EdgeInsets.symmetric(horizontal: 16).r,
                //       child: Text(
                //         'اراء عملائي',
                //         style: TextStyle(
                //           fontSize: 16.sp,
                //           fontWeight: FontWeight.w600,
                //         ),
                //       ),
                //     ),
                //   ),
                //   SizedBox(height: 16.h),
                //   // my clients opinions (horizontal list of opinions) (Row with 2 columns (avatar) and (Row(name, rate), opinion text))
                //   SizedBox(
                //     height: 0.3.sw,
                //     child: ListView.separated(
                //       scrollDirection: Axis.horizontal,
                //       itemCount: 10,
                //       itemBuilder: (context, index) {
                //         return Padding(
                //           padding: const EdgeInsets.symmetric(
                //             vertical: 8,
                //           ).r,
                //           child: Container(
                //             width: 0.8.sw,
                //             decoration: BoxDecoration(
                //               borderRadius: BorderRadius.circular(8),
                //               color: Colors.white,
                //               boxShadow: [
                //                 BoxShadow(
                //                   color:
                //                       AppColors.primaryColor.withOpacity(0.5),
                //                   blurRadius: 3,
                //                   offset: const Offset(0, 2),
                //                 ),
                //               ],
                //             ),
                //             padding: const EdgeInsets.all(8).r,
                //             child: Row(
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 CircleAvatar(
                //                   radius: 24.r,
                //                   backgroundImage: const NetworkImage(
                //                     'https://picsum.photos/200',
                //                   ),
                //                 ),
                //                 SizedBox(width: 16.w),
                //                 Expanded(
                //                   child: Column(
                //                     crossAxisAlignment:
                //                         CrossAxisAlignment.start,
                //                     children: [
                //                       Row(
                //                         mainAxisAlignment:
                //                             MainAxisAlignment.spaceBetween,
                //                         children: [
                //                           Text(
                //                             'محمد احمد',
                //                             style: TextStyle(
                //                               fontSize: 16.sp,
                //                               fontWeight: FontWeight.w600,
                //                             ),
                //                           ),
                //                           RatingBar.builder(
                //                             initialRating: 3,
                //                             minRating: 1,
                //                             allowHalfRating: true,
                //                             itemSize: 16,
                //                             itemBuilder: (context, _) => Icon(
                //                               Icons.star,
                //                               color: Colors.amber,
                //                               size: 16.sp,
                //                             ),
                //                             onRatingUpdate: print,
                //                           ),
                //                         ],
                //                       ),
                //                       SizedBox(height: 8.h),
                //                       Text(
                //                         'من العوامل المهمة التي يجب الالتفات إليها هي تحديد أفضل وقتا لشراء عقار مع الالتفات إلى عدة عوامل مثل نشاط...',
                //                         style: TextStyle(
                //                           fontSize: 12.sp,
                //                           fontWeight: FontWeight.w400,
                //                         ),
                //                         maxLines: 2,
                //                         overflow: TextOverflow.ellipsis,
                //                       ),
                //                     ],
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         );
                //       },
                //       separatorBuilder: (BuildContext context, int index) =>
                //           const SizedBox(
                //         width: 16,
                //       ),
                //     ),
                //   ),
              ],
            ),
          ),
        );
      },
    );
  }
}
