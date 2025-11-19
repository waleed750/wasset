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
import 'package:waseet/res/resource.dart';

abstract class AuthenticationRepository {
  Future<Resource<WassetUser>> loginWithEmailAndPassword({
    required LoginRequest loginRequest,
  });
  Future<Resource<WassetUser>> registerWithEmailAndPassword({
    required RegisterRequest registerRequest,
  });
  Future<void> signOut();
  bool isSignedIn();
  Future<Resource<WassetUser?>> getUser();

  Future<Resource<WassetProfileEntity>> getProfileById(String id);

  Future<Resource<WassetUser>> updateProfile(UpdateProfileRequest request);

  Future<Resource<WassetUser>> updateProfileImage(File picked, bool isBroker);

  Future<Resource<SubscriptionEntity>> subscribeToPackage(
      PackageSubscribeRequest request);

  Future<Resource<List<MySubscriptionEntity>?>> getMySubscriptions();

  Future<void> updateFcmToken(String fcmToken);

  Future<Resource<NafathResponse>> authNafath(String nationalId);
}
