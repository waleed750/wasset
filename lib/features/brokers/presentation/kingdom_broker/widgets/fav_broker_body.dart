import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waseet/common_widgets/error.dart';
import 'package:waseet/common_widgets/no_items.dart';
import 'package:waseet/constants/constants.dart';
import 'package:waseet/features/brokers/presentation/kingdom_broker/cubit/kingdom_broker_cubit.dart';
import 'package:waseet/features/brokers/presentation/kingdom_broker/widgets/broker_card.dart';
import 'package:waseet/features/brokers/presentation/kingdom_broker/widgets/kingdom_broker_body.dart';

class FavBrokerBody extends StatelessWidget {
  const FavBrokerBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KingdomBrokerCubit, KingdomBrokerState>(
      builder: (context, state) {
        return Column(
          children: [
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
            Expanded(
              child: SingleChildScrollView(
                child: state.favBrokers.isEmpty &&
                        state.status == BrokerStatus.loaded
                    ? const NoItem(
                        image: Constants.noFavClient,
                        text: 'لا يوجد وسطاء مفضلين ',
                      )
                    : Column(
                        children: [
                          Column(
                            children: List.generate(
                              state.favBrokers.length,
                              (index) => state.favBrokers[index]!.profile !=
                                      null
                                  ? BrokerCard(
                                      broker: state.favBrokers[index]!.profile!,
                                    )
                                  : const SizedBox.shrink(),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ],
        );
      },
    );
  }
}
