import 'dart:developer';

import 'package:curious_if_mobile/modules/management/manage_posts/widgets/post_manage_widget/post_manage_widget.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import '../../../../core/core.dart';
import '../../../domain/management/model/post_management_model.dart';
import '../../../domain/management/usecase/management_usecase.dart';
import 'manage_post_state.dart';
part 'manage_post_controller.g.dart';

class ManagePostController extends _ManagePostControllerBase
    with _$ManagePostController {
  ManagePostController({IManagementUsecase? managementUsecase}) {
    _managementUsecase = managementUsecase ?? ManagementUsecase();
  }
}

abstract class _ManagePostControllerBase with Store {
  late IManagementUsecase _managementUsecase;

  late ReactionDisposer reactionDisposer;

  @observable
  ManagePostState state = ManagePostStateEmpty();

  @observable
  ObservableList<PostManagementModel> posts = ObservableList.of([]);

  @observable
  int loadingShimmer = 5;

  @action
  void modifyShimmer(int length) => loadingShimmer = length;

  @action
  Future<void> _modifyManagePostState(ManagePostState stateModify) async =>
      state = stateModify;

  @action
  Future<void> getListPostsUnauthorized({
    required String token,
    required GlobalKey<AnimatedListState> listKey,
  }) async {
    try {
      await _modifyManagePostState(ManagePostStateLoading());
      await Future.delayed(const Duration(seconds: 2));
      List<PostManagementModel> posts =
          await _managementUsecase.getListPostsUnauthorized(token);
      this.posts.removeWhere((element) => true);
      this.posts.addAll(posts);
      await _modifyManagePostState(ManagePostStateSuccess(
          message: "Posts buscados com sucesso", posts: posts));
    } catch (e) {
      await _modifyManagePostState(
          ManagePostStateFailure(message: e.toString()));
    }
  }

  @action
  Future<void> onPublishEdit(String id, String token,
      Function onAnimationDeletion, bool isPublished) async {
    try {
      await _managementUsecase.patchPost(id, token, isPublished);
      await onAnimationDeletion();
    } catch (e) {
      log(e.toString());
    }
  }

  @action
  Future<bool> confirmDismiss(String id, String token,
      Function onAnimationDeletion, bool isPublished) async {
    try {
      await _managementUsecase.patchPost(id, token, isPublished);
      return true;
    } catch (e) {
      return false;
    }
  }

  @action
  void onDismissed(
    int index,
    BuildContext context,
    GlobalKey<AnimatedListState> listKey,
  ) {
    posts.removeAt(index);
    listKey.currentState!
        .removeItem(index, (context, animation) => Container());
  }

  Future<void> onAnimationDeletion(int index,
      GlobalKey<AnimatedListState> listKey, BuildContext context) async {
    PostManagementModel removedItem = posts.removeAt(index);
    AnimatedListRemovedItemBuilder builder;
    builder = (context, animation) => removeItem(removedItem, animation, index);

    listKey.currentState!.removeItem(index, builder,
        duration: const Duration(milliseconds: 300));
  }

  Widget removeItem(
      PostManagementModel item, Animation<double> animation, int index) {
    return SizeTransition(
      sizeFactor: animation,
      child: Column(
        children: [
          PostManageWidget(key: UniqueKey(), post: item),
          const SizedBox(height: 20)
        ],
      ),
    );
  }

  @action
  Future<void> patchPostUnauthorized({
    required String token,
    required PostManagementModel post,
    required bool isPublished,
  }) async {
    try {
      String response =
          await _managementUsecase.patchPost(post.id, token, isPublished);
      log(response);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> refreshScroll(
    String token,
    GlobalKey<AnimatedListState> listKey,
  ) async {
    if ((state is! ManagePostStateLoading) || posts.isNotEmpty) {
      posts.removeWhere((element) => true);
      await getListPostsUnauthorized(token: token, listKey: listKey);
    }
  }

  // FUNÇÃO PARA ABRIR O SNACKBAR
  void showSnackBar(BuildContext context, String text, Color color) {
    SnackBar snackBar = SnackBar(
      content: Text(
        text,
        textAlign: TextAlign.center,
        style: AppTheme.textStyles.textSnackBar,
      ),
      backgroundColor: color,
    );
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  void autoRun(BuildContext context) {
    reactionDisposer = autorun((_) async {
      if (state is ManagePostStateFailure) {
        modifyShimmer(0);
        String message = (state as ManagePostStateFailure).message;
        await _modifyManagePostState(ManagePostStateEmpty());
        showSnackBar(context, message, Colors.red);
      } else if (state is ManagePostStateSuccess) {
        modifyShimmer(0);
        await _modifyManagePostState(ManagePostStateEmpty());
      } else if (state is ManagePostStateLoading) {
        modifyShimmer(5);
      }
    });
  }

  void dispose() {
    _managementUsecase.dispose();
    reactionDisposer.reaction.dispose();
  }
}
