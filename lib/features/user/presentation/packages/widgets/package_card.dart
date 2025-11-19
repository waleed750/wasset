import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:waseet/features/brokers/presentation/kingdom_broker/cubit/cubit.dart';
import 'package:waseet/features/user/domain/entities/packages_entity.dart';
import 'package:waseet/features/user/presentation/packages/cubit/packages_cubit.dart';
import 'package:waseet/features/user/presentation/register/widgets/wasset_button.dart';
import 'package:waseet/res/assets/assets.gen.dart';
import 'package:waseet/res/res.dart';
import 'package:waseet/router/screens.dart';

class PackageCard extends StatelessWidget {
  const PackageCard({
    super.key,
    required this.package,
  });

  final PackagesEntity package;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.withOpacity(0.3),
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Assets.icons.subscribe.svg(
                            width: 36,
                            height: 36,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  package.duration ?? '',
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  package.price ?? '',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 30,
                        ),
                        width: double.infinity,
                        child: WassetButton(
                          text: 'اشترك الان',
                          onTap: () {
                            context
                                .read<PackagesCubit>()
                                .selectPackage(package);
                            context.pushNamed(
                              Screens.payment.name,
                              extra: context.read<PackagesCubit>(),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 20,
                  ),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF7F7FC),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'تحتوي على',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ...List.generate(
                        package.features?.length ?? 0,
                        (index) => Row(
                          children: [
                            const Icon(
                              Icons.check_circle,
                              size: 12,
                              color: AppColors.primaryColor,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              package.features?[index] ?? '',
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
