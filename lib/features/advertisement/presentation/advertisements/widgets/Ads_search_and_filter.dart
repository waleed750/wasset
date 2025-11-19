import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:waseet/features/advertisement/presentation/advertisements/cubit/advertisements_cubit.dart';
import 'package:waseet/features/advertisement/presentation/advertisements/widgets/ads_bottom_sheet.dart';
import 'package:waseet/features/user/presentation/home_page/widgets/custom_text_field.dart';
import 'package:waseet/res/assets/assets.gen.dart';

class AdsSearchAndFilter extends StatelessWidget {
  const AdsSearchAndFilter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      onChanged: (name) {
        context.read<AdvertisementsCubit>().setSearchKey(name);
        context.read<AdvertisementsCubit>().searchByName();
      },
      hintText: 'ابحث عن اعلان',
      prefixIcon: IconButton(
        onPressed: () {
          context.read<AdvertisementsCubit>().searchByName();
        },
        icon: const Icon(Icons.search),
      ),
      suffixIcon: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: SvgPicture.asset(
            Assets.icons.filter.path,
          ),
        ),
        onTap: () {
          showBottomSheet(
            context: context,
            builder: (context) {
              return const AdsBottomSheet();
            },
          );
        },
      ),
    );
  }
}
