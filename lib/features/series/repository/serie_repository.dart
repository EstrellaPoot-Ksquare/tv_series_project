import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tv_series_app/core/constants/url.dart';
import 'package:tv_series_app/models/search.dart';

class SerieRepository {
  getSeriesPerPage(int page) async {
    var requestUrl =
        Uri.parse('${AppUrl.seriesServer}${AppUrl.showsPerPage}$page');
    var response = await http.get(requestUrl);
    checkAndThrowError(response);
    var respJson = jsonDecode(response.body);
    return respJson;
  }

  getEpisodesBySerie(int id) async {
    var requestUrl = Uri.parse(
        '${AppUrl.seriesServer}${AppUrl.showInfo}$id${AppUrl.showEpisodes}');
    var response = await http.get(requestUrl);
    checkAndThrowError(response);
    var respJson = jsonDecode(response.body);
    return respJson;
  }

  static void checkAndThrowError(http.Response response) {
    if (response.statusCode != 200) {
      throw Exception(response.body);
    }
  }

  searchShows(String query) async {
    var requestUrl =
        Uri.parse('${AppUrl.seriesServer}${AppUrl.searchShows}$query');
    var response = await http.get(requestUrl);
    checkAndThrowError(response);
    var respJson = jsonDecode(response.body);
    var newList = respJson.map((value) => value['show']).toList();
    return newList;
  }
}
