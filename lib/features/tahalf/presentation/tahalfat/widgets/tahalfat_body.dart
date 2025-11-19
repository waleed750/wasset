import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:waseet/common_widgets/broker_item_icon.dart';
import 'package:waseet/common_widgets/card_popup_menu_item.dart';
import 'package:waseet/common_widgets/error.dart';
import 'package:waseet/common_widgets/wasset_text_field.dart';
import 'package:waseet/features/tahalf/presentation/tahalfat/cubit/tahalfat_cubit.dart';
import 'package:waseet/features/tahalf/presentation/tahalfat/widgets/no_tahalfat.dart';
import 'package:waseet/features/tahalf/presentation/tahalfat/widgets/tahalfat_card.dart';
import 'package:waseet/features/tahalf/presentation/tahalfat/widgets/tahalfat_search_and_filter.dart';
import 'package:waseet/features/tahalf/presentation/tahalfat/widgets/tahalfat_skeleton.dart';
import 'package:waseet/features/user/presentation/profile_info/profile_info.dart';
import 'package:waseet/res/enums/tahalf_type.dart';
import 'package:waseet/res/res.dart';

class TahalfatBody extends StatelessWidget {
  const TahalfatBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TahalfatCubit, TahalfatState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10).r,
                child: const TahalfatSearchAndFilter(),
              ),
              if (state.status == TahalfatStatus.loading)
                const TahalfatSkeleton(),
              if (state.status == TahalfatStatus.error)
                ErrorPage(
                  onTap: () {
                    context.read<TahalfatCubit>().init();
                  },
                ),
              if (state.status == TahalfatStatus.loaded &&
                  state.tahalfList.isEmpty)
                const NoTahalfat(),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.tahalfList.length,
                itemBuilder: (context, index) {
                  final tahalf = state.tahalfList[index];
                  final int limit;
                  if (tahalf.allianceType == TahalfType.public.name) {
                    limit = 50;
                  } else {
                    limit = 5;
                  }
                  return Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ).r,
                        padding: const EdgeInsets.all(15).r,
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(101, 115, 50, 255),
                              blurRadius: 4,
                              offset: Offset(0, 1.68),
                            ),
                          ],
                          border: Border(
                            right: BorderSide(
                              width: 20.w,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          borderRadius: BorderRadius.circular(16).r,
                          color: Colors.white,
                        ),
                        width: double.infinity,
                        child: TahalfCard(tahalf: tahalf, limit: limit),
                      ),
                      Positioned(
                        top: 20,
                        left: 25,
                        child: BrokerItemIcon(
                          onTap: () {
                            showCustomDialog(
                              context: context,
                              title: 'بلاغ عن تحالف ',
                              buttonText: 'ارسال',
                              body: WassetTextField(
                                maxLines: 3,
                                hintText: 'اكتب السبب هنا ',
                                onChanged: (description) {
                                  context
                                      .read<TahalfatCubit>()
                                      .setDescription(description);
                                },
                              ),
                              dailogButtonFunc: () {
                                context
                                  ..read<TahalfatCubit>()
                                      .createComplaint(allianceId: tahalf.id!)
                                  ..pop();
                              },
                            );
                          },
                          icon: Icons.report,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
