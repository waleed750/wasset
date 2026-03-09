import 'package:flutter/material.dart';
import 'package:waseet/features/developer_real_estate/domain/repositories/developer_real_estate_repository.dart';
import 'package:waseet/features/developer_real_estate/presentation/projects/cubit/cubit.dart';
import 'package:waseet/features/developer_real_estate/presentation/projects/widgets/widgets.dart';

class DeveloperProjectsPage extends StatelessWidget {
  const DeveloperProjectsPage({super.key, this.extra});
  final Map<String, dynamic>? extra;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeveloperProjectsCubit(
        repository: context.read<DeveloperRealEstateRepository>(),
      ),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: IconButton(
            onPressed: () => Navigator.maybePop(context),
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black87,
            ),
          ),
          title: const Text(
            'المشاريع العقارية للمطورين',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
        ),
        body: const DeveloperProjectsBody(),
      ),
    );
  }
}

