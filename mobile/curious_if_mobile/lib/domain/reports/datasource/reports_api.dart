import 'dart:convert';
import 'package:http/http.dart' show Client;

import '../../../core/core.dart';
import '../../roles-permission/model/roles_permission_model.dart';
import '../model/report_comment.dart';
import '../model/report_post.dart';

abstract class IReportsApi {
  Future<String> reportPost(ReportPost report, String token);
  Future<String> reportComment(ReportComment report, String token);
  Future<String> getReports(String token);
  Future<String> acceptReport(String idReport, String token);
  Future<String> deleteReport(String idReport, String token);
  void dispose();
}

class ReportsApi implements IReportsApi {
  final Client client = Client();
  final String server = UtilsConst.server;

  @override
  void dispose() {
    client.close();
  }

  @override
  Future<String> getReports(String token) async {
    try {
      final response = await client.get(
        Uri.parse(server + "api/reports/"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      ).timeout(const Duration(seconds: 10));
      if (response.statusCode == 201 || response.statusCode == 200) {
        return response.body;
      } else if (response.statusCode == 400 || response.statusCode == 401) {
        throw json.decode(response.body);
      } else {
        throw "Erro na conexão da API (Status: ${response.statusCode})";
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> acceptReport(String idReport, String token) async {
    try {
      final response = await client.delete(
        Uri.parse(server + "api/reports/accept/$idReport"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      ).timeout(const Duration(seconds: 10));
      if (response.statusCode == 201 || response.statusCode == 200) {
        return response.body;
      } else if (response.statusCode == 400 || response.statusCode == 401) {
        throw json.decode(response.body);
      } else {
        throw "Erro na conexão da API (Status: ${response.statusCode})";
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> deleteReport(String idReport, String token) async {
    try {
      final response = await client.delete(
        Uri.parse(server + "api/reports/dismiss/$idReport"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      ).timeout(const Duration(seconds: 10));
      if (response.statusCode == 201 || response.statusCode == 200) {
        return response.body;
      } else if (response.statusCode == 400 || response.statusCode == 401) {
        throw json.decode(response.body);
      } else {
        throw "Erro na conexão da API (Status: ${response.statusCode})";
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> reportPost(ReportPost report, String token) async {
    try {
      final response = await client
          .post(
            Uri.parse(server + "api/reports/"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer $token'
            },
            body: jsonEncode(<String, String>{
              "postId": report.postId,
              "content": report.content,
              "type": report.type
            }),
          )
          .timeout(const Duration(seconds: 10));
      if (response.statusCode == 201 || response.statusCode == 200) {
        return response.body;
      } else if (response.statusCode == 400 || response.statusCode == 401) {
        throw json.decode(response.body);
      } else {
        throw "Erro na conexão da API (Status: ${response.statusCode})";
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> reportComment(ReportComment report, String token) async {
    try {
      final response = await client
          .post(
            Uri.parse(server + "api/reports/"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer $token'
            },
            body: jsonEncode(<String, String>{
              "postId": report.postId,
              "commentId": report.commentId,
              "content": report.content,
              "type": report.type
            }),
          )
          .timeout(const Duration(seconds: 10));
      if (response.statusCode == 201 || response.statusCode == 200) {
        return response.body;
      } else if (response.statusCode == 400 || response.statusCode == 401) {
        throw json.decode(response.body);
      } else {
        throw "Erro na conexão da API (Status: ${response.statusCode})";
      }
    } catch (e) {
      rethrow;
    }
  }
}
