import 'package:flutter/material.dart';
import 'package:waseet/common_widgets/error.dart';
import 'package:waseet/features/advertisement/presentation/my_ads/cubit/cubit.dart';
import 'package:waseet/features/advertisement/presentation/my_ads/widgets/ad_card.dart';

/// {@template my_ads_body}
/// Body of the MyAdsPage.
///
/// Add what it does
/// {@endtemplate}
class MyAdsBody extends StatelessWidget {
  /// {@macro my_ads_body}
  const MyAdsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyAdsCubit, MyAdsState>(
      builder: (context, state) {
        if (state.status == MyAdsStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state.status == MyAdsStatus.error) {
          return ErrorPage(
            onTap: () {
              context.read<MyAdsCubit>().init();
            },
          );
        }
        if (state.ads.isEmpty) {
          return const Center(
            child: Text('لا يوجد إعلانات'),
          );
        }
        return Container(
          margin: const EdgeInsets.only(top: 16),
          child: ListView.separated(
            itemBuilder: (context, index) {
              final ad = state.ads[index];
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: AdCard(
                  ad: ad,
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 16);
            },
            itemCount: state.ads.length,
          ),
        );
      },
    );
  }
}
