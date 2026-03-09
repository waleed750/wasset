import 'package:flutter/material.dart';
import 'package:waseet/common_widgets/wasset_app_bar.dart';
import 'package:waseet/features/developer_real_estate/domain/repositories/developer_real_estate_repository.dart';
import 'package:waseet/features/developer_real_estate/presentation/unit_details/cubit/cubit.dart';
import 'package:waseet/features/developer_real_estate/presentation/unit_details/widgets/widgets.dart';

class UnitDetailsPage extends StatelessWidget {
  const UnitDetailsPage({super.key, this.unitId, this.projectId});
  final int? unitId;
  final int? projectId;

  @override
  Widget build(BuildContext context) {
    // Require unitId
    if (unitId == null) {
      return const Scaffold(
        appBar: WassetAppBar(title: 'تفاصيل الوحدة'),
        body: Center(child: Text('لم يتم تحديد الوحدة')),
      );
    }

    return BlocProvider(
      create: (context) => UnitDetailsCubit(
        repository: context.read<DeveloperRealEstateRepository>(),
        unitId: unitId!,
      ),
      child: const Scaffold(
        appBar: WassetAppBar(title: 'تفاصيل الوحدة'),
        body: UnitDetailsBody(),
      ),
    );
  }
}

