import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waseet/features/tahalf/domain/entities/tahalf_entity.dart';
import 'package:waseet/features/tahalf/presentation/tahalfat/widgets/tahalf_text_row.dart';
import 'package:waseet/res/enums/tahalf_type.dart';

class MyTahalfCard extends StatelessWidget {
  const MyTahalfCard({
    super.key,
    required this.tahalf,
    required this.limit,
  });

  final TahalfEntity tahalf;
  final int limit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20.h,
        ),
        TahalfTextRow(
          title: 'اسم التحالف',
          value: tahalf.name!,
        ),
        //   NN(tahalf: tahalf),
        SizedBox(
          height: 15.h,
        ),
        TahalfTextRow(
          title: 'نوع التحالف',
          value: tahalf.allianceType! == TahalfType.public.name
              ? TahalfType.public.arName
              : TahalfType.private.arName,
        ),
        SizedBox(
          height: 15.h,
        ),
        TahalfTextRow(
          title: 'المدينة',
          value: tahalf.city!.name,
        ),
        SizedBox(
          height: 15.h,
        ),
        TahalfTextRow(
          title: 'التخصص',
          value: tahalf.categories != null
              ? tahalf.categories!.map((e) => e.name).join('، ')
              : 'لا يوجد تخصص',
        ),
        SizedBox(
          height: 15.h,
        ),
        TahalfTextRow(
          title: 'الحالة',
          value: tahalf.members?.length == limit ? 'مكتمل' : 'غير مكتمل',
        ),
        SizedBox(
          height: 15.h,
        ),
        TahalfTextRow(
          title: 'العدد',
          value: tahalf.members?.length.toString() ?? '',
        ),
      ],
    );
  }
}
