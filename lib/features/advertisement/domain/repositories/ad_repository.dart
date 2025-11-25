import 'dart:io';
import 'package:waseet/features/advertisement/domain/entities/ad_entity.dart';
import 'package:waseet/features/advertisement/domain/entities/verify_license_entity.dart';
import 'package:waseet/features/advertisement/domain/entities/post_entity.dart';
import 'package:waseet/features/advertisement/domain/entities/request/add_ad_request.dart';
import 'package:waseet/features/advertisement/domain/entities/request/add_new_post_request.dart';
import 'package:waseet/features/advertisement/domain/entities/request/get_posts_request.dart';
import 'package:waseet/features/brokers/domain/entities/request/get_ads_param.dart';
import 'package:waseet/res/resource.dart';

abstract class AdRepository {
  Future<Resource<List<AdEntity>?>> getFavAds();

  Future<Resource<List<AdEntity>?>> getAds(
    GetAdsParam param, {
    int page = 1,
    int pageSize = 10,
  });

  Future<Resource<List<AdEntity>?>> getAdsByCategory(
    int categoryId, {
    int page = 1,
    int pageSize = 10,
  });

  Future<Resource<List<AdEntity>?>> getAdsByNeighborhood(
    int neighborhoodId, {
    int page = 1,
    int pageSize = 10,
  });

  Future<Resource<List<AdEntity>?>> getAdsByCity(
    int cityId, {
    int page = 1,
    int pageSize = 10,
  });

  Future<Resource<List<AdEntity>?>> getAdsByUser(
    int userId, {
    int page = 1,
    int pageSize = 10,
  });

  Future<Resource<List<AdEntity>?>> getAdsBySearch(
    String search, {
    int page = 1,
    int pageSize = 10,
  });

  Future<Resource<AdEntity?>> getAdById(int id);

  Future<Resource<AdEntity?>> getAdByAdvertiserAndLicense(
      String advertiserId, String adLicenseNumber,);

  Future<Resource<VerifyLicenseEntity?>> verifyLicense(
      String advertiserId, String adLicenseNumber,);

  Future<Resource<AdEntity?>> createAd(AddAdRequest ad);

  Future<Resource<AdEntity?>> createAdWithVerification(
    String advertiserId,
    String adLicenseNumber,
    String extraInfo,
    List<File> files,
  );

  Future<Resource<AdEntity?>> updateAd(AddAdRequest ad);

  Future<Resource<AdEntity?>> deleteAd(int id);

  Future<Resource<List<AdEntity>?>> getMyAds({
    int page = 1,
    int pageSize = 10,
  });

  Future<Resource<List<PostEntity>?>> getPosts(GetPostsRequest request);

  Future<Resource<PostEntity?>> getPostById(GetPostsRequest request);

  Future<Resource<PostEntity?>> createPost(AddNewPostRequest request);

  Future<Resource<PostEntity?>> updatePost(AddNewPostRequest request);

  Future<Resource<PostEntity?>> deletePost(int id);

  Future<Resource<String>> addFavAd(int adId);
  Future<Resource<String>> removeFavAd(int adId);
}
