import 'package:waseet/features/user/data/datasources/home_data_source.dart';
import 'package:waseet/features/user/domain/entities/about_us_model.dart';
import 'package:waseet/features/user/domain/entities/category/category_entity.dart';
import 'package:waseet/features/user/domain/entities/cities_entity.dart';
import 'package:waseet/features/user/domain/entities/neighborhood_entity.dart';
import 'package:waseet/features/user/domain/entities/notification_entity.dart';
import 'package:waseet/features/user/domain/entities/packages_entity.dart';
import 'package:waseet/features/user/domain/entities/slide_entity.dart';
import 'package:waseet/features/user/domain/repositories/home_repository.dart';
import 'package:waseet/res/resource.dart';

class HomeRepositoryImpl extends HomeRepository {
  HomeRepositoryImpl({
    required HomeDataSource homeDataSource,
  }) : _homeDataSource = homeDataSource;

  final HomeDataSource _homeDataSource;

  @override
  Future<Resource<List<CitiesEntity>?>> getCities({
    int page = 1,
    int pageSize = 12,
  }) {
    return _homeDataSource.getCities(page: page, pageSize: pageSize);
  }

  @override
  Future<Resource<List<SliderEntity>?>> getSlider({
    int page = 1,
    int pageSize = 5,
  }) {
    return _homeDataSource.getSlider(page: page, pageSize: pageSize);
  }

  @override
  Future<Resource<List<CategoryEntity>?>> getCategories({
    int page = 1,
    int pageSize = 100,
  }) {
    return _homeDataSource.getCategories(page: page, pageSize: pageSize);
  }

  @override
  Future<Resource<List<NeighborhoodEntity>?>> getNeighborhood(
    int cityId, {
    int page = 1,
    int pageSize = 10,
  }) {
    return _homeDataSource.getNeighborhoods(
      cityId,
      page: page,
      pageSize: pageSize,
    );
  }

  @override
  Future<Resource<List<PackagesEntity>?>> getPackages({
    int page = 1,
    int pageSize = 10,
  }) async {
    return _homeDataSource.getPackages(page: page, pageSize: pageSize);
  }

  @override
  Future<Resource<List<NotificationEntity>?>> getNotifications({
    int page = 1,
    int pageSize = 10,
  }) {
    return _homeDataSource.getNotifications(page: page, pageSize: pageSize);
  }

  @override
  Future<Resource<AboutUsModel?>> getAboutUs() {
    return _homeDataSource.getAboutUs();
  }

  @override
  Future<String> getTermsAndConditions() {
    return _homeDataSource.getTermsAndConditions();
  }
}
