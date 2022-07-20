import '../model/get_report.dart';
import '../model/report_comment.dart';
import '../model/report_post.dart';
import '../repository/reports_repository.dart';

abstract class IReportsUseCase {
  Future<String> reportPost(ReportPost report, String token);
  Future<List<GetReport>> getReports(String token);
  Future<String> reportComment(ReportComment report, String token);

  Future<String> acceptReport(String idReport, String token);
  Future<String> deleteReport(String idReport, String token);
  void dispose();
}

class ReportsUseCase implements IReportsUseCase {
  final IReportsRepository _repository;

  ReportsUseCase({IReportsRepository? repository})
      : _repository = repository ?? ReportsRepository();

  @override
  Future<List<GetReport>> getReports(String token) async {
    try {
      List<GetReport> getReports = await _repository.getReports(token);
      return getReports;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> acceptReport(String idReport, String token) async {
    try {
      String response = await _repository.acceptReport(idReport, token);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> deleteReport(String idReport, String token) async {
    try {
      String response = await _repository.deleteReport(idReport, token);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> reportPost(ReportPost report, String token) async {
    try {
      String response = await _repository.reportPost(report, token);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> reportComment(ReportComment report, String token) async {
    try {
      String response = await _repository.reportComment(report, token);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  void dispose() {
    _repository.dispose();
  }
}
