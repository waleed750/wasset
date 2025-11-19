import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:waseet/common_widgets/card_popup_menu_item.dart';
import 'package:waseet/common_widgets/wasset_text_field.dart';
import 'package:waseet/features/tahalf/domain/entities/tahalf_entity.dart';
import 'package:waseet/features/tahalf/presentation/create_tahalf/cubit/cubit.dart';
import 'package:waseet/features/tahalf/presentation/tahalfat/cubit/tahalfat_cubit.dart';
import 'package:waseet/features/tahalf/presentation/tahalfat/widgets/tahalf_text_row.dart';
import 'package:waseet/features/user/presentation/register/widgets/wasset_button.dart';
import 'package:waseet/res/enums/broker_type.dart';
import 'package:waseet/res/enums/tahalf_type.dart';

class TahalfCard extends StatelessWidget {
  const TahalfCard({
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
        TahalfTextRow(
          title: 'اسم التحالف',
          value: tahalf.name!,
        ),
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
          title: 'نوع الوسيط',
          value: tahalf.wassetType!
              .map(
                (e) => e == BrokerType.office.name
                    ? BrokerType.office.arabicName
                    : BrokerType.wasset.arabicName,
              )
              .join('، '),
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
        Row(
          children: [
            const Text(
              'الحالة  :  ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 5, horizontal: 10).r,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8).r,
                color: tahalf.members?.length == limit
                    ? const Color.fromARGB(63, 255, 69, 69)
                    : const Color.fromARGB(63, 43, 193, 40),
              ),
              child: Text(
                tahalf.members?.length == limit ? 'مكتمل' : 'متاح',
                style: TextStyle(
                  color: tahalf.members?.length == limit
                      ? const Color.fromARGB(255, 255, 69, 69)
                      : const Color.fromARGB(255, 43, 193, 40),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 15.h,
        ),
        TahalfTextRow(
          title: 'العدد',
          value: tahalf.members?.length.toString() ?? '',
        ),
        SizedBox(
          height: 15.h,
        ),
        SizedBox(
          width: double.infinity,
          child: WassetButton(
            text: 'انضمام',
            onTap: () {
              if (tahalf.allianceType == TahalfType.private.name) {
                showCustomDialog(
                  context: context,
                  title: ' رمز المرور',
                  buttonText: 'انضمام',
                  body: WassetTextField(
                    hintText: 'اكتب رمز الدخول هنا ',
                    onChanged: (password) {
                      context.read<TahalfatCubit>().setPassWord(password);
                    },
                  ),
                  dailogButtonFunc: () {
                    context
                      ..read<TahalfatCubit>().attachToTahalf(tahalf.id!)
                      ..pop();
                  },
                );
              } else {
                context.read<TahalfatCubit>().attachToTahalf(tahalf.id!);
              }
            },
          ),
        ),
      ],
    );
  }
}
