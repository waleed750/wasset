import 'package:flutter/material.dart';
import 'package:waseet/app/bloc/app_bloc.dart';
import 'package:waseet/common_widgets/wasset_app_bar.dart';
import 'package:waseet/features/advertisement/domain/repositories/ad_repository.dart';
import 'package:waseet/features/advertisement/presentation/my_ads/cubit/cubit.dart';
import 'package:waseet/features/advertisement/presentation/my_ads/widgets/my_ads_body.dart';

/// {@template my_ads_page}
/// A description for MyAdsPage
/// {@endtemplate}
class MyAdsPage extends StatelessWidget {
  /// {@macro my_ads_page}
  const MyAdsPage({super.key});

  /// The static route for MyAdsPage
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const MyAdsPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyAdsCubit(
        adRepository: context.read<AdRepository>(),
        userId: context.read<AppBloc>().state.user!.id,
      ),
      child: const Scaffold(
        appBar: WassetAppBar(title: 'اعلاناتي'),
        body: MyAdsView(),
      ),
    );
  }
}

/// {@template my_ads_view}
/// Displays the Body of MyAdsView
/// {@endtemplate}
class MyAdsView extends StatelessWidget {
  /// {@macro my_ads_view}
  const MyAdsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const MyAdsBody();
  }
}
