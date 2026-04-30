import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waseet/features/developer_real_estate/presentation/developer_opportunities/cubit/developer_opportunities_cubit.dart';
import 'package:waseet/features/developer_real_estate/presentation/developer_opportunities/widgets/developer_opportunity_card.dart';

class DeveloperOpportunitiesListBody extends StatefulWidget {
  const DeveloperOpportunitiesListBody({super.key});

  @override
  State<DeveloperOpportunitiesListBody> createState() =>
      _DeveloperOpportunitiesListBodyState();
}

class _DeveloperOpportunitiesListBodyState
    extends State<DeveloperOpportunitiesListBody> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 500) {
      context.read<DeveloperOpportunitiesCubit>().loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeveloperOpportunitiesCubit,
        DeveloperOpportunitiesState>(
      builder: (context, state) {
        if (state is DeveloperOpportunitiesInitial) {
          return const _LoadingWidget();
        }

        if (state is DeveloperOpportunitiesLoading &&
            state is! DeveloperOpportunitiesDetailLoading &&
            state is! DeveloperOpportunitiesDetailError &&
            state is! DeveloperOpportunitiesDetailLoaded) {
          return const _LoadingWidget();
        }

        if (state is DeveloperOpportunitiesError) {
          return _ErrorWidget(
            message: state.message,
            onRetry: () {
              context
                  .read<DeveloperOpportunitiesCubit>()
                  .refreshRequests();
            },
          );
        }

        if (state is DeveloperOpportunitiesLoaded) {
          if (state.requests.isEmpty) {
            return _EmptyWidget(
              onRetry: () {
                context
                    .read<DeveloperOpportunitiesCubit>()
                    .clearFilters();
              },
            );
          }

          return RefreshIndicator(
            onRefresh: () {
              return context
                  .read<DeveloperOpportunitiesCubit>()
                  .refreshRequests();
            },
            child: ListView.builder(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(8),
              itemCount: state.requests.length + 1,
              itemBuilder: (context, index) {
                if (index == state.requests.length) {
                  // Loading indicator at end if more pages available
                  if (state.currentPage < state.lastPage) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 8,
                  ),
                  child: DeveloperOpportunityCard(
                    request: state.requests[index],
                    onTap: () {
                      context
                          .read<DeveloperOpportunitiesCubit>()
                          .loadDetail(state.requests[index].id);
                    },
                  ),
                );
              },
            ),
          );
        }

        return const _LoadingWidget();
      },
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class _ErrorWidget extends StatelessWidget {

  const _ErrorWidget({
    required this.message,
    required this.onRetry,
  });
  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            color: Colors.grey[300],
            size: 48,
          ),
          const SizedBox(height: 16),
          Text(
            'حدث خطأ',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text('حاول مرة أخرى'),
          ),
        ],
      ),
    );
  }
}

class _EmptyWidget extends StatelessWidget {

  const _EmptyWidget({required this.onRetry});
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox_outlined,
            color: Colors.grey[300],
            size: 48,
          ),
          const SizedBox(height: 16),
          Text(
            'لا توجد طلبات',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'جرب تعديل عوامل التصفية',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text('حذف التصفية'),
          ),
        ],
      ),
    );
  }
}
