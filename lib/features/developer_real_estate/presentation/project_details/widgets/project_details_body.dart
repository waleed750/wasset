import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:waseet/app/bloc/app_bloc.dart';
import 'package:waseet/common_widgets/images_banner.dart';
import 'package:waseet/features/developer_real_estate/data/models/developer_unit_model.dart';
import 'package:waseet/features/developer_real_estate/domain/entities/developer_project_entity.dart';
import 'package:waseet/features/developer_real_estate/domain/entities/developer_unit_entity.dart';
import 'package:waseet/features/developer_real_estate/presentation/project_details/cubit/cubit.dart';
import 'package:waseet/features/developer_real_estate/presentation/widgets/financing_selector.dart';
import 'package:waseet/features/user/presentation/register/widgets/wasset_button.dart';
import 'package:waseet/res/helper_method.dart';
import 'package:waseet/res/res.dart';
import 'package:waseet/router/screens.dart';

class ProjectDetailsBody extends StatefulWidget {
  const ProjectDetailsBody({super.key});

  @override
  State<ProjectDetailsBody> createState() => _ProjectDetailsBodyState();
}

class _ProjectDetailsBodyState extends State<ProjectDetailsBody> {
  @override
  Widget build(BuildContext context) {
    final showBrokerCommission =
        context.select((AppBloc bloc) => bloc.state.isWasset);

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

        final units = _parseProjectUnits(project.units);
        final projectImages = _galleryImages(project.cover, project.images);

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
                  child: projectImages.isNotEmpty
                      ? ImagesBanner(
                          images: projectImages,
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
                if (showBrokerCommission &&
                    project.commissionPercentage != null)
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
                const _SectionTitle(title: 'خيارات التمويل'),
                SizedBox(height: 12.h),
                if (project.financingOptions != null &&
                    project.financingOptions!.isNotEmpty)
                  FinancingSelector(options: project.financingOptions)
                else
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12.r),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10).r,
                      color: Colors.grey.shade100,
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Center(
                      child: Text(
                        'لا توجد خيارات تمويل',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ),
                SizedBox(height: 16.h),

                // Units Preview
                if (units.isNotEmpty) ...[
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
                          '${units.length} وحدة متاحة',
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
                            _showAllUnits(context, project.id, units);
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
                        await launchUrl(url,
                            mode: LaunchMode.externalApplication);
                      } else {
                        HelperMethod.showSnackBar(context, 'تعذر فتح الخريطة');
                      }
                    },
                  ),
                  SizedBox(height: 12.h),
                ],

                // Units horizontal preview
                if (units.isNotEmpty) ...[
                  SizedBox(height: 8.h),
                  SizedBox(
                    height: 120.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: units.length,
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      separatorBuilder: (_, __) => SizedBox(width: 12.w),
                      itemBuilder: (context, index) {
                        final unit = units[index];
                        return _UnitPreviewCard(
                          unit: unit,
                          onTap: () {
                            _openUnitDetails(context, project.id, unit);
                          },
                        );
                      },
                    ),
                  ),
                ],

                SizedBox(height: 20.h),
              ],
            ),
          ),
        );
      },
    );
  }

  List<DeveloperUnitEntity> _parseProjectUnits(List<dynamic>? rawUnits) {
    if (rawUnits == null) return [];
    return rawUnits
        .map(_parseProjectUnit)
        .whereType<DeveloperUnitEntity>()
        .toList();
  }

  DeveloperUnitEntity? _parseProjectUnit(dynamic rawUnit) {
    if (rawUnit is DeveloperUnitEntity) return rawUnit;
    if (rawUnit is DeveloperUnitModel) return rawUnit.toEntity();
    if (rawUnit is Map) {
      try {
        return DeveloperUnitModel.fromJson(Map<String, dynamic>.from(rawUnit))
            .toEntity();
      } catch (_) {
        final map = Map<String, dynamic>.from(rawUnit);
        return DeveloperUnitEntity(
          id: _parseUnitId(map['id']),
          name: _parseText(map['name']) ?? 'وحدة',
          unitCode: _parseText(map['unit_code']),
          unitTypeLabel: _parseText((map['unit_type'] as Map?)?['label']),
          area: _parseDouble(map['area']),
          price: _parseDouble(map['price']),
          cover: _parseText(map['cover']) ??
              _parseText(map['project_cover']) ??
              _parseText(map['main_image']) ??
              _firstImage(map['images']),
        );
      }
    }
    return null;
  }

  int _parseUnitId(dynamic value) {
    if (value is int) return value;
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  double? _parseDouble(dynamic value) {
    if (value is double) return value;
    if (value is int) return value.toDouble();
    return double.tryParse(value?.toString() ?? '');
  }

  String? _parseText(dynamic value) {
    final text = value?.toString().trim();
    return text == null || text.isEmpty ? null : text;
  }

  String? _firstImage(dynamic images) {
    if (images is List && images.isNotEmpty) {
      return _parseText(images.first);
    }
    return _parseText(images);
  }

  List<String> _galleryImages(String? cover, List<String>? images) {
    final values = <String>[];
    for (final image in [cover, ...?images]) {
      final value = _parseText(image);
      if (value != null && !values.contains(value)) {
        values.add(value);
      }
    }
    return values;
  }

  void _openUnitDetails(
    BuildContext context,
    int projectId,
    DeveloperUnitEntity unit,
  ) {
    if (unit.id <= 0) {
      HelperMethod.showSnackBar(context, 'تعذر فتح تفاصيل الوحدة');
      return;
    }

    context.pushNamed(
      Screens.developerUnitDetails.name,
      extra: {
        'unitId': unit.id,
        'projectId': projectId,
      },
    );
  }

  void _showAllUnits(
    BuildContext context,
    int projectId,
    List<DeveloperUnitEntity> units,
  ) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18.r)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: SizedBox(
            height: MediaQuery.sizeOf(sheetContext).height * 0.75,
            child: Column(
              children: [
                SizedBox(height: 10.h),
                Container(
                  width: 44.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(99).r,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 8.h),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'الوحدات المتاحة (${units.length})',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.of(sheetContext).pop(),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
                    itemCount: units.length,
                    separatorBuilder: (_, __) => SizedBox(height: 10.h),
                    itemBuilder: (_, index) {
                      final unit = units[index];
                      return _UnitListItem(
                        unit: unit,
                        onTap: () {
                          Navigator.of(sheetContext).pop();
                          _openUnitDetails(context, projectId, unit);
                        },
                      );
                    },
                  ),
                ),
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

class _UnitPreviewCard extends StatelessWidget {
  const _UnitPreviewCard({
    required this.unit,
    required this.onTap,
  });

  final DeveloperUnitEntity unit;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
            Expanded(child: _UnitImage(unit: unit)),
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
              _formatUnitPrice(unit.price),
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UnitListItem extends StatelessWidget {
  const _UnitListItem({
    required this.unit,
    required this.onTap,
  });

  final DeveloperUnitEntity unit;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10).r,
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10).r,
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 92.w,
              height: 74.h,
              child: _UnitImage(unit: unit),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    unit.name,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 6.h),
                  if (unit.unitTypeLabel != null || unit.area != null)
                    Text(
                      [
                        if (unit.unitTypeLabel != null) unit.unitTypeLabel!,
                        if (unit.area != null) '${unit.area} متر مربع',
                      ].join(' - '),
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey.shade700,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  SizedBox(height: 6.h),
                  Text(
                    _formatUnitPrice(unit.price),
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16.sp,
              color: AppColors.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}

class _UnitImage extends StatelessWidget {
  const _UnitImage({required this.unit});

  final DeveloperUnitEntity unit;

  @override
  Widget build(BuildContext context) {
    if (unit.cover != null && unit.cover!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8).r,
        child: ImagesBanner(images: [unit.cover!]),
      );
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8).r,
      ),
      child: Icon(
        Icons.image_not_supported_outlined,
        color: Colors.grey.shade400,
      ),
    );
  }
}

String _formatUnitPrice(double? price) {
  if (price == null) return 'السعر غير محدد';
  return '${price.toStringAsFixed(0)} ريال';
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
