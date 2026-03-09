import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:waseet/common_widgets/images_banner.dart';
import 'package:waseet/features/developer_real_estate/domain/entities/developer_project_entity.dart';
import 'package:waseet/constants/constants.dart';
import 'package:waseet/features/developer_real_estate/domain/entities/developer_unit_entity.dart';
import 'package:waseet/features/developer_real_estate/data/models/developer_unit_model.dart';
import 'package:waseet/features/developer_real_estate/presentation/project_details/cubit/cubit.dart';
import 'package:waseet/features/user/presentation/register/widgets/wasset_button.dart';
import 'package:waseet/res/res.dart';
import 'package:waseet/res/helper_method.dart';
import 'package:go_router/go_router.dart';
import 'package:waseet/router/screens.dart';

class ProjectDetailsBody extends StatelessWidget {
  const ProjectDetailsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectDetailsCubit, ProjectDetailsState>(
      builder: (context, state) {
        if (state.status == ProjectDetailsStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.status == ProjectDetailsStatus.error) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(20.r),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.errorMessage,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.red,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.h),
                  WassetButton(
                    text: 'إعادة المحاولة',
                    onTap: () {
                      context.read<ProjectDetailsCubit>().init();
                    },
                  ),
                ],
              ),
            ),
          );
        }

        final project = state.project;
        if (project == null) {
          return const Center(child: Text('لا توجد بيانات'));
        }

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Images Gallery (show placeholder if no images)
                Container(
                  height: 0.3.sh,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10).r,
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: project.images != null && project.images!.isNotEmpty
                      ? ImagesBanner(
                          images: project.images!,
                        )
                      : ColoredBox(
                          color: Colors.grey.shade100,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.image_not_supported_outlined,
                                  size: 48.r,
                                  color: Colors.grey.shade400,
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  'لا توجد صور',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                ),
                SizedBox(height: 16.h),

                // Project Name
                Text(
                  project.name,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8.h),

                // Developer Info
                if (project.developerName != null)
                  _InfoRow(
                    icon: Icons.business,
                    label: 'المطور',
                    value: project.developerName!,
                  ),
                SizedBox(height: 12.h),

                // Location
                _InfoRow(
                  icon: Icons.location_on,
                  label: 'الموقع',
                  value: _buildLocationText(project),
                ),
                SizedBox(height: 12.h),

                // Price Range
                if (project.priceMin != null || project.priceMax != null)
                  _InfoRow(
                    icon: Icons.attach_money,
                    label: 'نطاق الأسعار',
                    value: _buildPriceText(project),
                  ),
                SizedBox(height: 12.h),

                // // Starting Price
                // if (project.unitStartingFrom != null)
                //   _InfoRow(
                //     icon: Icons.money,
                //     label: 'الوحدات تبدأ من',
                //     value: '${_formatPrice(project.unitStartingFrom!)} ريال',
                //   ),
                // SizedBox(height: 12.h),

                // Commission
                if (project.commissionPercentage != null)
                  _InfoRow(
                    icon: Icons.percent,
                    label: 'نسبة العمولة',
                    value: '${project.commissionPercentage}%',
                  ),
                SizedBox(height: 16.h),

                // Description
                if (project.description != null &&
                    project.description!.isNotEmpty) ...[
                  const _SectionTitle(title: 'وصف المشروع'),
                  SizedBox(height: 8.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12.r),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10).r,
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                    child: Text(
                      project.description!,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                ],

                // Visiting Times
                if (project.visitingTimeFrom != null ||
                    project.visitingTimeTo != null) ...[
                  const _SectionTitle(title: 'أوقات الزيارة'),
                  SizedBox(height: 8.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12.r),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10).r,
                      color: AppColors.primaryColor.withOpacity(0.1),
                    ),
                    child: Text(
                      'من ${project.visitingTimeFrom ?? "---"} إلى ${project.visitingTimeTo ?? "---"}',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 16.h),
                ],

                // Financing Options
                if (project.financingOptions != null &&
                    project.financingOptions!.isNotEmpty) ...[
                  const _SectionTitle(title: 'خيارات التمويل'),
                  SizedBox(height: 8.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12.r),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10).r,
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                    child: Text(
                      project.financingOptions!.join('\n• '),
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                ],

                // Units Preview
                if (project.units != null && project.units!.isNotEmpty) ...[
                  const _SectionTitle(title: 'الوحدات المتاحة'),
                  SizedBox(height: 8.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10).r,
                      color: AppColors.primaryColor.withOpacity(0.1),
                    ),
                    child: Column(
                      children: [
                        Text(
                          '${project.units!.length} وحدة متاحة',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        WassetButton(
                          text: 'عرض جميع الوحدات',
                          onTap: () {
                            HelperMethod.showSnackBar(context, 'قريباً');
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                ],

                // Location Map CTA
                if (project.mapUrl != null && project.mapUrl!.isNotEmpty) ...[
                  WassetButton(
                    text: 'عرض الموقع على الخريطة',
                    backgroundColor: Colors.white,
                    textColor: AppColors.primaryColor,
                    onTap: () async {
                        final url = Uri.parse(project.mapUrl!);
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url, mode: LaunchMode.externalApplication);
                        } else {
                          HelperMethod.showSnackBar(context, 'تعذر فتح الخريطة');
                        }
                    },
                  ),
                  SizedBox(height: 12.h),
                ],

                // Contact CTA
                if (project.contactPhone != null &&
                    project.contactPhone!.isNotEmpty) ...[
                  WassetButton(
                    text: 'التواصل للاستفسار',
                    onTap: () async {
                      final phone = project.contactPhone!;
                      await HelperMethod.openCall(phone, context);
                    },
                  ),
                  SizedBox(height: 12.h),
                ],
                // Units horizontal preview
                SizedBox(height: 8.h),
                SizedBox(
                  height: 120.h,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: project.units!.length,
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    separatorBuilder: (_, __) => SizedBox(width: 12.w),
                    itemBuilder: (context, index) {
                      final rawUnit = project.units![index];
                      DeveloperUnitEntity unit;

                      if (rawUnit is DeveloperUnitEntity) {
                        unit = rawUnit;
                      } else if (rawUnit is DeveloperUnitModel) {
                        unit = rawUnit.toEntity();
                      } else if (rawUnit is Map) {
                        try {
                          unit = DeveloperUnitModel.fromJson(Map<String, dynamic>.from(rawUnit)).toEntity();
                        } catch (_) {
                          // Fallback: build a minimal entity using available keys
                          final map = Map<String, dynamic>.from(rawUnit);
                          unit = DeveloperUnitEntity(
                            id: map['id'] is int ? map['id'] as int : int.tryParse(map['id']?.toString() ?? '0') ?? 0,
                            name: map['name']?.toString() ?? 'وحدة',
                            cover: map['cover'] as String?,
                          );
                        }
                      } else {
                        // Unknown type - skip rendering this item
                        return const SizedBox.shrink();
                      }

                      return GestureDetector(
                        onTap: () {
                          context.pushNamed(
                            Screens.developerUnitDetails.name,
                            extra: {
                              'unitId': unit.id,
                              'projectId': project.id,
                            },
                          );
                        },
                        child: Container(
                          width: 220.w,
                          padding: EdgeInsets.all(8.r),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8).r,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primaryColor.withOpacity(0.08),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: unit.cover != null && unit.cover!.isNotEmpty
                                    ? ImagesBanner(images: [unit.cover!])
                                    : Container(
                                        color: Colors.grey.shade200,
                                      ),
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                unit.name,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                unit.price != null ? '${unit.price!.toStringAsFixed(0)} ريال' : 'السعر غير محدد',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(height: 20.h),
              ],
            ),
          ),
        );
      },
    );
  }

  String _buildLocationText(DeveloperProjectEntity project) {
    final parts = <String>[];
    if (project.city != null) parts.add(project.city!);
    if (project.neighborhood != null) parts.add(project.neighborhood!);

    if (parts.isEmpty) return 'غير محدد';
    return parts.join(' - ');
  }

  String _buildPriceText(DeveloperProjectEntity project) {
    if (project.priceMin != null && project.priceMax != null) {
      return 'من ${_formatPrice(project.priceMin!)} إلى ${_formatPrice(project.priceMax!)} ريال';
    } else if (project.priceMin != null) {
      return 'من ${_formatPrice(project.priceMin!)} ريال';
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

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryColor,
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: AppColors.primaryColor,
          size: 20.sp,
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
