import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:srv/model/model.dart';
import 'package:srv/model/sidebar.dart';

class ApiClient {
  static const String baseUrl = 'https://asapapi.srvinfotech.com/';

  Future<List<Batch>> fetchData() async {
    const String token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NWU1NjIyYjhhOTExMjcxMGZkZGE5ZjYiLCJpYXQiOjE3MTM4NDUyODUsImV4cCI6MTcxNTU3MzI4NX0.9Je7bJl4tnR18tc0k7pT7kQ38jB1PZDsIZHoI6ltv2I";
    final url = Uri.parse(
        'https://asapapi.srvinfotech.com/staff/api/dashboard/batch/card');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'x-access-token': token,
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      // log(responseData.toString());
      return responseData.map((json) => Batch.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch data: ${response.reasonPhrase}');
    }
  }

  Future<List<SidebarItem>> fetchDataSidebar() async {
    const String token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NWU1NjIyYjhhOTExMjcxMGZkZGE5ZjYiLCJpYXQiOjE3MTM4NDUyODUsImV4cCI6MTcxNTU3MzI4NX0.9Je7bJl4tnR18tc0k7pT7kQ38jB1PZDsIZHoI6ltv2I";
    final url =
        Uri.parse('https://asapapi.srvinfotech.com/staff/api/auth/sidebar');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'x-access-token': token,
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body)['data'] as List;
      log(responseData.toString());
      return responseData.map((json) => SidebarItem.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch data: ${response.reasonPhrase}');
    }
  }
}
