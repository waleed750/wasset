import 'package:waseet/features/advertisement/data/models/ad_model.dart';
import 'package:waseet/features/advertisement/data/models/post_model.dart';
import 'package:waseet/res/response/base_pagination.response.dart';

class PostsResponse with BasePaginationResponse<PostModel> {
  PostsResponse.fromMap(Map<String, dynamic> json) {
    super.fromJson(json, builder: PostModel.fromJson);
  }
}
