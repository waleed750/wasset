import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:waseet/common_widgets/wasset_drop_down_form_field.dart';
import 'package:waseet/features/advertisement/presentation/advertisements/cubit/advertisements_cubit.dart';
import 'package:waseet/features/user/presentation/register/widgets/wasset_button.dart';
import 'package:waseet/res/enums/broker_type.dart';
import 'package:waseet/res/helper_method.dart';
import 'package:waseet/res/res.dart';

class AdsBottomSheet extends StatefulWidget {
  const AdsBottomSheet({
    super.key,
  });

  @override
  State<AdsBottomSheet> createState() => _AdsBottomSheetState();
}

class _AdsBottomSheetState extends State<AdsBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdvertisementsCubit, AdvertisementsState>(
      builder: (context, state) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) => Container(
            height: MediaQuery.sizeOf(context).height / 2,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 5),
                  spreadRadius: 5,
                  blurRadius: 10,
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    const Text(
                      'بحث',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        context.read<AdvertisementsCubit>().adsUnfiltering();
                      },
                      child: const Text(
                        'مسح',
                        style: TextStyle(
                          fontSize: 15,
                          color: AppColors.primaryColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'نوع الاعلان',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DropdownButtonFormField(
                          dropdownColor: Colors.white,
                          hint: const Text(' اختار نوع الاعلان'),
                          decoration: InputDecoration(
                            hintStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                            enabledBorder: HelperMethod.outlineInputBorder,
                            focusedBorder: HelperMethod.outlineInputBorder,
                            border: HelperMethod.outlineInputBorder,
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: 'rent',
                              child: Text('ايجار'),
                            ),
                            DropdownMenuItem(
                              value: 'buy',
                              child: Text('بيع'),
                            ),
                            DropdownMenuItem(
                              value: 'investment',
                              child: Text('استثمار'),
                            ),
                            DropdownMenuItem(
                              value: 'daily_rent',
                              child: Text('ايجار يومي'),
                            ),
                          ],
                          onChanged: (value) {
                            context
                              ..read<AdvertisementsCubit>().setAdType(value!)
                              ..read<AdvertisementsCubit>().adsFiltering();
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        WassetDropDownFormField(
                          hint: 'شقة ، فيلا ، ارض ...',
                          title: 'نوع العقار',
                          items: state.categories,
                          onChanged: (value) {
                            context
                              ..read<AdvertisementsCubit>()
                                  .setPropertyType(value!.id!)
                              ..read<AdvertisementsCubit>().adsFiltering();
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          ' المدينة',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DropdownButtonFormField(
                          dropdownColor: Colors.white,
                          hint: const Text(
                            'اختر المدينة',
                            style: TextStyle(
                              color: Color.fromARGB(196, 117, 117, 117),
                              fontSize: 14,
                            ),
                          ),
                          decoration: InputDecoration(
                            hintStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 15,
                            ),
                            enabledBorder: HelperMethod.outlineInputBorder,
                            focusedBorder: HelperMethod.outlineInputBorder,
                            border: HelperMethod.outlineInputBorder,
                          ),
                          items: state.cities
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e!.id,
                                  child: Text(
                                    e.name,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            context
                              ..read<AdvertisementsCubit>().setCity(value!)
                              ..read<AdvertisementsCubit>().adsFiltering();
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          ' الحي',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DropdownButtonFormField(
                          dropdownColor: Colors.white,
                          hint: const Text(
                            'اختر الحي',
                            style: TextStyle(
                              color: Color.fromARGB(196, 117, 117, 117),
                              fontSize: 14,
                            ),
                          ),
                          decoration: InputDecoration(
                            hintStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 15,
                            ),
                            enabledBorder: HelperMethod.outlineInputBorder,
                            focusedBorder: HelperMethod.outlineInputBorder,
                            border: HelperMethod.outlineInputBorder,
                          ),
                          items: state.neighborhoods
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(
                                    e!.name,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            context
                              ..read<AdvertisementsCubit>()
                                  .setNeighborhood(value!.name)
                              ..read<AdvertisementsCubit>().adsFiltering();
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        WassetDropDownFormField(
                          hint: 'اختار عمر العقار',
                          title: 'عمر العقار',
                          items: const [
                            0,
                            1,
                            10,
                            20,
                            30,
                            40,
                            50,
                          ],
                          onChanged: (value) {
                            context
                              ..read<AdvertisementsCubit>()
                                  .setPropertyAge(value!)
                              ..read<AdvertisementsCubit>().adsFiltering();
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'طريقة الدفع',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DropdownButtonFormField(
                          dropdownColor: Colors.white,
                          hint: const Text('اختار'),
                          decoration: InputDecoration(
                            hintStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                            enabledBorder: HelperMethod.outlineInputBorder,
                            focusedBorder: HelperMethod.outlineInputBorder,
                            border: HelperMethod.outlineInputBorder,
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: 'cash',
                              child: Text('كاش'),
                            ),
                            DropdownMenuItem(
                              value: 'financing',
                              child: Text('تمويل'),
                            ),
                          ],
                          onChanged: (value) {
                            context
                              ..read<AdvertisementsCubit>().setPayMethod(value!)
                              ..read<AdvertisementsCubit>().adsFiltering();
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: WassetButton(
                            backgroundColor: AppColors.primaryColor,
                            onTap: () {
                              context.pop();
                            },
                            text: ' عرض النتائج (${state.ads.length})اعلان',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
