import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:waseet/app/bloc/app_bloc.dart';
import 'package:waseet/features/advertisement/presentation/advertisements/view/advertisements_page.dart';
import 'package:waseet/features/brokers/presentation/my_connection_request/view/my_connection_request_page.dart';
import 'package:waseet/features/chat/presentation/chat_list/view/chat_list_page.dart';
import 'package:waseet/features/user/presentation/home_page/home_page.dart';
import 'package:waseet/res/assets/assets.gen.dart';
import 'package:waseet/res/res.dart';
import 'package:waseet/router/screens.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

List<Widget> pagesWasset = [
  const HomePagePage(),
  const AdvertisementsPage(),
  const ChatListPage(),
  const MyConnectionRequestPage(),
  // const MyFavConnectionRequestPage(),
];
List<Widget> pagesCustomer = [
  const HomePagePage(),
  const ChatListPage(),
  const MyConnectionRequestPage(),
];

class _MainLayoutState extends State<MainLayout> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        final isWasset = state.isWasset;
        return Scaffold(
          // body: IndexedStack(
          //   index: currentIndex,
          //   children: pages,
          // ),
          body: isWasset
              ? pagesWasset[currentIndex]
              : pagesCustomer[currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            currentIndex: currentIndex,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppColors.primaryColor,
            onTap: (index) => setState(() {
              final isAuth = context.read<AppBloc>().state.status ==
                  AppStatus.authenticated;
              if (index != 0 && !isAuth) {
                context.pushNamed(Screens.login.name);
                return;
              }
              currentIndex = index;
            }),
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home, size: 24.sp),
                label: 'الرئيسية',
              ),
              if (isWasset == true)
                BottomNavigationBarItem(
                  icon: Assets.icons.ads.svg(
                    width: 24.w,
                    height: 24.w,
                    colorFilter: ColorFilter.mode(
                      currentIndex == 1 ? AppColors.primaryColor : Colors.grey,
                      BlendMode.srcIn,
                    ),
                  ),
                  label: 'الاعلانات',
                ),
              BottomNavigationBarItem(
                icon: Icon(Icons.message, size: 24.w),
                label: 'الرسائل',
              ),
              // if (isWasset != true)
              // BottomNavigationBarItem(
              //   icon: Icon(Icons.menu, size: 24.w),
              //   label: 'طلبات تهمني',
              // )

              BottomNavigationBarItem(
                icon: Icon(Icons.menu, size: 24.w),
                label: 'طلباتي',
              ),
            ],
          ),
          floatingActionButton:
              context.read<AppBloc>().state.isWasset == true &&
                      context.read<AppBloc>().state.status ==
                          AppStatus.authenticated
                  ? FloatingActionButton(
                      backgroundColor: AppColors.primaryColor,
                      shape: const CircleBorder(),
                      onPressed: () {
                        context.pushNamed(Screens.addNewAd.name);
                      },
                      child: const Icon(Icons.add),
                    )
                  : null,
        );
      },
    );
  }
}
