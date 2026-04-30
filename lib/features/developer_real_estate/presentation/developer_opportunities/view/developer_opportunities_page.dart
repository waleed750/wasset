import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waseet/features/developer_real_estate/domain/entities/developer_opportunity_filter_entity.dart';
import 'package:waseet/features/developer_real_estate/presentation/developer_opportunities/cubit/developer_opportunities_cubit.dart';
import 'package:waseet/features/developer_real_estate/presentation/developer_opportunities/view/developer_opportunity_detail_page.dart';
import 'package:waseet/features/developer_real_estate/presentation/developer_opportunities/widgets/developer_opportunities_list_body.dart';
import 'package:waseet/features/developer_real_estate/presentation/developer_opportunities/widgets/developer_opportunities_filter_sheet.dart';
import 'package:waseet/res/res.dart';

class DeveloperOpportunitiesPage extends StatefulWidget {
  const DeveloperOpportunitiesPage({super.key});

  @override
  State<DeveloperOpportunitiesPage> createState() =>
      _DeveloperOpportunitiesPageState();
}

class _DeveloperOpportunitiesPageState
    extends State<DeveloperOpportunitiesPage> {
  @override
  void initState() {
    super.initState();
    context.read<DeveloperOpportunitiesCubit>().init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('طلبات المطورين'),
        elevation: 0,
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        // actions: [
        //   _buildFilterButton(context),
        // ],
      ),
      body: BlocListener<DeveloperOpportunitiesCubit,
          DeveloperOpportunitiesState>(
        listener: (context, state) {
          if (state is DeveloperOpportunitiesDetailLoaded) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DeveloperOpportunityDetailPage(
                  request: state.request,
                ),
              ),
            );
          }
        },
        child: const DeveloperOpportunitiesListBody(),
      ),
    );
  }

  Widget _buildFilterButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Center(
        child: GestureDetector(
          onTap: () {
            final cubit = context.read<DeveloperOpportunitiesCubit>();
            showModalBottomSheet(
              context: context,
              builder: (_) => BlocProvider.value(
                value: cubit,
                child: const DeveloperOpportunitiesFilterSheet(),
              ),
              isScrollControlled: true,
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.filter_list),
                const SizedBox(width: 4),
                Text(
                  'تصفية',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
