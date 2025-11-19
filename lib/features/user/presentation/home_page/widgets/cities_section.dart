import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waseet/constants/constants.dart';
import 'package:waseet/features/user/presentation/home_page/home_page.dart';
import 'package:waseet/features/user/presentation/home_page/widgets/city_item.dart';
import 'package:waseet/features/user/presentation/home_page/widgets/shimmer_cities.dart';

class CitiesSection extends StatelessWidget {
  const CitiesSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageCubit, HomePageState>(
      builder: (context, state) {
        return Column(
          children: [
            if (state.cities.isNotEmpty ||
                state.status == HomePageStatus.error && state.cities.isNotEmpty)
              Wrap(
                children: List.generate(
                  state.cities.length,
                  (index) => Padding(
                    padding: const EdgeInsets.all(8).r,
                    child: CityItem(
                      city: state.cities[index],
                    ),
                  ),
                ),
              ),
            if (state.status == HomePageStatus.error && state.cities.isEmpty)
              SizedBox(
                height: 150.h,
                child: Center(
                  child: IconButton(
                    icon: const Icon(
                      Icons.refresh,
                      size: 40,
                      color: Constants.primaryColor,
                    ),
                    onPressed: () {
                      context.read<HomePageCubit>().init();
                    },
                  ),
                ),
              ),
            if (state.status == HomePageStatus.loading && state.cities.isEmpty)
              const ShimmerCities(),
          ],
        );
      },
    );
  }
}
