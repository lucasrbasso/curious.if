import 'package:curious_if_mobile/domain/reports/model/get_report.dart';

abstract class ManageReportsState {}

class ManageReportsStateEmpty extends ManageReportsState {}

class ManageReportsStateLoading extends ManageReportsState {}

class ManageReportsStateFailure extends ManageReportsState {
  final String message;
  ManageReportsStateFailure({
    required this.message,
  });
}

class ManageReportsStateSuccess extends ManageReportsState {
  final String message;
  final List<GetReport> reports;
  ManageReportsStateSuccess({
    required this.message,
    required this.reports,
  });
}
