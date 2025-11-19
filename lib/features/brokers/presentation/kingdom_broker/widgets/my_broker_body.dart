import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:waseet/common_widgets/error.dart';
import 'package:waseet/common_widgets/skeleton.dart';
import 'package:waseet/common_widgets/wasset_app_bar.dart';
import 'package:waseet/constants/constants.dart';
import 'package:waseet/features/brokers/presentation/kingdom_broker/cubit/cubit.dart';
import 'package:waseet/features/brokers/presentation/kingdom_broker/widgets/broker_card.dart';
import 'package:waseet/features/brokers/presentation/kingdom_broker/widgets/brokers_search_and_filter.dart';
import 'package:waseet/features/brokers/presentation/kingdom_broker/widgets/kingdom_broker_body.dart';

class MyBrokerBody extends StatelessWidget {
  const MyBrokerBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KingdomBrokerCubit, KingdomBrokerState>(
      builder: (context, state) {
        return SafeArea(
          child: Column(
            children: [
              const WassetAppBar(
                title: 'وسطائي',
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: BrokersSearchAndFilter(),
              ),
              if (state.status == BrokerStatus.loading)
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: BrokerSkeleton(),
                ),
              if (state.status == BrokerStatus.error)
                ErrorPage(
                  onTap: () {
                    context.read<KingdomBrokerCubit>().init();
                  },
                ),
              Expanded(
                child: SingleChildScrollView(
                  child: state.favBrokers.isEmpty &&
                          state.status != BrokerStatus.loading
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(Constants.noFavClient),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              'لا يوجد وسطاء مفضلين',
                              style: TextStyle(
                                color: const Color(0xff8083A3),
                                fontSize: 19.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            Column(
                              children: List.generate(
                                state.favBrokers.length,
                                (index) =>
                                    state.favBrokers[index]!.profile != null
                                        ? BrokerCard(
                                            broker: state
                                                .favBrokers[index]!.profile!,
                                          )
                                        : const SizedBox.shrink(),
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
