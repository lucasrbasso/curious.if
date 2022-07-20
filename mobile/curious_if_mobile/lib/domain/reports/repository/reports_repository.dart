import 'dart:developer';

import 'package:curious_if_mobile/domain/reports/model/get_report.dart';

import '../datasource/reports_api.dart';
import '../model/report_comment.dart';
import '../model/report_post.dart';

abstract class IReportsRepository {
  Future<String> reportPost(ReportPost report, String token);
  Future<List<GetReport>> getReports(String token);
  Future<String> reportComment(ReportComment report, String token);

  Future<String> acceptReport(String idReport, String token);
  Future<String> deleteReport(String idReport, String token);
  void dispose();
}

class ReportsRepository implements IReportsRepository {
  final IReportsApi _datasource;

  ReportsRepository({IReportsApi? datasource})
      : _datasource = datasource ?? ReportsApi();

  @override
  Future<String> reportPost(ReportPost report, String token) async {
    try {
      String response = await _datasource.reportPost(report, token);
      return response;
    } catch (e) {
      throw handleErrorReturn(e);
    }
  }

  @override
  Future<List<GetReport>> getReports(String token) async {
    try {
      String response = await _datasource.getReports(token);
      List<GetReport> getReports = GetReport.fromJsonList(response);
      return getReports;
    } catch (e) {
      throw handleErrorReturn(e);
    }
  }

  @override
  Future<String> reportComment(ReportComment report, String token) async {
    try {
      String response = await _datasource.reportComment(report, token);
      return response;
    } catch (e) {
      throw handleErrorReturn(e);
    }
  }

  @override
  Future<String> acceptReport(String idReport, String token) async {
    try {
      String response = await _datasource.acceptReport(idReport, token);
      return response;
    } catch (e) {
      throw handleErrorReturn(e);
    }
  }

  @override
  Future<String> deleteReport(String idReport, String token) async {
    try {
      String response = await _datasource.deleteReport(idReport, token);
      return response;
    } catch (e) {
      throw handleErrorReturn(e);
    }
  }

  Object handleErrorReturn(Object e) {
    if (e is String) {
      return e;
    } else if (e is Map<String, dynamic>) {
      if (e["message"] is String) {
        throw e["message"];
      } else if (e["message"] is List) {
        List errors = e["message"];
        String error = "";
        for (var element in errors) {
          Map<String, dynamic> errorMap = element["constraints"];
          errorMap.forEach((key, value) {
            error += value + "\n";
          });
        }
        throw error;
      } else {
        throw "Internal error";
      }
    }
    return e;
  }

  @override
  void dispose() {
    _datasource.dispose();
  }
}
