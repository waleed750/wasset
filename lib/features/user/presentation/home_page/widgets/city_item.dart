import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:waseet/features/user/domain/entities/cities_entity.dart';
import 'package:waseet/router/screens.dart';

class CityItem extends StatelessWidget {
  const CityItem({
    super.key,
    required this.city,
  });
  final CitiesEntity city;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            context.pushNamed(
              Screens.kingdomBroker.name,
              extra: city,
            );
          },
          child: Container(
            width: 1.sw / 4,
            height: ((1.sw / 4) + 10.w).h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(city.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 5.h,
          right: 5.w,
          left: 5.w,
          child: Text(
            city.name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
