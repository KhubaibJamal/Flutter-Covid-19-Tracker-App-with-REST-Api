import 'dart:convert';
import 'package:covid_19_tracker_with_api/Services/Utiles/app_urls.dart';
import '../Models/WorldStatedModel.dart';
import 'package:http/http.dart' as http;

class StatesServices {
  Future<WorldStatesModel> fetchWorldStatesRecords() async {
    final response = await http.get(Uri.parse(AppUrl.worldStatesApi));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      // print(data);
      return WorldStatesModel.fromJson(data);
    } else {
      throw Exception("Error");
    }
  }

  Future<List<dynamic>> countriesListApi() async {
    final response = await http.get(Uri.parse(AppUrl.countriesList));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      return data;
    } else {
      throw Exception("Error");
    }
  }
}
