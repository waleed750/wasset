import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:waseet/common_widgets/custom_appbar.dart';
import 'package:waseet/features/user/domain/entities/packages_entity.dart';
import 'package:waseet/features/user/presentation/packages/cubit/cubit.dart';
import 'package:waseet/features/user/presentation/packages/widgets/package_card.dart';
import 'package:waseet/features/user/presentation/register/widgets/wasset_button.dart';
import 'package:waseet/res/assets/assets.gen.dart';
import 'package:waseet/res/res.dart';
import 'package:waseet/router/screens.dart';

/// {@template packages_body}
/// Body of the PackagesPage.
///
/// Add what it does
/// {@endtemplate}
class PackagesBody extends StatelessWidget {
  /// {@macro packages_body}
  const PackagesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PackagesCubit, PackagesState>(
      builder: (context, state) {
        return SafeArea(
          child: Column(
            children: [
              const CustomAppbar(title: 'باقات'),
              Expanded(
                child: ListView.builder(
                  itemCount: state.packages.length,
                  itemBuilder: (context, index) {
                    final package = state.packages[index];
                    return PackageCard(package: package);
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
