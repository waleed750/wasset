import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:waseet/app/bloc/app_bloc.dart';
import 'package:waseet/common_widgets/wasset_app_bar.dart';
import 'package:waseet/constants/constants.dart';
import 'package:waseet/features/developer_real_estate/presentation/projects/view/developer_projects_page.dart';
import 'package:waseet/router/screens.dart';

class DeveloperRealEstateEntryPage extends StatelessWidget {
  const DeveloperRealEstateEntryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isWasset = context.select((AppBloc bloc) => bloc.state.isWasset);
    if (!isWasset) {
      return const DeveloperProjectsPage();
    }

    return Scaffold(
      appBar: const WassetAppBar(title: 'عقارات المطورين'),
      body: Padding(
        padding: const EdgeInsets.all(24).r,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Developer Projects/Offers Card
            _EntryCard(
              title: 'الدخول إلى عروض المطورين',
              onTap: () {
                context.pushNamed(Screens.developerProjects.name);
              },
            ),
            SizedBox(height: 24.h),
            // Developer Requests Card
            _EntryCard(
              title: 'الدخول إلى طلبات المطورين',
              onTap: () {
                context.pushNamed(Screens.connectionRequests.name);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _EntryCard extends StatelessWidget {
  const _EntryCard({
    required this.title,
    required this.onTap,
  });

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16).r,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15).r,
          boxShadow: const [
            BoxShadow(
              color: Color(0x3A86A8E7),
              blurRadius: 10.06,
              offset: Offset(0, 1.68),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Constants.primaryColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 12.h),
            Icon(
              Icons.arrow_forward,
              color: Constants.primaryColor,
              size: 24.sp,
            ),
          ],
        ),
      ),
    );
  }
}
