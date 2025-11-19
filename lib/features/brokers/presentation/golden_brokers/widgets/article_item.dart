import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waseet/constants/constants.dart';
import 'package:waseet/features/brokers/domain/entities/golden_brokers_entity.dart';

class ArticleItem extends StatelessWidget {
  const ArticleItem({
    super.key,
    required this.list,
  });
  final List<GoldenBrokersEntity> list;

  @override
  Widget build(BuildContext context) {
    return ImageSlideshow(
      indicatorColor: Constants.primaryColor,
      indicatorRadius: 3.5.w,
      indicatorBackgroundColor: Colors.grey[200],
      children: List.generate(
        list.length,
        (index) => Container(
          margin: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 5,
            bottom: 5,
          ).r,
          padding: const EdgeInsets.all(6).r,
          width: double.infinity,
          // height: 150.h,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Constants.secondaryColor.withOpacity(0.1),
                blurRadius: 4,
                spreadRadius: 7,
                offset: const Offset(3, 2),
              ),
            ],
            borderRadius: BorderRadius.circular(10).r,
          ),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
              ),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  list[index].article,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    color: Constants.primaryColor,
                  ),
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12).r,
                    child: Text(
                      list[index].name,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
