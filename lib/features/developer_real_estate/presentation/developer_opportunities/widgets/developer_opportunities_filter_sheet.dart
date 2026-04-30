import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waseet/features/developer_real_estate/presentation/developer_opportunities/cubit/developer_opportunities_cubit.dart';
import 'package:waseet/res/res.dart';

class DeveloperOpportunitiesFilterSheet extends StatefulWidget {
  const DeveloperOpportunitiesFilterSheet({super.key});

  @override
  State<DeveloperOpportunitiesFilterSheet> createState() =>
      _DeveloperOpportunitiesFilterSheetState();
}

class _DeveloperOpportunitiesFilterSheetState
    extends State<DeveloperOpportunitiesFilterSheet> {
  late DeveloperOpportunitiesCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<DeveloperOpportunitiesCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return DecoratedBox(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: BlocBuilder<DeveloperOpportunitiesCubit,
                  DeveloperOpportunitiesState>(
                builder: (context, state) {
                  final filters = (state is DeveloperOpportunitiesLoaded)
                      ? state.availableFilters
                      : null;

                  final selectedOppType = (state is DeveloperOpportunitiesLoaded)
                      ? state.selectedOpportunityType
                      : null;
                  final selectedCommType =
                      (state is DeveloperOpportunitiesLoaded)
                          ? state.selectedCommunicationRequestType
                          : null;
                  final selectedDeveloper =
                      (state is DeveloperOpportunitiesLoaded)
                          ? state.selectedDeveloper
                          : null;

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'تصفية الطلبات',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Icon(Icons.close),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      // Opportunity types
                      if (filters?.opportunityTypes != null &&
                          filters!.opportunityTypes.isNotEmpty)
                        _buildFilterSection(
                          title: 'نوع الفرصة',
                          items: filters.opportunityTypes,
                          selectedItem: selectedOppType,
                          onSelected: (item) {
                            _cubit.applyFilters(
                              opportunityType: item,
                            );
                          },
                        ),
                      const SizedBox(height: 16),
                      // Communication Request Types
                      if (filters?.communicationRequestTypes != null &&
                          filters!.communicationRequestTypes.isNotEmpty)
                        _buildFilterSection(
                          title: 'نوع طلب التواصل',
                          items: filters.communicationRequestTypes,
                          selectedItem: selectedCommType,
                          onSelected: (item) {
                            _cubit.applyFilters(
                              communicationRequestType: item,
                            );
                          },
                        ),
                      const SizedBox(height: 16),
                      // Developers
                      if (filters?.developers != null &&
                          filters!.developers.isNotEmpty)
                        _buildFilterSection(
                          title: 'المطور',
                          items: filters.developers,
                          selectedItem: selectedDeveloper,
                          onSelected: (item) {
                            _cubit.applyFilters(
                              developer: item,
                            );
                          },
                        ),
                      const SizedBox(height: 24),
                      // Clear filters button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            _cubit.clearFilters();
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.refresh),
                          label: const Text('حذف التصفية'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[300],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Apply filters button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('تطبيق'),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFilterSection<T>({
    required String title,
    required List<T> items,
    required dynamic selectedItem,
    required Function(T?) onSelected,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: items.map((item) {
            final isSelected = selectedItem?.id == (item as dynamic).id;
            return FilterChip(
              label: Text((item as dynamic).name as String),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  onSelected(item);
                } else {
                  onSelected(null);
                }
              },
              backgroundColor: Colors.grey[300],
              selectedColor: AppColors.primaryColor,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
