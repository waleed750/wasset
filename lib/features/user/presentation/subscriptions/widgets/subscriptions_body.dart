import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waseet/common_widgets/error.dart';
import 'package:waseet/features/user/presentation/subscriptions/cubit/cubit.dart';
import 'package:waseet/res/res.dart';

/// {@template subscriptions_body}
/// Body of the SubscriptionsPage.
///
/// Add what it does
/// {@endtemplate}
class SubscriptionsBody extends StatelessWidget {
  /// {@macro subscriptions_body}
  const SubscriptionsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubscriptionsCubit, SubscriptionsState>(
      builder: (context, state) {
        if (state.status == SubscriptionsStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state.status == SubscriptionsStatus.error) {
          return ErrorPage(
            onTap: () {
              context.read<SubscriptionsCubit>().getSubscriptions();
            },
          );
        }
        if (state.subscriptions.isEmpty) {
          return const Center(
            child: Text('لا يوجد باقات مشترك بها'),
          );
        }
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24).r,
            child: Column(
              children: [
                ...List.generate(
                  state.subscriptions.length,
                  (index) {
                    final subscription = state.subscriptions[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 10).r,
                      padding: const EdgeInsets.all(14).r,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10).r,
                        border: Border(
                          right: BorderSide(
                            width: 20.w,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryColor.withOpacity(0.23),
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: const Offset(0, 1.86),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'نوع الباقة: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.sp,
                                ),
                              ),
                              Text(
                                subscription.name ?? '',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          Row(
                            children: [
                              Text(
                                'تاريخ البداية: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.sp,
                                ),
                              ),
                              Text(
                                subscription.startAtFormatted,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          Row(
                            children: [
                              Text(
                                'تاريخ النهاية: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.sp,
                                ),
                              ),
                              Text(
                                subscription.endAtFormatted,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                          // SizedBox(height: 34.h),
                          // GestureDetector(
                          //   onTap: () {},
                          //   child: Text(
                          //     'إلغاء الاشتراك',
                          //     style: TextStyle(
                          //       color: Colors.red,
                          //       fontSize: 14.sp,
                          //       fontWeight: FontWeight.w400,
                          //       decoration: TextDecoration.underline,
                          //       decorationColor: Colors.red,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
