import 'package:flutter/material.dart';
import 'package:waseet/features/user/domain/entities/packages_entity.dart';
import 'package:waseet/features/user/presentation/packages/cubit/cubit.dart';
import 'package:waseet/features/user/presentation/packages/widgets/card_details_body.dart';

class CardDetailsPage extends StatelessWidget {
  const CardDetailsPage({
    super.key,
    this.cubit,
  });
  final PackagesCubit? cubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit!,
      child: const Scaffold(
        body: CardDetailsView(),
      ),
    );
  }
}

class CardDetailsView extends StatelessWidget {
  const CardDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return const CardDetailsBody();
  }
}
