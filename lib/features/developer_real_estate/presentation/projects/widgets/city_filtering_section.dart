import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waseet/constants/constants.dart';
import 'package:waseet/features/developer_real_estate/presentation/projects/cubit/cubit.dart';

class CityFilteringSection extends StatelessWidget {
  const CityFilteringSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeveloperProjectsCubit, DeveloperProjectsState>(
      builder: (context, state) {
        return state.cities.isEmpty
            ? const SizedBox.shrink()
            : Padding(
                padding: EdgeInsets.symmetric(vertical: 5.h),
                child: SizedBox(
                  height: 40.h,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Row(
                      children: [
                        // "الكل" option
                        Padding(
                          padding: EdgeInsets.only(left: 8.w),
                          child: GestureDetector(
                            onTap: () {
                              context
                                  .read<DeveloperProjectsCubit>()
                                  .selectCity(null);
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 220),
                              padding: EdgeInsets.symmetric(
                                horizontal: state.selectedCityId == null
                                    ? 18.w
                                    : 14.w,
                                vertical: 10.h,
                              ),
                              decoration: BoxDecoration(
                                color: state.selectedCityId == null
                                    ? Constants.primaryColor
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(28).r,
                                border: Border.all(
                                  color: state.selectedCityId == null
                                      ? Constants.primaryColor
                                      : Colors.grey.shade200,
                                ),
                                boxShadow: state.selectedCityId == null
                                    ? [
                                        BoxShadow(
                                          color: Constants.primaryColor
                                              .withOpacity(0.12),
                                          blurRadius: 8,
                                          offset: const Offset(0, 4),
                                        ),
                                      ]
                                    : null,
                              ),
                              child: Center(
                                child: Text(
                                  'الكل',
                                  style: TextStyle(
                                    color: state.selectedCityId == null
                                        ? Colors.white
                                        : Colors.black87,
                                    fontSize: 13.sp,
                                    fontWeight: state.selectedCityId == null
                                        ? FontWeight.w700
                                        : FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // City chips
                        ...state.cities.map((city) {
                          final isSelected = state.selectedCityId == city.id;
                          return Padding(
                            padding: EdgeInsets.only(left: 8.w),
                            child: GestureDetector(
                              onTap: () {
                                context
                                    .read<DeveloperProjectsCubit>()
                                    .selectCity(city.id);
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 220),
                                padding: EdgeInsets.symmetric(
                                  horizontal: isSelected ? 18.w : 14.w,
                                  vertical: 10.h,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Constants.primaryColor
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(28).r,
                                  border: Border.all(
                                    color: isSelected
                                        ? Constants.primaryColor
                                        : Colors.grey.shade200,
                                  ),
                                  boxShadow: isSelected
                                      ? [
                                          BoxShadow(
                                            color: Constants.primaryColor
                                                .withOpacity(0.12),
                                            blurRadius: 8,
                                            offset: const Offset(0, 4),
                                          ),
                                        ]
                                      : null,
                                ),
                                child: Center(
                                  child: Text(
                                    city.name,
                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.black87,
                                      fontSize: 13.sp,
                                      fontWeight: isSelected
                                          ? FontWeight.w700
                                          : FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }
}
