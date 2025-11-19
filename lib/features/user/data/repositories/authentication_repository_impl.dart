import 'dart:io';

import 'package:waseet/features/user/data/datasources/authentication_data_source.dart';
import 'package:waseet/features/user/domain/entities/request/login_request.dart';
import 'package:waseet/features/user/domain/entities/request/package_subscribe_request.dart';
import 'package:waseet/features/user/domain/entities/request/register_request.dart';
import 'package:waseet/features/user/domain/entities/request/update_profile_request.dart';
import 'package:waseet/features/user/domain/entities/subscription/my_subscription_entity.dart';
import 'package:waseet/features/user/domain/entities/subscription/subscription_entity.dart';
import 'package:waseet/features/user/domain/entities/wasset_profile_entity.dart';
import 'package:waseet/features/user/domain/entities/wasset_user.dart';
import 'package:waseet/features/user/domain/repositories/authentication_repository.dart';
import 'package:waseet/res/resource.dart';
import 'package:waseet/res/shared_preferences.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  AuthenticationRepositoryImpl({
    required AuthenticationDataSource dataSource,
  }) : _dataSource = dataSource;

  final AuthenticationDataSource _dataSource;

  @override
  Future<Resource<WassetUser?>> getUser() async {
    try {
      final user = await _dataSource.getUser();
      if (user is ResourceSuccess) {
        return Resource.success(WassetUser.fromModel(user.data!.data![0]));
      }
      return Resource.error(user.message!);
    } catch (e) {
      return Resource.error(e.toString());
    }
  }

  @override
  bool isSignedIn() {
    try {
      final token = wassetSharedPreferences.getToken();
      return token != null && token.isNotEmpty;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Resource<WassetUser>> loginWithEmailAndPassword({
    required LoginRequest loginRequest,
  }) async {
    try {
      final user = await _dataSource.login(loginRequest);
      if (user is ResourceError) {
        return Resource.error(user.message!, null, user.errors);
      }
      await wassetSharedPreferences.setToken(user.data!.accessToken!);
      return Resource.success(WassetUser.fromModel(user.data!.data![0]));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Resource<WassetUser>> registerWithEmailAndPassword({
    required RegisterRequest registerRequest,
  }) async {
    try {
      final user = await _dataSource.register(registerRequest);
      if (user is ResourceError) {
        return Resource.error(user.message!, null, user.errors);
      }
      await wassetSharedPreferences.setToken(user.data!.accessToken!);
      return Resource.success(WassetUser.fromModel(user.data!.data![0]));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _dataSource.logout();
      await wassetSharedPreferences.setToken('');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Resource<WassetUser>> updateProfile(
    UpdateProfileRequest request,
  ) async {
    try {
      final user = await _dataSource.updateProfile(request);
      if (user is ResourceError) {
        return Resource.error(user.message!, null, user.errors);
      }
      return Resource.success(WassetUser.fromModel(user.data!.data![0]));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Resource<WassetUser>> updateProfileImage(
    File picked,
    bool isBroker,
  ) async {
    try {
      final user = await _dataSource.updateProfileImage(picked, isBroker);
      if (user is ResourceError) {
        return Resource.error(user.message!, null, user.errors);
      }
      return Resource.success(WassetUser.fromModel(user.data!.data![0]));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Resource<WassetProfileEntity>> getProfileById(String id) {
    return _dataSource.getUserById(id);
  }

  @override
  Future<Resource<SubscriptionEntity>> subscribeToPackage(
    PackageSubscribeRequest request,
  ) {
    return _dataSource.subscribeToPackage(request);
  }

  @override
  Future<Resource<List<MySubscriptionEntity>?>> getMySubscriptions() {
    return _dataSource.getMySubscriptions();
  }

  @override
  Future<void> updateFcmToken(String fcmToken) {
    return _dataSource.updateFcmToken(fcmToken);
  }

  @override
  Future<Resource<NafathResponse>> authNafath(String nationalId) async {
    try {
      final response = await _dataSource.authNafath(nationalId);
      if (response is ResourceError) {
        return Resource.error(response.message!, null, response.errors);
      }
      return Resource.success(response.data!);
    } catch (e) {
      rethrow;
    }
  }
}
