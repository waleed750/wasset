import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:waseet/constants/constants.dart';
import 'package:waseet/features/brokers/domain/repositories/brokers_repository.dart';
import 'package:waseet/features/brokers/presentation/kingdom_broker/cubit/cubit.dart';
import 'package:waseet/features/brokers/presentation/kingdom_broker/widgets/fav_broker_body.dart';
import 'package:waseet/features/brokers/presentation/kingdom_broker/widgets/kingdom_broker_body.dart';
import 'package:waseet/features/user/domain/entities/cities_entity.dart';
import 'package:waseet/features/user/domain/repositories/complaints_repository.dart';
import 'package:waseet/features/user/domain/repositories/home_repository.dart';
import 'package:waseet/res/helper_method.dart';

class KingdomBrokerPage extends StatelessWidget {
  const KingdomBrokerPage({
    super.key,
    this.city,
  });
  final CitiesEntity? city;
  static Route<dynamic> route({
    CitiesEntity? city,
  }) {
    return MaterialPageRoute<dynamic>(
      builder: (_) => KingdomBrokerPage(
        city: city,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => KingdomBrokerCubit(
        cityId: city?.id,
        brokerRepository: context.read<BrokerRepository>(),
        homeRepository: context.read<HomeRepository>(),
        complaintRepository: context.read<ComplaintRepository>(),
      ),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
            centerTitle: true,
            title: Text(
              city != null ? 'وسطاء ${city!.name}' : 'وسطاء المملكة',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            bottom: const TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: Color(0xFf8282DD),
              labelColor: Constants.primaryColor,
              unselectedLabelColor: Color(0xFFADB5BD),
              tabs: <Tab>[
                Tab(
                  text: 'جميع الوسطاء',
                ),
                Tab(
                  text: 'المفضلين',
                ),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              KingdomBrokerView(),
              FavBrokerView(),
            ],
          ),
        ),
      ),
    );
  }
}

class KingdomBrokerView extends StatelessWidget {
  const KingdomBrokerView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<KingdomBrokerCubit, KingdomBrokerState>(
      listener: (context, state) {
        if (state.status == BrokerStatus.removeLoading) {
          HelperMethod.showSnackBar(
            context,
            ' جاري حذف الوسيط ....',
          );
        }
        if (state.status == BrokerStatus.addLoading) {
          HelperMethod.showSnackBar(
            context,
            ' جاري اضافة الوسيط ....',
          );
        }
        if (state.status == BrokerStatus.addAndRemoveSuccess) {
          HelperMethod.showSnackBar(
            context,
            state.addAndRemoveBrokerMessage ?? 'تم بنجاح ',
            type: SnackBarType.success,
          );
        }
        if (state.status == BrokerStatus.addAndRemoveError) {
          HelperMethod.showSnackBar(
            context,
            state.errorMessage,
            type: SnackBarType.error,
          );
        }
        if (state.status == BrokerStatus.processLoading) {
          HelperMethod.showSnackBar(
            context,
            ' جاري تقديم البلاغ ....',
          );
        }
        if (state.status == BrokerStatus.processSuccess) {
          HelperMethod.showSnackBar(
            context,
            state.processMessage ?? 'تم تقديم البلاغ ',
            type: SnackBarType.success,
          );
        }
        if (state.status == BrokerStatus.processFailure) {
          HelperMethod.showSnackBar(
            context,
            state.processMessage ?? 'حدث خطأ ما',
            type: SnackBarType.error,
          );
        }
      },
      child: const KingdomBrokerBody(),
    );
  }
}

class FavBrokerView extends StatelessWidget {
  const FavBrokerView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<KingdomBrokerCubit, KingdomBrokerState>(
      listener: (context, state) {
        if (state.status == BrokerStatus.removeLoading) {
          HelperMethod.showSnackBar(
            context,
            ' جاري حذف الوسيط ....',
          );
        }
        if (state.status == BrokerStatus.addLoading) {
          HelperMethod.showSnackBar(
            context,
            ' جاري اضافة الوسيط ....',
          );
        }
        if (state.status == BrokerStatus.addAndRemoveSuccess) {
          HelperMethod.showSnackBar(
            context,
            state.addAndRemoveBrokerMessage ?? 'تم بنجاح ',
            type: SnackBarType.success,
          );
        }
        if (state.status == BrokerStatus.addAndRemoveError) {
          HelperMethod.showSnackBar(
            context,
            state.errorMessage,
            type: SnackBarType.error,
          );
        }
        if (state.status == BrokerStatus.processLoading) {
          HelperMethod.showSnackBar(
            context,
            ' جاري تقديم البلاغ ....',
          );
        }
        if (state.status == BrokerStatus.processSuccess) {
          HelperMethod.showSnackBar(
            context,
            state.processMessage ?? 'تم تقديم البلاغ ',
            type: SnackBarType.success,
          );
        }
        if (state.status == BrokerStatus.processFailure) {
          HelperMethod.showSnackBar(
            context,
            state.processMessage ?? 'حدث خطأ ما',
            type: SnackBarType.error,
          );
        }
      },
      child: const FavBrokerBody(),
    );
  }
}
