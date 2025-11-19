import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waseet/features/brokers/presentation/golden_brokers/cubit/cubit.dart';
import 'package:waseet/features/brokers/presentation/golden_brokers/widgets/article_item.dart';
import 'package:waseet/features/brokers/presentation/golden_brokers/widgets/golden_user_item.dart';
import 'package:waseet/features/user/presentation/home_page/widgets/custom_text_field.dart';

class GoldenBrokersBody extends StatefulWidget {
  /// {@macro golden_brokers_body}
  const GoldenBrokersBody({super.key});

  @override
  State<GoldenBrokersBody> createState() => _GoldenBrokersBodyState();
}

class _GoldenBrokersBodyState extends State<GoldenBrokersBody> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GoldenBrokersCubit, GoldenBrokersState>(
      builder: (context, state) {
        if (state.status == GoldenBrokersStatus.error) {
          return const Scaffold(
            body: Center(
              child: Text('خطا'),
            ),
          );
        }

        if (state.status == GoldenBrokersStatus.loading ||
            state.status == GoldenBrokersStatus.initial) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        final x = state.list;

        return Scaffold(
          appBar: AppBar(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: const Radius.circular(30).r,
              ),
            ),
            elevation: 0,
            title: Text(
              'الوسطاء الذهبيين',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.sp,
              ),
            ),
            centerTitle: true,
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
          ),
          body: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(
                    width: 400.w,
                    height: 150.h,
                    child: ArticleItem(
                      list: state.list,
                    ),
                  ),
                  SizedBox(
                    height: 14.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24).r,
                    child: CustomTextField(
                      controller: _searchController,
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'ابحث عن وسيط',
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  GoldenUserItem(
                    list: state.list.where((element) {
                      return element.name
                          .toLowerCase()
                          .contains(_searchController.text.toLowerCase());
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
