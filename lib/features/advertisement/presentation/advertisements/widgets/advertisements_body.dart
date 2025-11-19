import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waseet/common_widgets/error.dart';
import 'package:waseet/common_widgets/no_items.dart';
import 'package:waseet/constants/constants.dart';
import 'package:waseet/features/advertisement/presentation/advertisements/cubit/cubit.dart';
import 'package:waseet/features/advertisement/presentation/advertisements/widgets/Ads_search_and_filter.dart';
import 'package:waseet/features/advertisement/presentation/advertisements/widgets/ad_skeleton.dart';
import 'package:waseet/features/advertisement/presentation/advertisements/widgets/categories_filtering_section.dart';
import 'package:waseet/features/advertisement/presentation/my_ads/widgets/ad_card.dart';

class AdvertisementsBody extends StatelessWidget {
  const AdvertisementsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdvertisementsCubit, AdvertisementsState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(15).r,
          child: Column(
            children: [
              const AdsSearchAndFilter(),
              SizedBox(
                height: 10.h,
              ),
              const CategoriesFilteringSection(),
              if (state.status == AdvertisementsStatus.error)
                ErrorPage(
                  onTap: () {
                    context.read<AdvertisementsCubit>().init();
                  },
                ),
              if (state.status == AdvertisementsStatus.loading)
                const AdSkeleton(),
              if (state.status == AdvertisementsStatus.loaded &&
                  state.ads.isEmpty)
                const Expanded(
                  child: NoItem(
                    image: Constants.noAds,
                    text: 'لا توجد اعلانات',
                  ),
                ),
              if (state.status == AdvertisementsStatus.loaded &&
                  state.ads.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    itemCount: state.ads.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 5,
                        ).r,
                        child: AdCard(ad: state.ads[index]),
                      );
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
