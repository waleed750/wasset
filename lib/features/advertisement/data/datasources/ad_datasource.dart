import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:waseet/features/advertisement/data/models/ad_response.dart';
import 'package:waseet/features/advertisement/data/models/verify_license_response.dart';
import 'package:waseet/features/advertisement/data/models/post_response.dart';
import 'package:waseet/features/advertisement/domain/entities/ad_entity.dart';
import 'package:waseet/features/advertisement/domain/entities/post_entity.dart';
import 'package:waseet/features/advertisement/domain/entities/verify_license_entity.dart';
import 'package:waseet/features/advertisement/domain/entities/request/add_ad_request.dart';
import 'package:waseet/features/advertisement/domain/entities/request/add_new_post_request.dart';
import 'package:waseet/features/advertisement/domain/entities/request/get_posts_request.dart';
import 'package:waseet/features/brokers/domain/entities/request/get_ads_param.dart';
import 'package:waseet/res/api_service.dart';
import 'package:waseet/res/resource.dart';
import 'package:waseet/res/shared_preferences.dart';

class AdDatasource {
  AdDatasource({required ApiService apiService}) : _apiServices = apiService;
  final ApiService _apiServices;

  Future<Resource<List<AdEntity>?>> getAds({
    int page = 1,
    int pageSize = 10,
    GetAdsParam? param,
  }) async {
    try {
      final response = await _apiServices.get<Map<String, dynamic>>(
        '/advertisements',
        queryParameters: {
          'page': page,
          'pageSize': pageSize,
          if (param?.brokerId != null) 'filter[user_id]': param!.brokerId,
        },
      );
      final ad = AdResponse.fromMap(response!);
      if (ad.data != null) {
        return Resource.success(ad.data!.map((e) => e.toEntity()).toList());
      }
      return Resource.error(ad.message ?? 'error', null, ad.errors);
    } catch (e) {
      return Resource.error(e.toString());
    }
  }

  Future<Resource<List<AdEntity>?>> getFavAds() async {
    try {
      final response = await _apiServices.get<Map<String, dynamic>>(
        '/users/advertisements/favorites',
      );
      final ad = AdResponse.fromMap(response!);
      if (ad.data != null) {
        return Resource.success(ad.data!.map((e) => e.toEntity()).toList());
      }
      return Resource.error(ad.message ?? 'error', null, ad.errors);
    } catch (e) {
      return Resource.error(e.toString());
    }
  }

  //create ad
  Future<Resource<AdEntity?>> createAd(AddAdRequest adRequest) async {
    try {
      final body = await adRequest.toJson();
      final response = await _apiServices.post<Map<String, dynamic>>(
        '/advertisements',
        data: dio.FormData.fromMap(body),
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      );
      final ad = AdResponse.fromMap(response!);
      // List<AdModel>
      if (ad.data != null) {
        // final images = <dio.MultipartFile>[];
        // for (final image in adRequest.images) {
        //   images.add(
        //     await dio.MultipartFile.fromFile(
        //       image.path,
        //       filename: image.path.split('/').last,
        //     ),
        //   );
        // }
        // final uploadImages = await _apiServices.put<Map<String, dynamic>>(
        //   '/advertisement'
        //   '/${ad.data!.first.id}',
        //   data: dio.FormData.fromMap({
        //     'attechments': images,
        //   }),
        //   headers: {
        //     'Content-Type': 'multipart/form-data',
        //   },
        // );
        return Resource.success(ad.data!.first.toEntity());
      }

      return Resource.error(ad.message ?? 'error', null, ad.errors);
    } catch (e) {
      return Resource.error(e.toString());
    }
  }

  /// Create ad using verification endpoint (multipart with files and extra_info)
  Future<Resource<AdEntity?>> createAdWithVerification(
    String advertiserId,
    String adLicenseNumber,
    String extraInfo,
    List<File> files,
  ) async {
    try {
      final images = <dio.MultipartFile>[];
      for (final f in files) {
        images.add(
          await dio.MultipartFile.fromFile(
            f.path,
            filename: f.path.split(Platform.pathSeparator).last,
          ),
        );
      }

      final form = dio.FormData.fromMap({
        'files': images,
        'adLicenseNumber': adLicenseNumber,
        'advertiserId': advertiserId,
        'extra_info': extraInfo,
      });

      final response = await _apiServices.post<Map<String, dynamic>>(
        '/advertisements/create-with-verification',
        data: form,
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      );

      final ad = AdResponse.fromMap(response!);
      if (ad.data != null && ad.data!.isNotEmpty) {
        return Resource.success(ad.data!.first.toEntity());
      }
      return Resource.error(ad.message ?? 'error', null, ad.errors);
    } catch (e) {
      return Resource.error(e.toString());
    }
  }

  Future<Resource<AdEntity?>> getAdById(int id) async {
    try {
      final response = await _apiServices.get<Map<String, dynamic>>(
        '/advertisements',
        queryParameters: {
          'filter[id]': id,
        },
      );
      final ad = AdResponse.fromMap(response!);
      if (ad.data != null) {
        return Resource.success(ad.data!.first.toEntity());
      }
      return Resource.error(ad.message ?? 'error', null, ad.errors);
    } catch (e) {
      return Resource.error(e.toString());
    }
  }

