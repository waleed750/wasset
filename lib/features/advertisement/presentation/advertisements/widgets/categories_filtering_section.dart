import 'package:flutter/material.dart';
import 'package:waseet/constants/constants.dart';
import 'package:waseet/features/advertisement/presentation/advertisements/advertisements.dart';
import 'package:waseet/res/res.dart';

class CategoriesFilteringSection extends StatelessWidget {
  const CategoriesFilteringSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdvertisementsCubit, AdvertisementsState>(
      builder: (context, state) {
        return state.categories.isEmpty
            ? const SizedBox.shrink()
            : Container(
                height: 30,
                margin: const EdgeInsets.only(bottom: 10),
                child: ListView.builder(
                  itemCount: state.categories.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        context
                            .read<AdvertisementsCubit>()
                            .filteringByCategories(index);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                        ),
                        decoration: BoxDecoration(
                          color: state.isSelect![index] == true
                              ? Constants.primaryColor
                              : null,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: state.isSelect![index] == true
                                ? Constants.primaryColor
                                : AppColors.secondaryTextColor,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            state.categories[index]!.name ?? '',
                            style: TextStyle(
                              color: state.isSelect![index] == true
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
      },
    );
  }
}
