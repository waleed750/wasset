// ignore_for_file: inference_failure_on_function_invocation

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:waseet/features/tahalf/presentation/tahalfat/cubit/cubit.dart';
import 'package:waseet/features/tahalf/presentation/tahalfat/widgets/tahalf_bottom_sheet.dart';
import 'package:waseet/features/user/presentation/home_page/widgets/custom_text_field.dart';
import 'package:waseet/res/assets/assets.gen.dart';

class TahalfatSearchAndFilter extends StatelessWidget {
  const TahalfatSearchAndFilter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      onChanged: (name) {
        context.read<TahalfatCubit>().searchByName(name);
      },
      hintText: 'ابحث عن تحالف',
      prefixIcon: IconButton(
        onPressed: () {
          // context.read<TahalfatCubit>().searchByName();
        },
        icon: const Icon(Icons.search),
      ),
      suffixIcon: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(5).r,
          child: SvgPicture.asset(
            Assets.icons.filter.path,
          ),
        ),
        onTap: () {
          showBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            builder: (context) {
              return const TahalfatBottomSheet();
            },
          );
        },
      ),
    );
  }
}
