import 'package:flutter/material.dart';
import 'package:waseet/common_widgets/wasset_app_bar.dart';
import 'package:waseet/features/developer_real_estate/domain/repositories/developer_real_estate_repository.dart';
import 'package:waseet/features/developer_real_estate/presentation/project_details/cubit/cubit.dart';
import 'package:waseet/features/developer_real_estate/presentation/project_details/widgets/widgets.dart';

class ProjectDetailsPage extends StatelessWidget {
  const ProjectDetailsPage({super.key, this.projectId});
  final int? projectId;

  @override
  Widget build(BuildContext context) {
    // Require projectId
    if (projectId == null) {
      return const Scaffold(
        appBar: WassetAppBar(title: 'تفاصيل المشروع'),
        body: Center(child: Text('لم يتم تحديد المشروع')),
      );
    }

    return BlocProvider(
      create: (context) => ProjectDetailsCubit(
        repository: context.read<DeveloperRealEstateRepository>(),
        projectId: projectId!,
      ),
      child: const Scaffold(
        appBar: WassetAppBar(title: 'تفاصيل المشروع'),
        body: ProjectDetailsBody(),
      ),
    );
  }
}

