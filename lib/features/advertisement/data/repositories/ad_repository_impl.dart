import 'package:waseet/features/advertisement/data/datasources/ad_datasource.dart';
import 'package:waseet/features/advertisement/domain/entities/ad_entity.dart';
import 'package:waseet/features/advertisement/domain/entities/post_entity.dart';
import 'package:waseet/features/advertisement/domain/entities/request/add_ad_request.dart';
import 'package:waseet/features/advertisement/domain/entities/request/add_new_post_request.dart';
import 'package:waseet/features/advertisement/domain/entities/request/get_posts_request.dart';
import 'package:waseet/features/advertisement/domain/repositories/ad_repository.dart';
import 'package:waseet/features/brokers/domain/entities/request/get_ads_param.dart';
import 'package:waseet/res/resource.dart';

class AdRepositoryImpl extends AdRepository {
  AdRepositoryImpl({
    required AdDatasource adDatasource,
  }) : _adDatasource = adDatasource;

  final AdDatasource _adDatasource;

  @override
  Future<Resource<AdEntity?>> createAd(AddAdRequest ad) {
    return _adDatasource.createAd(ad);
  }

  @override
  Future<Resource<AdEntity?>> deleteAd(int id) {
    // TODO: implement deleteAd
    throw UnimplementedError();
  }

  @override
  Future<Resource<AdEntity?>> getAdById(int id) async {
    return _adDatasource.getAdById(id);
  }

  @override
  Future<Resource<List<AdEntity>?>> getAds(
    GetAdsParam param, {
    int page = 1,
    int pageSize = 10,
  }) {
    return _adDatasource.getAds(page: page, pageSize: pageSize, param: param);
  }

  @override
  Future<Resource<List<AdEntity>?>> getFavAds() {
    return _adDatasource.getFavAds();
  }

  @override
  Future<Resource<List<AdEntity>?>> getAdsByCategory(
    int categoryId, {
    int page = 1,
    int pageSize = 10,
  }) {
    // TODO: implement getAdsByCategory
    throw UnimplementedError();
  }

  @override
  Future<Resource<List<AdEntity>?>> getAdsByCity(
    int cityId, {
    int page = 1,
    int pageSize = 10,
  }) {
    // TODO: implement getAdsByCity
    throw UnimplementedError();
  }

  @override
  Future<Resource<List<AdEntity>?>> getAdsByNeighborhood(
    int neighborhoodId, {
    int page = 1,
    int pageSize = 10,
  }) {
    // TODO: implement getAdsByNeighborhood
    throw UnimplementedError();
  }

  @override
  Future<Resource<List<AdEntity>?>> getAdsBySearch(
    String search, {
    int page = 1,
    int pageSize = 10,
  }) {
    // TODO: implement getAdsBySearch
    throw UnimplementedError();
  }

  @override
  Future<Resource<List<AdEntity>?>> getAdsByUser(
    int userId, {
    int page = 1,
    int pageSize = 10,
  }) {
    // TODO: implement getAdsByUser
    throw UnimplementedError();
  }

  @override
  Future<Resource<AdEntity?>> updateAd(AddAdRequest ad) {
    // TODO: implement updateAd
    throw UnimplementedError();
  }

  @override
  Future<Resource<List<AdEntity>?>> getMyAds({
    int page = 1,
    int pageSize = 10,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<Resource<PostEntity?>> createPost(AddNewPostRequest request) async {
    return _adDatasource.createPost(request);
  }

  @override
  Future<Resource<PostEntity?>> getPostById(GetPostsRequest request) {
    return _adDatasource.getPostById(request);
  }

  @override
  Future<Resource<List<PostEntity>?>> getPosts(GetPostsRequest request) {
    return _adDatasource.getPosts(request);
  }

  @override
  Future<Resource<PostEntity?>> updatePost(AddNewPostRequest request) {
    return _adDatasource.updatePost(request);
  }

  @override
  Future<Resource<PostEntity?>> deletePost(int id) {
    return _adDatasource.deletePost(id);
  }

  @override
  Future<Resource<String>> addFavAd(int adId) {
    return _adDatasource.addFavAd(adId);
  }

  @override
  Future<Resource<String>> removeFavAd(int adId) {
    return _adDatasource.removeFavAd(adId);
  }
}
