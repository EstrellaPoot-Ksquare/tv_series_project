import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_series_app/core/widgets/custom_grid_view.dart';
import 'package:tv_series_app/features/series/controller/serie_controller.dart';
import 'package:tv_series_app/models/search.dart';

class Delegate extends SearchDelegate {
  @override
  String get searchFieldLabel => 'Search T.V. shows';

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [IconButton(onPressed: () => query = '', icon: Icon(Icons.clear))];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Text('buildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    if (query.isEmpty) {
      return Text('Empty');
    }
    final searchShow = Provider.of<SerieController>(context, listen: false);
    List<SearchModel> search = searchShow.search;
    return FutureBuilder(
      future: searchShow.searchShows(query),
      builder: (_, snapshot) {
        if (!snapshot.hasData)
          return Text('Empty');
        else
          return Container();
      },
    );
  }
}
