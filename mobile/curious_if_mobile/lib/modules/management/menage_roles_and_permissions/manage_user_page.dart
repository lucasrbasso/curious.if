import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../core/core.dart';
import '../../../domain/login/model/user_model.dart';
import '../../../domain/management/model/user_management_model.dart';
import '../../../shared/app_bar_simple/app_bar_simple.dart';
import 'manage_user_controller.dart';
import 'popup/popup_user.dart';
import 'widgets/user_widget/user_widget.dart';

class ManageUserPage extends StatefulWidget {
  final UserModel user;
  const ManageUserPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<ManageUserPage> createState() => _ManageUserPageState();
}

class _ManageUserPageState extends State<ManageUserPage> {
  late ManageUserController _manageUserController;
  final List<UserManagementModel> users = [];

  @override
  void initState() {
    _manageUserController = ManageUserController();
    _manageUserController.getListUsers(token: widget.user.token);
    _manageUserController.autoRun(context);
    super.initState();
  }

  @override
  void dispose() {
    _manageUserController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppThemeController().colorStatus,
      sized: false,
      child: Scaffold(
        backgroundColor: AppTheme.colors.background,
        appBar: AppBarSimple(
          label: "GERENCIAR PERMISSÕES",
          user: widget.user,
          hasSearch: true,
        ),
        body: Observer(
          builder: (context) {
            int itemCount = _manageUserController.users.length +
                _manageUserController.loadingShimmer;
            return RefreshIndicator(
              onRefresh: () async {
                await _manageUserController.refreshScroll(widget.user.token);
              },
              color: AppTheme.colors.titlePost,
              backgroundColor: AppTheme.colors.backgroundButton,
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 10),
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemCount: itemCount,
                itemBuilder: (context, index) {
                  if (index < _manageUserController.users.length) {
                    return UserWidget(
                      user: _manageUserController.users[index],
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return PopupUser(
                              user: _manageUserController.users[index],
                              onChanged: (user) {
                                _manageUserController.putUser(
                                    token: widget.user.token, user: user);
                                _manageUserController.users[index].copyWith(
                                  permissions: user.permissions,
                                  roles: user.roles,
                                );
                              },
                            );
                          },
                        );
                      },
                    );
                  } else {
                    return UserWidget(
                        user: UserManagementModel.mock(), loading: true);
                  }
                },
              ),
            );
          },
          // floatingActionButton: FloatingActionButton(onPressed: () async {
          //   try {
          //     await AppThemeController().toggleThemeMode();
          //   } catch (e) {}
          // }),
        ),
      ),
    );
  }
}
