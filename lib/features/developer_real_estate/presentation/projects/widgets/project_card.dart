import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:waseet/common_widgets/images_banner.dart';
import 'package:waseet/features/developer_real_estate/domain/entities/developer_project_entity.dart';
import 'package:waseet/res/res.dart';
import 'package:waseet/router/screens.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({
    super.key,
    required this.project,
    required this.showBrokerCommission,
  });

  final DeveloperProjectEntity project;
  final bool showBrokerCommission;

  @override
  Widget build(BuildContext context) {
    final imageUrl = _firstValidImage([
      project.cover,
      ...?project.images,
    ]);

    return GestureDetector(
      onTap: () {
        context.pushNamed(
          Screens.developerProjectDetails.name,
          extra: {
            'projectId': project.id,
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12).r,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image area
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: imageUrl != null
                        ? ImagesBanner(images: [imageUrl])
                        : ColoredBox(
                            color: Colors.grey.shade200,
                            child: Center(
                              child: Icon(
                                Icons.image_not_supported_outlined,
                                size: 40.r,
                                color: Colors.grey.shade400,
                              ),
                            ),
                          ),
                  ),
                  // subtle gradient for readability
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.12),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Content area
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and created
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          project.name,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (project.createdSince != null) SizedBox(width: 8.w),
                      if (project.createdSince != null)
                        Text(
                          project.createdSince!,
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: Colors.grey.shade600,
                          ),
                        ),
                    ],
                  ),

                  SizedBox(height: 8.h),

                  // Location
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: AppColors.primaryColor,
                        size: 16.sp,
                      ),
                      SizedBox(width: 6.w),
                      Expanded(
                        child: Text(
                          _buildLocationText(),
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.black87,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 12.h),

                  // Price and commission row
                  Row(
                    children: [
                      // Price column
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'يبدأ من',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              _buildPriceText(),
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Commission pill
                      if (showBrokerCommission &&
                          project.commissionPercentage != null)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 8.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(12).r,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '${project.commissionPercentage!.toStringAsFixed(0)}%',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                'عمولة الوسيط',
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? _firstValidImage(Iterable<String?> images) {
    for (final image in images) {
      final value = image?.trim();
      if (value != null && value.isNotEmpty) {
        return value;
      }
    }
    return null;
  }

  String _buildLocationText() {
    final parts = <String>[];
    if (project.city != null) parts.add(project.city!);
    if (project.neighborhood != null) parts.add(project.neighborhood!);

    if (parts.isEmpty) return 'غير محدد';
    return parts.join(' - ');
  }

  String _buildPriceText() {
    // if (project.priceMin != null && project.priceMax != null) {
    //   return 'من ${_formatPrice(project.priceMin!)} إلى ${_formatPrice(project.priceMax!)} ريال';
    // } else
    if (project.priceMin != null) {
      return ' ${_formatPrice(project.priceMin!)} ريال';
    } else if (project.priceMax != null) {
      return 'حتى ${_formatPrice(project.priceMax!)} ريال';
    }
    return 'السعر غير محدد';
  }

  String _formatPrice(double price) {
    if (price >= 1000000) {
      return '${(price / 1000000).toStringAsFixed(1)} مليون';
    } else if (price >= 1000) {
      return '${(price / 1000).toStringAsFixed(0)} ألف';
    }
    return price.toStringAsFixed(0);
  }
}
