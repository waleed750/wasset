import 'package:flutter/material.dart';
import 'package:waseet/common_widgets/wasset_app_bar.dart';
import 'package:waseet/features/advertisement/domain/entities/ad_entity.dart';
import 'package:waseet/features/advertisement/domain/repositories/ad_repository.dart';
import 'package:waseet/features/advertisement/presentation/ad_details/cubit/cubit.dart';
import 'package:waseet/features/advertisement/presentation/ad_details/widgets/ad_details_body.dart';

/// {@template ad_details_page}
/// A description for AdDetailsPage
/// {@endtemplate}
class AdDetailsPage extends StatelessWidget {
  /// {@macro ad_details_page}
  const AdDetailsPage({super.key, this.adId, this.ad});

  final int? adId;
  final AdEntity? ad;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdDetailsCubit(
        adRepository: context.read<AdRepository>(),
        ad: ad,
        adId: adId ?? 0,
      ),
      child: const Scaffold(
        appBar: WassetAppBar(title: 'تفاصيل الإعلان'),
        body: AdDetailsView(),
      ),
    );
  }
}

/// {@template ad_details_view}
/// Displays the Body of AdDetailsView
/// {@endtemplate}
class AdDetailsView extends StatelessWidget {
  /// {@macro ad_details_view}
  const AdDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const AdDetailsBody();
  }
}