  /// Fetch advertisement by advertiserId and adLicenseNumber (used by new pre-wizard step)
  Future<Resource<AdEntity?>> getAdByAdvertiserAndLicense(
      String advertiserId, String adLicenseNumber,) async {
    try {
      final response = await _apiServices.post<Map<String, dynamic>>(
        '/advertisements',
        data: {
          'advertiserId': advertiserId,
          'adLicenseNumber': adLicenseNumber,
        },
      );

      final ad = AdResponse.fromMap(response!);
      if (ad.data != null && ad.data!.isNotEmpty) {
        return Resource.success(ad.data!.first.toEntity());
      }
      return Resource.error(ad.message ?? 'error', null, ad.errors);
    } catch (e) {
      return Resource.error(e.toString());
    }
  }

  /// Verify license endpoint - returns detailed verification data
  Future<Resource<VerifyLicenseEntity?>> verifyLicense(
      String advertiserId, String adLicenseNumber,) async {
    try {
      final response = await _apiServices.post<Map<String, dynamic>>(
        '/advertisements/verify-license',
        data: {
          'adLicenseNumber': adLicenseNumber,
          'advertiserId': advertiserId,
        },
      );

      if (response == null) return Resource.error('empty response');

      // parse response.data
      final data = response['data'] as Map<String, dynamic>?;
      if (data != null) {
        final model = VerifyLicenseModel.fromMap(data);
        return Resource.success(model);
      }
      return Resource.error(response['message'] as String? ?? 'error');
    } catch (e) {
      return Resource.error(e.toString());
    }
  }

  Future<Resource<PostEntity?>> createPost(AddNewPostRequest request) async {
    try {
      final response = await _apiServices.post<Map<String, dynamic>>(
        '/posts',
        data: request.toMap(),
      );
      final post = PostsResponse.fromMap(response!);
      if (post.data != null) {
        return Resource.success(post.data!.first.toEntity());
      }
      return Resource.error(post.message ?? 'error', null, post.errors);
    } catch (e) {
      return Resource.error(e.toString());
    }
  }

  Future<Resource<PostEntity?>> getPostById(GetPostsRequest request) async {
    try {
      final response = await _apiServices.get<Map<String, dynamic>>(
        '/posts',
        queryParameters: request.toMap(),
      );
      final post = PostsResponse.fromMap(response!);
      if (post.data != null) {
        return Resource.success(post.data!.first.toEntity());
      }
      return Resource.error(post.message ?? 'error', null, post.errors);
    } catch (e) {
      return Resource.error(e.toString());
    }
  }

  Future<Resource<List<PostEntity>?>> getPosts(GetPostsRequest request) async {
    try {
      final response = await _apiServices.get<Map<String, dynamic>>(
        '/posts?filter[user_id]=${request.id}',
        queryParameters: request.toMap(),
      );
      final post = PostsResponse.fromMap(response!);
      if (post.data != null) {
        return Resource.success(post.data!.map((e) => e.toEntity()).toList());
      }
      return Resource.error(post.message ?? 'error', null, post.errors);
    } catch (e) {
      return Resource.error(e.toString());
    }
  }

  Future<Resource<PostEntity?>> updatePost(AddNewPostRequest request) async {
    try {
      final response = await _apiServices.put<Map<String, dynamic>>(
        '/posts/${request.id}',
        data: request.toMap(),
      );
      final post = PostsResponse.fromMap(response!);
      if (post.data != null) {
        return Resource.success(post.data!.first.toEntity());
      }
      return Resource.error(post.message ?? 'error', null, post.errors);
    } catch (e) {
      return Resource.error(e.toString());
    }
  }

  Future<Resource<PostEntity?>> deletePost(int id) async {
    try {
      await _apiServices.delete<Map<String, dynamic>>(
        '/posts/$id',
      );
      return Resource.success(null);
    } catch (e) {
      return Resource.error(e.toString());
    }
  }

  Future<Resource<String>> removeFavAd(int adId) async {
    try {
      final response = await _apiServices.delete<Map<String, dynamic>>(
        '/users/advertisements/$adId/favorite',
        headers: {
          'Authorization': 'Bearer ${wassetSharedPreferences.getToken()}}',
        },
      );

      if (response!['message'] != 'تم إزالة الإعلان من المفضلة بنجاح') {
        final message = response['message'] as String;
        return Resource.error(
          message,
        );
      }
      return Resource.success(response['message'] as String);
    } on Exception catch (e) {
      log(e.toString());
      return Resource.error(e.toString());
    }
  }

  Future<Resource<String>> addFavAd(int adId) async {
    try {
      final response = await _apiServices.post<Map<String, dynamic>>(
        '/users/advertisements/$adId/favorite',
        headers: {
          'Authorization': 'Bearer ${wassetSharedPreferences.getToken()}}',
        },
      );

      if (response!['message'] == 'تم إضافة الإعلان إلى المفضلة بنجاح') {
        return Resource.success(response['message'] as String);
      }
      final message = response['message'] as String;
      return Resource.error(
        message,
      );
    } on Exception catch (e) {
      log(e.toString());
      return Resource.error(e.toString());
    }
  }
}
