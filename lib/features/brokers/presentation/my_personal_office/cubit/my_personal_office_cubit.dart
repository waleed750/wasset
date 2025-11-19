import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:waseet/features/advertisement/domain/entities/ad_entity.dart';
import 'package:waseet/features/advertisement/domain/entities/post_entity.dart';
import 'package:waseet/features/advertisement/domain/entities/request/add_new_post_request.dart';
import 'package:waseet/features/advertisement/domain/entities/request/get_posts_request.dart';
import 'package:waseet/features/advertisement/domain/repositories/ad_repository.dart';
import 'package:waseet/features/advertisement/presentation/add_new_ad/add_new_ad.dart';
import 'package:waseet/features/brokers/domain/entities/request/get_ads_param.dart';
import 'package:waseet/features/user/domain/entities/wasset_profile_entity.dart';
import 'package:waseet/features/user/domain/repositories/authentication_repository.dart';
import 'package:waseet/res/resource.dart';

part 'my_personal_office_state.dart';

class MyPersonalOfficeCubit extends Cubit<MyPersonalOfficeState> {
  MyPersonalOfficeCubit({
    required AdRepository adRepository,
    required int userId,
    required bool isUserProfile,
    required AuthenticationRepository authenticationRepository,
  })  : _adRepository = adRepository,
        _authenticationRepository = authenticationRepository,
        super(
          MyPersonalOfficeState(
            isUserProfile: isUserProfile,
          ),
        ) {
    init(userId);
  }

  final AdRepository _adRepository;
  final AuthenticationRepository _authenticationRepository;

  FutureOr<void> init(int userId) async {
    emit(state.copyWith(status: MyPersonalOfficeStatus.loading));
    try {
      final ads = await _adRepository.getAds(GetAdsParam(brokerId: userId));
      final posts = await _adRepository.getPosts(GetPostsRequest(id: userId));
      final profile =
          await _authenticationRepository.getProfileById(userId.toString());
      if (ads is ResourceSuccess &&
          posts is ResourceSuccess &&
          profile is ResourceSuccess) {
        emit(
          state.copyWith(
            status: MyPersonalOfficeStatus.loaded,
            ads: ads.data,
            posts: posts.data,
            wassetProfile: profile.data,
          ),
        );
      } else {
        emit(state.copyWith(status: MyPersonalOfficeStatus.error));
      }
    } on Exception catch (e) {
      emit(state.copyWith(status: MyPersonalOfficeStatus.error));
    }
  }

  Future<void> addNewPost(String content) async {
    final result = await _adRepository
        .createPost(AddNewPostRequest(content: content, title: 'nnnn'));
    if (result is ResourceSuccess) {
      emit(
        state.copyWith(
          posts: [
            PostEntity(
              title: '',
              id: result.data!.id,
              content: content,
            ),
            ...state.posts,
          ],
        ),
      );
    }
  }

  Future<void> editPost(int id, String content) async {
    final result = await _adRepository
        .updatePost(AddNewPostRequest(content: content, title: 'nnnn', id: id));
    if (result is ResourceSuccess) {
      final index = state.posts.indexWhere((element) => element.id == id);
      if (index != -1) {
        final posts = state.posts;
        posts[index] = PostEntity(
          title: '',
          id: result.data!.id,
          content: content,
        );
        emit(state.copyWith(posts: posts, isChanged: !state.isChanged));
      }
    }
  }

  Future<void> deletePost(int id) async {
    final result = await _adRepository.deletePost(id);
    if (result is ResourceSuccess) {
      final index = state.posts.indexWhere((element) => element.id == id);
      if (index != -1) {
        final posts = state.posts;
        posts.removeAt(index);
        emit(state.copyWith(posts: posts, isChanged: !state.isChanged));
      }
    }
  }
}
