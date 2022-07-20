import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../core/core.dart';
import '../../../domain/login/model/user_model.dart';
import '../../../domain/management/model/post_management_model.dart';
import '../../../shared/app_bar_simple/app_bar_simple.dart';
import '../manage_posts/widgets/post_manage_widget/post_manage_widget.dart';
import 'manage_reports_controller.dart';
import 'manage_reports_state.dart';
import 'widgets/slidable_card/slidable_card_widget.dart';

class ManageReportsPage extends StatefulWidget {
  final UserModel user;
  const ManageReportsPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<ManageReportsPage> createState() => _ManageReportsPageState();
}

class _ManageReportsPageState extends State<ManageReportsPage> {
  late ManageReportsController _manageReportsController;
  late GlobalKey<AnimatedListState> _listKey;

  @override
  void initState() {
    _listKey = GlobalKey<AnimatedListState>();
    _manageReportsController = ManageReportsController();
    _manageReportsController.getListReports(
        token: widget.user.token, listKey: _listKey);
    _manageReportsController.autoRun(context);
    super.initState();
  }

  @override
  void dispose() {
    _manageReportsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQuery.of(context).padding.top;
    return WillPopScope(
      onWillPop: () async {
        // print(_manageReportsController.postsHome);
        Navigator.of(context, rootNavigator: true)
            .pop(_manageReportsController.subtractReports);
        return false;
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: AppThemeController().colorStatus,
        sized: false,
        child: Scaffold(
          backgroundColor: AppTheme.colors.background,
          appBar: AppBarSimple(
            label: "DENUNCIAS",
            user: widget.user,
            hasSearch: true,
          ),
          body: Observer(
            builder: (context) {
              log("Teste");
              return RefreshIndicator(
                onRefresh: () async {
                  await _manageReportsController.refreshScroll(
                      widget.user.token, _listKey);
                },
                color: AppTheme.colors.titlePost,
                backgroundColor: AppTheme.colors.backgroundButton,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    if (_manageReportsController.state
                        is! ManageReportsStateLoading) ...[
                      SlidableAutoCloseBehavior(
                        child: AnimatedList(
                          padding: const EdgeInsets.only(top: 10),
                          key: _listKey,
                          initialItemCount:
                              _manageReportsController.reports.length,
                          physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          itemBuilder: (context, index, animation) {
                            return Column(
                              children: [
                                SlidableReportCardWidget(
                                    key: Key(_manageReportsController
                                        .reports[index]
                                        .toString()),
                                    onPublishEdit: (context, publish) =>
                                        _manageReportsController.onPublishEdit(
                                          _manageReportsController
                                              .reports[index].id,
                                          widget.user.token,
                                          () => _manageReportsController
                                              .onAnimationDeletion(
                                                  index, _listKey, context),
                                          _manageReportsController
                                              .reports[index].postId,
                                          _manageReportsController
                                                  .reports[index].comment ==
                                              null,
                                          publish,
                                        ),
                                    onDismissed: (publish) =>
                                        _manageReportsController.onDismissed(
                                            index, context, _listKey),
                                    confirmDismiss: (publish) =>
                                        _manageReportsController.confirmDismiss(
                                          _manageReportsController
                                              .reports[index].id,
                                          widget.user.token,
                                          () => _manageReportsController
                                              .onAnimationDeletion(
                                                  index, _listKey, context),
                                          _manageReportsController
                                              .reports[index].postId,
                                          _manageReportsController
                                                  .reports[index].comment ==
                                              null,
                                          publish,
                                        ),
                                    report: _manageReportsController
                                        .reports[index]),
                                const SizedBox(height: 8)
                              ],
                            );
                          },
                        ),
                      )
                    ] else ...[
                      ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              PostManageWidget(
                                  key: UniqueKey(),
                                  post: PostManagementModel.mock(),
                                  loading: true),
                              const SizedBox(height: 8)
                            ],
                          );
                        },
                      ),
                    ]
                  ],
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
      ),
    );
  }
}
