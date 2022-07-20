import 'dart:developer';

import 'package:curious_if_mobile/domain/reports/model/get_report.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import '../../../../core/core.dart';
import '../../../domain/reports/usecase/reports_usecase.dart';
import 'manage_reports_state.dart';
import 'widgets/post_manage_widget/report_manage_widget.dart';
part 'manage_reports_controller.g.dart';

class ManageReportsController extends _ManageReportsControllerBase
    with _$ManageReportsController {
  ManageReportsController({IReportsUseCase? reportsUseCase}) {
    _reportsUseCase = reportsUseCase ?? ReportsUseCase();
  }
}

abstract class _ManageReportsControllerBase with Store {
  late IReportsUseCase _reportsUseCase;

  late ReactionDisposer reactionDisposer;

  @observable
  ManageReportsState state = ManageReportsStateEmpty();

  @observable
  ObservableList<GetReport> reports = ObservableList.of([]);

  List<String> subtractReports = [];

  @observable
  int loadingShimmer = 5;

  @action
  void modifyShimmer(int length) => loadingShimmer = length;

  @action
  Future<void> _modifyManageReportsState(
          ManageReportsState stateModify) async =>
      state = stateModify;

  @action
  Future<void> getListReports({
    required String token,
    required GlobalKey<AnimatedListState> listKey,
  }) async {
    try {
      await _modifyManageReportsState(ManageReportsStateLoading());
      print("chegou aqui");
      await Future.delayed(const Duration(seconds: 2));
      List<GetReport> reports = await _reportsUseCase.getReports(token);
      print("chegou aqui2");
      print(reports);
      this.reports.removeWhere((element) => true);
      this.reports.addAll(reports);
      await _modifyManageReportsState(ManageReportsStateSuccess(
          message: "reportss buscados com sucesso", reports: reports));
    } catch (e) {
      await _modifyManageReportsState(
          ManageReportsStateFailure(message: e.toString()));
    }
  }

  @action
  Future<void> onPublishEdit(
      String id,
      String token,
      Function onAnimationDeletion,
      String postId,
      bool isPost,
      bool isAccept) async {
    try {
      await deleteOrAcceptReport(
          token: token,
          id: id,
          postId: postId,
          isPost: isPost,
          isAccept: isAccept);
      await onAnimationDeletion();
    } catch (e) {
      log(e.toString());
    }
  }

  @action
  Future<bool> confirmDismiss(
      String id,
      String token,
      Function onAnimationDeletion,
      String postId,
      bool isPost,
      bool isAccept) async {
    try {
      await deleteOrAcceptReport(
          token: token,
          id: id,
          postId: postId,
          isPost: isPost,
          isAccept: isAccept);
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
    reports.removeAt(index);
    listKey.currentState!
        .removeItem(index, (context, animation) => Container());
  }

  Future<void> onAnimationDeletion(int index,
      GlobalKey<AnimatedListState> listKey, BuildContext context) async {
    GetReport removedItem = reports.removeAt(index);
    AnimatedListRemovedItemBuilder builder;
    builder = (context, animation) => removeItem(removedItem, animation, index);

    listKey.currentState!.removeItem(index, builder,
        duration: const Duration(milliseconds: 300));
  }

  Widget removeItem(GetReport item, Animation<double> animation, int index) {
    return SizeTransition(
      sizeFactor: animation,
      child: Column(
        children: [
          ReportManageWidget(key: UniqueKey(), report: item),
          const SizedBox(height: 20)
        ],
      ),
    );
  }

  @action
  Future<void> deleteOrAcceptReport({
    required String token,
    required String id,
    required String postId,
    required bool isPost,
    required bool isAccept,
  }) async {
    try {
      if (isAccept) {
        await _reportsUseCase.acceptReport(id, token);
      } else {
        await _reportsUseCase.deleteReport(id, token);
      }
      if (isAccept && isPost) {
        subtractReports.insert(0, postId);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> refreshScroll(
    String token,
    GlobalKey<AnimatedListState> listKey,
  ) async {
    if ((state is! ManageReportsStateLoading) || reports.isNotEmpty) {
      reports.removeWhere((element) => true);
      await getListReports(token: token, listKey: listKey);
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
      if (state is ManageReportsStateFailure) {
        modifyShimmer(0);
        String message = (state as ManageReportsStateFailure).message;
        await _modifyManageReportsState(ManageReportsStateEmpty());
        showSnackBar(context, message, Colors.red);
      } else if (state is ManageReportsStateSuccess) {
        modifyShimmer(0);
        await _modifyManageReportsState(ManageReportsStateEmpty());
      } else if (state is ManageReportsStateLoading) {
        modifyShimmer(5);
      }
    });
  }

  void dispose() {
    _reportsUseCase.dispose();
    reactionDisposer.reaction.dispose();
  }
}
