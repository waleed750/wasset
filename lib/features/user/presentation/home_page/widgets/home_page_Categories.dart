import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:waseet/constants/constants.dart';
import 'package:waseet/features/user/presentation/home_page/widgets/category_item.dart';
import 'package:waseet/router/screens.dart';

class HomepageCategories extends StatelessWidget {
  const HomepageCategories({
    super.key,
    required this.isWasset,
  });
  final bool isWasset;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20).r,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (isWasset == false)
                CategoryItem(
                  onTap: () {
                    context.pushNamed(Screens.myBroker.name);
                  },
                  text: 'وسطائي',
                  image: Constants.myBrokers,
                ),
              CategoryItem(
                onTap: () {
                  context.pushNamed(Screens.goldenBrokers.name);
                },
                text: 'وسطاء ذهبيين',
                image: Constants.goldenBrokers,
              ),
              if (isWasset == true)
                CategoryItem(
                  text: 'مكتبي',
                  image: Constants.myOffice,
                  onTap: () {
                    context.pushNamed(Screens.myPersonalOffice.name);
                  },
                ),
              if (isWasset == false)
                CategoryItem(
                  text: 'الاعلانات',
                  image: Constants.ad,
                  onTap: () {
                    context.pushNamed(Screens.advertisements.name);
                  },
                ),
              if (isWasset == true)
                CategoryItem(
                  text: 'طلبات التواصل ',
                  image: Constants.deliveryRequests,
                  onTap: () {
                    context.pushNamed(Screens.connectionRequests.name);
                  },
                ),
              if (isWasset == true)
                CategoryItem(
                  onTap: () {
                    context.pushNamed(Screens.tahalfat.name);
                  },
                  text: 'تحالف الوسطاء',
                  image: Constants.myAlliances,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
