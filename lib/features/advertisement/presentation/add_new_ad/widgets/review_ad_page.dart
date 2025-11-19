import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waseet/app/bloc/app_bloc.dart';
import 'package:waseet/common_widgets/broker_item_icon.dart';
import 'package:waseet/common_widgets/images_banner.dart';
import 'package:waseet/features/advertisement/presentation/add_new_ad/cubit/cubit.dart';
import 'package:waseet/res/assets/assets.gen.dart';
import 'package:waseet/res/res.dart';

class ReviewAdPage extends StatelessWidget {
  const ReviewAdPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddNewAdCubit, AddNewAdState>(
      builder: (context, state) {
        return Column(
          children: [
            Column(
              children: [
                if (state.addAdRequest.images.isNotEmpty)
                  Container(
                    height: MediaQuery.of(context).size.height * 0.25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: ImagesBanner(
                      images:
                          state.addAdRequest.images.map((e) => e.path).toList(),
                    ),
                  ),
                Row(
                  children: [
                    Assets.icons.apartment.svg(),
                    const SizedBox(width: 10),
                    const Text(
                      'نوع العقار',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ),
                  child: Text(
                    state.categories
                            .firstWhere(
                              (element) =>
                                  element.id == state.addAdRequest.categoryId,
                            )
                            .name ??
                        '',
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                  color: AppColors.primaryColor,
                ),
                const SizedBox(width: 10),
                Text(
                  '${state.cities.firstWhere((element) => element.id == state.addAdRequest.cityId).name ?? ''} - ${state.neighborhoods.firstWhere((element) => element.id == state.addAdRequest.neighborhoodId).name ?? ''}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Assets.icons.dollar.svg(),
                const SizedBox(width: 10),
                Text(
                  '${state.addAdRequest.price}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                Text(
                  state.addAdRequest.negotiable
                      ? 'قابل للتفاوض'
                      : 'غير قابل للتفاوض',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextRow(
              text: 'طريقة الدفع',
              value:
                  state.addAdRequest.paymentMethod == 'cash' ? 'كاش' : 'تمويل',
            ),
            TextRow(
              text: 'المساحة',
              value: '${state.addAdRequest.landSpace} متر مربع',
            ),
            TextRow(
              text: 'سعر المتر',
              value: '${state.addAdRequest.meterPrice} ريال',
            ),
            // age
            TextRow(
              text: 'عمر العقار',
              value: '${state.addAdRequest.propertyAge} سنة',
            ),
            // facade
            TextRow(
              text: 'واجهة العقار',
              value: state.addAdRequest.facade == 'north'
                  ? 'شمالية'
                  : state.addAdRequest.facade == 'south'
                      ? 'جنوبية'
                      : state.addAdRequest.facade == 'east'
                          ? 'شرقية'
                          : state.addAdRequest.facade == 'west'
                              ? 'غربية'
                              : 'غير محددة',
            ),
            TextRow(
              text: 'عدد الشوارع',
              value: '${state.addAdRequest.streetsCount} شارع',
            ),
            // saudiCode
            TextRow(
              text: 'الكود السعودي',
              value: state.addAdRequest.saudiCode ? 'نعم' : 'لا',
            ),
            // electricityMeter
            TextRow(
              text: 'عداد الكهرباء',
              value: state.addAdRequest.electricityMeter ? 'نعم' : 'لا',
            ),
            // waterMeter
            TextRow(
              text: 'عداد المياه',
              value: state.addAdRequest.waterMeter ? 'نعم' : 'لا',
            ),
            // sewerage
            TextRow(
              text: 'الصرف الصحي',
              value: state.addAdRequest.sewerage ? 'نعم' : 'لا',
            ),
            TextRow(
              text: 'قابل للتفاوض',
              value: state.addAdRequest.negotiable ? 'نعم' : 'لا',
            ),
            const SizedBox(height: 16),
            Column(
              children: [
                Row(
                  children: [
                    Assets.icons.paperDetails.svg(),
                    const SizedBox(width: 10),
                    const Text(
                      'تفاصيل الإعلان',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ),
                  child: Text(
                    state.addAdRequest.extraInfo,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Column(
              children: [
                Row(
                  children: [
                    Assets.icons.messageEmpty.svg(),
                    const SizedBox(width: 10),
                    const Text(
                      'بيانات التواصل',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: context
                                    .read<AppBloc>()
                                    .state
                                    .user
                                    ?.profile
                                    ?.profileImage !=
                                null
                            ? NetworkImage(
                                context
                                        .read<AppBloc>()
                                        .state
                                        .user
                                        ?.profile
                                        ?.profileImage
                                        .toString() ??
                                    '',
                              )
                            : null,
                        backgroundColor: context
                                    .read<AppBloc>()
                                    .state
                                    .user
                                    ?.profile
                                    ?.profileImage ==
                                null
                            ? AppColors.primaryColor
                            : null,
                        child: context
                                    .read<AppBloc>()
                                    .state
                                    .user
                                    ?.profile
                                    ?.profileImage ==
                                null
                            ? const Icon(
                                Icons.person,
                                color: Colors.white,
                              )
                            : null,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        state.addAdRequest.advertiserName,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        state.addAdRequest.contactPhone,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      // TODO: add call and message functionality
                      BrokerItemIcon(
                        onTap: () {},
                        icon: state.addAdRequest.communicationMethod == 'call'
                            ? Icons.call
                            : Icons.message,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class TextRow extends StatelessWidget {
  const TextRow({
    super.key,
    required this.text,
    required this.value,
  });

  final String text;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Text(
              value,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Divider(
          color: Colors.grey.withOpacity(0.5),
          thickness: 1,
        ),
      ],
    );
  }
}
