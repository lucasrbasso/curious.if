import 'dart:developer';

import 'package:curious_if_mobile/domain/management/model/user_management_model.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import '../../../../core/core.dart';
import '../../../domain/management/usecase/management_usecase.dart';
import 'manage_user_state.dart';
part 'manage_user_controller.g.dart';

class ManageUserController extends _ManageUserControllerBase
    with _$ManageUserController {
  ManageUserController({IManagementUsecase? managementUsecase}) {
    _managementUsecase = managementUsecase ?? ManagementUsecase();
  }
}

abstract class _ManageUserControllerBase with Store {
  late IManagementUsecase _managementUsecase;

  late ReactionDisposer reactionDisposer;

  @observable
  ManageUserState state = ManageUserStateEmpty();

  @observable
  ObservableList<UserManagementModel> users = ObservableList.of([]);

  @observable
  int loadingShimmer = 5;

  @action
  void modifyShimmer(int length) => loadingShimmer = length;

  @action
  Future<void> _modifyManageUserState(ManageUserState stateModify) async =>
      state = stateModify;

  @action
  Future<void> getListUsers({required String token}) async {
    try {
      await _modifyManageUserState(ManageUserStateLoading());

      await Future.delayed(const Duration(seconds: 1));
      List<UserManagementModel> users =
          await _managementUsecase.getUsers(token);
      if (true) {
        this.users.removeWhere((element) => true);
      }
      this.users.addAll(users);
      await _modifyManageUserState(ManageUserStateSuccess(
          message: "Posts buscados com sucesso", users: users));
    } catch (e) {
      await _modifyManageUserState(
          ManageUserStateFailure(message: e.toString()));
    }
  }

  @action
  Future<void> putUser(
      {required String token, required UserManagementModel user}) async {
    try {
      String response = await _managementUsecase.putUsers(
          user.id, token, user.permissions, user.roles);
      log(response);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> refreshScroll(String token) async {
    if ((state is! ManageUserStateLoading) || users.isNotEmpty) {
      users.removeWhere((element) => true);
      await getListUsers(token: token);
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
      if (state is ManageUserStateFailure) {
        modifyShimmer(0);
        String message = (state as ManageUserStateFailure).message;
        await _modifyManageUserState(ManageUserStateEmpty());
        showSnackBar(context, message, Colors.red);
      } else if (state is ManageUserStateSuccess) {
        modifyShimmer(0);
        await _modifyManageUserState(ManageUserStateEmpty());
      } else if (state is ManageUserStateLoading) {
        modifyShimmer(5);
      }
    });
  }

  void dispose() {
    _managementUsecase.dispose();
    reactionDisposer.reaction.dispose();
  }
}
