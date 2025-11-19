import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waseet/common_widgets/skeleton.dart';
import 'package:waseet/constants/constants.dart';
import 'package:waseet/features/user/presentation/home_page/cubit/cubit.dart';

class CustomSlider extends StatelessWidget {
  const CustomSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageCubit, HomePageState>(
      builder: (context, state) {
        return Column(
          children: [
            if (state.sliders.isNotEmpty ||
                state.status == HomePageStatus.error &&
                    state.sliders.isNotEmpty)
              ImageSlideshow(
                indicatorColor: Colors.white,
                indicatorRadius: 3.5,
                height: 150,
                autoPlayInterval: 5000,
                isLoop: true,
                indicatorBackgroundColor: Colors.grey.withOpacity(0.57),
                children: List.generate(
                  state.sliders.length,
                  (index) => Container(
                    width: double.infinity,
                    height: 150.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                          state.sliders[index].image,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            if (state.status == HomePageStatus.error && state.sliders.isEmpty)
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
            if (state.status == HomePageStatus.loading && state.sliders.isEmpty)
              Skeleton(height: 150.h, width: double.infinity),
          ],
        );
      },
    );
  }
}
