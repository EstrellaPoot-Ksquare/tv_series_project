import 'package:flutter/material.dart';
import 'package:tv_series_app/core/utils/dropdown_manager.dart';
import 'package:tv_series_app/features/serie/repository/serie_repository.dart';
import 'package:tv_series_app/models/episode.dart';
import 'package:tv_series_app/models/serie.dart';

class SerieController extends ChangeNotifier {
  // all series
  List<Serie> series = [];
  // list of all episodes in the series
  List<Episode> episodes = [];
  // episodes divided by season
  List<Episode> episodesBySeason = [];
  // selected serie
  Serie currentSerie = Serie();
  int page = 0;

  int _seasonNum = 1;
  bool loading = false;
  // controller for home list view builder
  ScrollController controllerSeriesList = ScrollController();
  // Constructor
  SerieController() {
    addSeries();
    controllerSeriesList.addListener(_scrollListener);
  }
  // Request for get list of series paginated
  getSeriesPerPage(int page) async {
    var response = await SerieRepository().getSeriesPerPage(page);
    return response.map<Serie>((serie) => Serie.fromJson(serie)).toList();
  }

  // function for add request response to series array
  addSeries() async {
    loading = true;
    series.addAll(await getSeriesPerPage(page));
    loading = false;
    notifyListeners();
  }

  // function for the home listviewbuilder controller
  _scrollListener() async {
    // print(controllerSeriesList.offset);
    // print(controllerSeriesList.position.maxScrollExtent);
    // print(controllerSeriesList.position.outOfRange);
    // if (controllerSeriesList.offset >=
    //     controllerSeriesList.position.maxScrollExtent &&
    // !controllerSeriesList.position.outOfRange) {
    // print(controllerSeriesList.position.pixels.roundToDouble());
    // print(controllerSeriesList.position.maxScrollExtent);
    if (controllerSeriesList.offset + 1000 >=
            controllerSeriesList.position.maxScrollExtent &&
        loading == false) {
      print('bottom');
      page++;
      print(page);
      await addSeries();
    }
  }

  // function for get a list with all episodes of a serie
  getEpisodesBySerie(int serieId) async {
    var response = await SerieRepository().getEpisodesBySerie(serieId);
    episodes =
        response.map<Episode>((episode) => Episode.fromJson(episode)).toList();
  }

  // function for set the season selected
  setSeasonNum(int value) {
    _seasonNum = value;
    notifyListeners();
    // return seasonNum;
  }

  // function for get the season selected
  int getSeasonNum() {
    return _seasonNum;
  }

  // function for divide the all episodes by season
  getSerieEpisodesBySeason() {
    episodesBySeason =
        episodes.where((element) => element.season == _seasonNum).toList();
    notifyListeners();
  }

  // function for getting the different seasons and set the list of items for the dropdown button
  getSeasonsForDrowpdown() {
    var seen = <int>{};
    List<Episode> uniquelist =
        episodes.where((element) => seen.add(element.season!)).toList();
    return DropDownManager().dropdownItems(seen);
  }

  // Initialize data for the details series screen
  setSerieDetailsScreen(int serieId) async {
    loading = true;
    // set the season to 1
    setSeasonNum(1);
    // stablish the current serie
    currentSerie = series.firstWhere((element) => element.id == serieId);
    // make a request for get the episodes
    await getEpisodesBySerie(serieId);
    // generate the items for the dropdown button
    getSeasonsForDrowpdown();
    // get episodes by season
    getSerieEpisodesBySeason();
    loading = false;
  }
}
