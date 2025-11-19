import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waseet/common_widgets/error.dart';
import 'package:waseet/common_widgets/no_items.dart';
import 'package:waseet/features/advertisement/presentation/advertisements/cubit/cubit.dart';
import 'package:waseet/features/advertisement/presentation/advertisements/widgets/ad_skeleton.dart';
import 'package:waseet/features/advertisement/presentation/my_ads/widgets/ad_card.dart';
import 'package:waseet/res/assets/assets.gen.dart';

class FavAdvertisementsBody extends StatelessWidget {
  const FavAdvertisementsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdvertisementsCubit, AdvertisementsState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(15).r,
          child: Column(
            children: [
              if (state.status == AdvertisementsStatus.error)
                ErrorPage(
                  onTap: () {
                    context.read<AdvertisementsCubit>().init();
                  },
                ),
              if (state.status == AdvertisementsStatus.loading)
                const AdSkeleton(),
              if (state.status == AdvertisementsStatus.loaded &&
                  state.favds.isEmpty)
                NoItem(
                  image: Assets.images.illustration.path,
                  text: 'لا توجد اعلانات مفضلة',
                ),
              Expanded(
                child: ListView.builder(
                  itemCount: state.favds.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 5,
                      ),
                      child: AdCard(ad: state.favds[index]),
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
