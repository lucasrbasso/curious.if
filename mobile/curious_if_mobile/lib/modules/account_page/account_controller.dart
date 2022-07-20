import '../../domain/post/model/post_model.dart';

class AccountController {
  List<PostModel> posts = [];
  List<String> subtractPosts = [];

  void addPosts(List<PostModel> newPosts) {
    posts.insertAll(0, newPosts);
  }

  void addPostsSubtract(List<String> newPosts) {
    subtractPosts.insertAll(0, newPosts);
  }
}
