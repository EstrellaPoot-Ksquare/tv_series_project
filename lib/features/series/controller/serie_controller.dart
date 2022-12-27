import 'package:flutter/material.dart';
import 'package:tv_series_app/core/utils/dropdown_manager.dart';
import 'package:tv_series_app/core/utils/scroll_manager.dart';
import 'package:tv_series_app/features/series/repository/serie_repository.dart';
import 'package:tv_series_app/models/episode.dart';
import 'package:tv_series_app/models/serie.dart';

class SerieController extends ChangeNotifier {
  // all series
  List<Serie> series = [];
  // list of all episodes in the series
  List<Episode> episodes = [];
  // episodes divided by season
  List<Episode> episodesBySeason = [];
  List<Serie> searchList = [];

  // selected serie
  Serie currentSerie = Serie();
  int page = 0;

  int _seasonNum = 1;
  bool loading = false;
  bool screenDetailsScrolled = true;

  ScrollController controllerSeriesList = ScrollController();
  ScrollController controllerEpisodesList = ScrollController();
  ScrollController controllerScreenDetails = ScrollController();

  SerieController() {
    addSeries();
    controllerSeriesList.addListener(_scrollListener);
    controllerScreenDetails.addListener(_detailsScreenScrollListener);
  }

  getSeriesPerPage(int page) async {
    var response = await SerieRepository().getSeriesPerPage(page);
    return response.map<Serie>((serie) => Serie.fromJson(serie)).toList();
  }

  addSeries() async {
    series.addAll(await getSeriesPerPage(page));
    notifyListeners();
  }

  _scrollListener() async {
    if (controllerSeriesList.position.maxScrollExtent ==
        controllerSeriesList.offset) {
      loading = true;
      notifyListeners();
      page++;
      await addSeries();
      loading = false;
    }
  }

  _detailsScreenScrollListener() async {
    if (controllerScreenDetails.offset >= 200) {
      screenDetailsScrolled = true;
      notifyListeners();
    } else if (controllerScreenDetails.offset < 200) {
      screenDetailsScrolled = false;
      notifyListeners();
    }
  }

  getEpisodesBySerie(int serieId) async {
    var response = await SerieRepository().getEpisodesBySerie(serieId);
    episodes =
        response.map<Episode>((episode) => Episode.fromJson(episode)).toList();
  }

  setSeasonNum(int value) {
    _seasonNum = value;
    notifyListeners();
  }

  int getSeasonNum() {
    return _seasonNum;
  }

  getSerieEpisodesBySeason() {
    episodesBySeason =
        episodes.where((element) => element.season == _seasonNum).toList();
    ScrollManager().scrollToTopPosition(controllerEpisodesList);
    notifyListeners();
  }

  getSeasonsForDrowpdown() {
    var seen = <int>{};
    List<Episode> uniquelist =
        episodes.where((element) => seen.add(element.season!)).toList();
    return DropDownManager().dropdownItems(seen);
  }

  setSerieDetailsScreen(int serieId, List list) async {
    loading = true;
    setSeasonNum(1);
    currentSerie = list.firstWhere((element) => element.id == serieId);
    await getEpisodesBySerie(serieId);
    notifyListeners();
    ScrollManager().scrollToTopPosition(controllerScreenDetails);
    screenDetailsScrolled = false;
    getSeasonsForDrowpdown();
    getSerieEpisodesBySeason();
    loading = false;
  }

  Future<List<Serie>> searchShows(String query) async {
    searchList.clear();
    var response = await SerieRepository().searchShows(query);
    var searchResponse =
        response.map<Serie>((search) => Serie.fromJson(search)).toList();
    searchList.addAll(searchResponse);
    return searchList;
  }
}
