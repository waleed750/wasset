import 'package:waseet/features/user/domain/entities/about_us_model.dart';
import 'package:waseet/features/user/domain/entities/category/category_entity.dart';
import 'package:waseet/features/user/domain/entities/cities_entity.dart';
import 'package:waseet/features/user/domain/entities/neighborhood_entity.dart';
import 'package:waseet/features/user/domain/entities/notification_entity.dart';
import 'package:waseet/features/user/domain/entities/packages_entity.dart';
import 'package:waseet/features/user/domain/entities/slide_entity.dart';
import 'package:waseet/res/resource.dart';

abstract class HomeRepository {
  Future<Resource<List<CitiesEntity>?>> getCities({
    int page = 1,
    int pageSize = 12,
  });

  Future<Resource<List<SliderEntity>?>> getSlider({
    int page = 1,
    int pageSize = 5,
  });

  Future<Resource<List<CategoryEntity>?>> getCategories({
    int page = 1,
    int pageSize = 100,
  });

  Future<Resource<List<NeighborhoodEntity>?>> getNeighborhood(
    int cityId, {
    int page = 1,
    int pageSize = 10,
  });

  Future<Resource<List<PackagesEntity>?>> getPackages({
    int page = 1,
    int pageSize = 10,
  });

  Future<Resource<List<NotificationEntity>?>> getNotifications({
    int pageSize = 10,
  });

  Future<Resource<AboutUsModel?>> getAboutUs();

  Future<String> getTermsAndConditions();
}
