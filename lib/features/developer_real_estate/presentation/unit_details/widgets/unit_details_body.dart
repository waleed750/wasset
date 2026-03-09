import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:waseet/common_widgets/images_banner.dart';
import 'package:waseet/features/developer_real_estate/domain/entities/developer_unit_entity.dart';
import 'package:waseet/features/developer_real_estate/presentation/unit_details/cubit/cubit.dart';
import 'package:waseet/features/user/presentation/register/widgets/wasset_button.dart';
import 'package:waseet/res/res.dart';

class UnitDetailsBody extends StatelessWidget {
  const UnitDetailsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UnitDetailsCubit, UnitDetailsState>(
      builder: (context, state) {
        if (state.status == UnitDetailsStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.status == UnitDetailsStatus.error) {
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
                      context.read<UnitDetailsCubit>().init();
                    },
                  ),
                ],
              ),
            ),
          );
        }

        final unit = state.unit;
        if (unit == null) {
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
                  child: unit.images != null && unit.images!.isNotEmpty
                      ? ImagesBanner(
                          images: unit.images!,
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

                // Unit Name
                Text(
                  unit.name,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8.h),

                // Unit Code
                if (unit.unitCode != null && unit.unitCode!.isNotEmpty)
                  Text(
                    'كود الوحدة: ${unit.unitCode}',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey,
                    ),
                  ),
                SizedBox(height: 12.h),

                // Basic Info Section
                const _SectionTitle(title: 'المعلومات الأساسية'),
                SizedBox(height: 8.h),

                // Unit Type
                if (unit.unitTypeLabel != null)
                  _InfoRow(
                    icon: Icons.home,
                    label: 'نوع الوحدة',
                    value: unit.unitTypeLabel!,
                  ),
                SizedBox(height: 12.h),

                // Price
                if (unit.price != null)
                  _InfoRow(
                    icon: Icons.attach_money,
                    label: 'السعر',
                    value: '${_formatPrice(unit.price!)} ريال',
                  ),
                SizedBox(height: 12.h),

                // Area
                if (unit.area != null)
                  _InfoRow(
                    icon: Icons.square_foot,
                    label: 'المساحة',
                    value: '${unit.area} متر مربع',
                  ),
                SizedBox(height: 12.h),

                // Availability Status
                if (unit.availabilityStatus != null &&
                    unit.availabilityStatus!.isNotEmpty)
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color: _getStatusColor(unit.availabilityStatus!)
                          .withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8).r,
                      border: Border.all(
                        color: _getStatusColor(unit.availabilityStatus!),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: _getStatusColor(unit.availabilityStatus!),
                          size: 18.sp,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          _getStatusText(unit.availabilityStatus!),
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: _getStatusColor(unit.availabilityStatus!),
                          ),
                        ),
                      ],
                    ),
                  ),
                SizedBox(height: 16.h),

                // Details Section
                const _SectionTitle(title: 'التفاصيل'),
                SizedBox(height: 8.h),

                // Rooms
                if (unit.roomsCount != null)
                  _DetailRow(
                    label: 'عدد الغرف',
                    value: '${unit.roomsCount}',
                  ),
                if (unit.roomsCount != null) SizedBox(height: 8.h),

                // Bathrooms
                if (unit.bathroomsCount != null)
                  _DetailRow(
                    label: 'عدد دورات المياه',
                    value: '${unit.bathroomsCount}',
                  ),
                if (unit.bathroomsCount != null) SizedBox(height: 8.h),

                // Halls
                if (unit.hallsCount != null)
                  _DetailRow(
                    label: 'عدد الصالات',
                    value: '${unit.hallsCount}',
                  ),
                if (unit.hallsCount != null) SizedBox(height: 8.h),

                // Others
                if (unit.others != null && unit.others!.isNotEmpty)
                  _DetailRow(
                    label: 'تفاصيل إضافية',
                    value: unit.others!,
                  ),
                SizedBox(height: 16.h),

                // Description
                if (unit.description != null && unit.description!.isNotEmpty) ...[
                  const _SectionTitle(title: 'وصف الوحدة'),
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
                      unit.description!,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                ],

                // Related Project Info
                if (unit.projectName != null || unit.projectDeveloperName != null) ...[
                  const _SectionTitle(title: 'معلومات المشروع'),
                  SizedBox(height: 8.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12.r),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10).r,
                      color: AppColors.primaryColor.withOpacity(0.05),
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.3),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Project Name
                        if (unit.projectName != null) ...[
                          Row(
                            children: [
                              Icon(
                                Icons.apartment,
                                color: AppColors.primaryColor,
                                size: 18.sp,
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: Text(
                                  unit.projectName!,
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                        ],

                        // Developer Name
                        if (unit.projectDeveloperName != null) ...[
                          Row(
                            children: [
                              Icon(
                                Icons.business,
                                color: AppColors.primaryColor,
                                size: 18.sp,
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: Text(
                                  unit.projectDeveloperName!,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                        ],

                        // Location
                        if (unit.projectCity != null ||
                            unit.projectNeighborhood != null) ...[
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: AppColors.primaryColor,
                                size: 18.sp,
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: Text(
                                  _buildProjectLocation(unit),
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                        ],

                        // Commission
                        if (unit.projectCommission != null)
                          Row(
                            children: [
                              Icon(
                                Icons.percent,
                                color: AppColors.primaryColor,
                                size: 18.sp,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                'عمولة ${unit.projectCommission}%',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                ],

                // Financing Options
                if (unit.financingOptions != null &&
                    unit.financingOptions!.isNotEmpty) ...[
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
                      unit.financingOptions!.join('\n• '),
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                ],

                // Location Map CTA
                if (unit.projectLocationUrl != null &&
                    unit.projectLocationUrl!.isNotEmpty) ...[
                  WassetButton(
                    text: 'عرض الموقع على الخريطة',
                    backgroundColor: Colors.white,
                    textColor: AppColors.primaryColor,
                    onTap: () async {
                      final url = Uri.parse(unit.projectLocationUrl!);
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url,
                            mode: LaunchMode.externalApplication,);
                      }
                    },
                  ),
                  SizedBox(height: 12.h),
                ],

                // Contact CTA
                if (unit.projectContactPhone != null &&
                    unit.projectContactPhone!.isNotEmpty) ...[
                  WassetButton(
                    text: 'التواصل للاستفسار',
                    onTap: () async {
                      final phone = unit.projectContactPhone!;
                      final url = Uri.parse('tel:$phone');
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                      }
                    },
                  ),
                  SizedBox(height: 12.h),
                ],

                SizedBox(height: 20.h),
              ],
            ),
          ),
        );
      },
    );
  }

  String _buildProjectLocation(DeveloperUnitEntity unit) {
    final parts = <String>[];
    if (unit.projectCity != null) parts.add(unit.projectCity!);
    if (unit.projectNeighborhood != null) parts.add(unit.projectNeighborhood!);

    if (parts.isEmpty) return 'غير محدد';
    return parts.join(' - ');
  }

  String _formatPrice(double price) {
    if (price >= 1000000) {
      return '${(price / 1000000).toStringAsFixed(1)} مليون';
    } else if (price >= 1000) {
      return '${(price / 1000).toStringAsFixed(0)} ألف';
    }
    return price.toStringAsFixed(0);
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'available':
      case 'متاحة':
        return Colors.green;
      case 'reserved':
      case 'محجوزة':
        return Colors.orange;
      case 'sold':
      case 'مباعة':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _getStatusText(String status) {
    switch (status.toLowerCase()) {
      case 'available':
        return 'متاحة';
      case 'reserved':
        return 'محجوزة';
      case 'sold':
        return 'مباعة';
      default:
        return status;
    }
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

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8).r,
        color: Colors.grey.withOpacity(0.1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.black87,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
