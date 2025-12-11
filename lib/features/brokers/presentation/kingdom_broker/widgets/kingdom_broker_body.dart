import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waseet/common_widgets/error.dart';
import 'package:waseet/common_widgets/no_items.dart';
import 'package:waseet/common_widgets/skeleton.dart';
import 'package:waseet/constants/constants.dart';
import 'package:waseet/features/brokers/presentation/kingdom_broker/cubit/cubit.dart';
import 'package:waseet/features/brokers/presentation/kingdom_broker/widgets/broker_card.dart';
import 'package:waseet/features/brokers/presentation/kingdom_broker/widgets/brokers_search_and_filter.dart';
import 'package:waseet/res/assets/assets.gen.dart';

class KingdomBrokerBody extends StatefulWidget {
  const KingdomBrokerBody({super.key});

  @override
  State<KingdomBrokerBody> createState() => _KingdomBrokerBodyState();
}

class _KingdomBrokerBodyState extends State<KingdomBrokerBody> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
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
        _scrollController.position.maxScrollExtent * 0.9) {
      context.read<KingdomBrokerCubit>().loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KingdomBrokerCubit, KingdomBrokerState>(
      builder: (context, state) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(
                10,
              ).r,
              child: const BrokersSearchAndFilter(),
            ),
            if (state.status == BrokerStatus.error)
              ErrorPage(
                onTap: () {
                  context.read<KingdomBrokerCubit>().init();
                },
              ),
            if (state.status == BrokerStatus.loading)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ).r,
                child: const BrokerSkeleton(),
              ),
            if (state.status == BrokerStatus.loaded && state.brokers.isEmpty)
              const NoItem(
                image: Constants.noWossta,
                text: 'لا يوجد وسطاء ',
              ),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: state.brokers.length + (state.hasMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index >= state.brokers.length) {
                    return state.status == BrokerStatus.loadingMore
                        ? const Padding(
                            padding: EdgeInsets.all(16),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : const SizedBox.shrink();
                  }
                  return BrokerCard(
                    broker: state.brokers[index]!,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class BrokerSkeleton extends StatelessWidget {
  const BrokerSkeleton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Skeleton(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            height: 120.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16).r,
              color: Colors.white,
            ),
          ),
        ),
        Skeleton(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            height: 120.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16).r,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
