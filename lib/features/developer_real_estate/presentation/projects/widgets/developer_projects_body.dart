import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waseet/common_widgets/error.dart';
import 'package:waseet/common_widgets/no_items.dart';
import 'package:waseet/common_widgets/skeleton.dart';
import 'package:waseet/constants/constants.dart';
import 'package:waseet/features/developer_real_estate/presentation/projects/cubit/cubit.dart';
import 'package:waseet/features/developer_real_estate/presentation/projects/widgets/project_card.dart';

class DeveloperProjectsBody extends StatefulWidget {
  const DeveloperProjectsBody({super.key});

  @override
  State<DeveloperProjectsBody> createState() => _DeveloperProjectsBodyState();
}

class _DeveloperProjectsBodyState extends State<DeveloperProjectsBody> {
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
      context.read<DeveloperProjectsCubit>().loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeveloperProjectsCubit, DeveloperProjectsState>(
      builder: (context, state) {
        return Column(
          children: [
            // Categories horizontal list
            if (state.categories.isNotEmpty)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: SizedBox(
                  height: 56.h,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Row(
                      children: state.categories.map((category) {
                        final isSelected = state.selectedCategory == category.key;
                        return Padding(
                          padding: EdgeInsets.only(left: 8.w),
                          child: GestureDetector(
                            onTap: () {
                              context
                                  .read<DeveloperProjectsCubit>()
                                  .selectCategory(category.key);
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
                                  category.projectCount != null
                                      ? '${category.label} (${category.projectCount})'
                                      : category.label,
                                  style: TextStyle(
                                    color: isSelected ? Colors.white : Colors.black87,
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
                      }).toList(),
                    ),
                  ),
                ),
              ),

            // Loading state
            if (state.status == DeveloperProjectsStatus.loading)
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(10.r),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: Skeleton(
                        height: 279.h,
                        width: double.infinity,
                      ),
                    );
                  },
                ),
              ),

            // Error state
            if (state.status == DeveloperProjectsStatus.error)
              Expanded(
                child: ErrorPage(
                  onTap: () {
                    context.read<DeveloperProjectsCubit>().init();
                  },
                ),
              ),

            // Empty state
            if (state.status == DeveloperProjectsStatus.loaded &&
                state.projects.isEmpty)
              const Expanded(
                child: NoItem(
                  image: Constants.noAds,
                  text: 'لا توجد مشاريع',
                ),
              ),

            // Projects list
            if ((state.status == DeveloperProjectsStatus.loaded ||
                    state.status == DeveloperProjectsStatus.loadingMore) &&
                state.projects.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: EdgeInsets.all(10.r),
                  itemCount:
                      state.projects.length + (state.hasMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index >= state.projects.length) {
                      return state.status == DeveloperProjectsStatus.loadingMore
                          ? Padding(
                              padding: EdgeInsets.all(16.r),
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : const SizedBox.shrink();
                    }

                    return Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: ProjectCard(
                        project: state.projects[index],
                      ),
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
