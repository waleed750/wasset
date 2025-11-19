import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:waseet/features/brokers/presentation/kingdom_broker/cubit/cubit.dart';
import 'package:waseet/features/brokers/presentation/kingdom_broker/widgets/broker_bottom_sheet.dart';
import 'package:waseet/features/user/presentation/home_page/widgets/custom_text_field.dart';
import 'package:waseet/res/assets/assets.gen.dart';

class BrokersSearchAndFilter extends StatelessWidget {
  const BrokersSearchAndFilter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      onChanged: (name) {
        context.read<KingdomBrokerCubit>().setSearchKey(name);
        context.read<KingdomBrokerCubit>().searchByName();
      },
      hintText: 'ابحث عن وسيط',
      prefixIcon: IconButton(
        onPressed: () {
          context.read<KingdomBrokerCubit>().searchByName();
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
          showCustomBottomSheet(context);
        },
      ),
    );
  }

  PersistentBottomSheetController showCustomBottomSheet(
    BuildContext context,
  ) {
    return showBottomSheet(
      context: context,
      builder: (context) {
        return const BrokerBottomSheet();
      },
    );
  }
}
