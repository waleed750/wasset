import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:waseet/app/bloc/app_bloc.dart';
import 'package:waseet/constants/constants.dart';
import 'package:waseet/features/user/presentation/home_page/widgets/cities_section.dart';
import 'package:waseet/features/user/presentation/home_page/widgets/client_type.dart';
import 'package:waseet/features/user/presentation/home_page/widgets/contact_with_us.dart';
import 'package:waseet/features/user/presentation/home_page/widgets/custom_app_bar.dart';
import 'package:waseet/features/user/presentation/home_page/widgets/custom_slider.dart';
import 'package:waseet/features/user/presentation/home_page/widgets/home_broker_button.dart';
import 'package:waseet/features/user/presentation/home_page/widgets/home_page_categories.dart';
import 'package:waseet/features/user/presentation/register/widgets/wasset_button.dart';
import 'package:waseet/router/screens.dart';

class MainPage extends StatelessWidget {
  const MainPage({
    super.key,
    required this.isAuthenticated,
    required this.isWasset,
  });
  final AppStatus isAuthenticated;
  final bool isWasset;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HomeCustomAppBar(),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24).r,
              child: Column(
                children: [
                  const CustomSlider(),
                  if (isAuthenticated == AppStatus.unauthenticated)
                    const ClientType(),
                  if (isAuthenticated == AppStatus.authenticated) ...[
                    HomepageCategories(
                      isWasset: isWasset,
                    ),
                    const AddRequestSection(),
                    SizedBox(
                      height: 16.h,
                    ),
                    const ContactWithUs(),
                    SizedBox(
                      height: 16.h,
                    ),
                  ],
                  const HomeBrokersButton(),
                  SizedBox(
                    height: 16.h,
                  ),
                  // CustomTextField(
                  //   prefixIcon: IconButton(
                  //     onPressed: () {},
                  //     icon: Icon(
                  //       Icons.search,
                  //       color: Colors.grey,
                  //       size: 20.sp,
                  //     ),
                  //   ),
                  //   hintText: 'ابحث هنا',
                  // ),
                  // SizedBox(
                  //   height: 16.h,
                  // ),
                  const CitiesSection(),
                  // if (isAuthenticated == AppStatus.authenticated)
                  //   const OffersSection(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AddRequestSection extends StatelessWidget {
  const AddRequestSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10).r,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Color(0x3A86A8E7),
            blurRadius: 10.06,
            offset: Offset(0, 1.68),
          ),
        ],
        borderRadius: BorderRadius.circular(15).r,
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SizedBox(
                width: (MediaQuery.sizeOf(context).width / 2.3).w,
                child: Text(
                  'وفّر ساعات البحث  الطويلة وشاركنا طلبك ',
                  style: TextStyle(
                    color: const Color(0xFF6C7191),
                    fontSize: 17.sp,
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                width: (MediaQuery.sizeOf(context).width / 2.5).w,
                child: WassetButton(
                  text: 'أضف طلبك',
                  onTap: () {
                    context.pushNamed(Screens.addConnectionRequests.name);
                  },
                ),
              ),
            ],
          ),
          SvgPicture.asset(
            Constants.searchImage,
          ),
        ],
      ),
    );
  }
}
