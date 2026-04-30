import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waseet/features/developer_real_estate/data/datasources/developer_opportunity_requests_datasource.dart';
import 'package:waseet/features/developer_real_estate/data/repositories/developer_opportunity_requests_repository_impl.dart';
import 'package:waseet/features/developer_real_estate/presentation/developer_opportunities/cubit/developer_opportunities_cubit.dart';
import 'package:waseet/features/developer_real_estate/presentation/developer_opportunities/view/developer_opportunities_page.dart';
import 'package:waseet/res/api_service.dart';

class ConnectionRequestPage extends StatelessWidget {
  const ConnectionRequestPage({super.key});

  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const ConnectionRequestPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DeveloperOpportunitiesCubit(
        repository: DeveloperOpportunityRequestsRepositoryImpl(
          datasource: DeveloperOpportunityRequestsDatasource(
            apiService: ApiService(),
          ),
        ),
      ),
      child: const DeveloperOpportunitiesPage(),
    );
  }
}
