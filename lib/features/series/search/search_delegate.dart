import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_series_app/core/constants/colors.dart';
import 'package:tv_series_app/core/widgets/custom_grid_view.dart';
import 'package:tv_series_app/features/series/controller/serie_controller.dart';
import 'package:tv_series_app/models/serie.dart';

class Delegate extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.appBarBg,
        foregroundColor: AppColors.main,
        elevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: AppColors.main),
      ),
    );
  }

  @override
  String get searchFieldLabel => 'Search shows';

  @override
  final TextStyle? searchFieldStyle = TextStyle(color: AppColors.normalText);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [IconButton(onPressed: () => query = '', icon: Icon(Icons.clear))];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Consumer<SerieController>(
      builder: (context, serieController, child) {
        return Container(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Column(
            children: [
              Expanded(
                child: FutureBuilder<List<Serie>>(
                  future: serieController.searchShows(query),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    List<Serie> search = snapshot.data!;
                    return CustomGridView(
                      serieController: serieController,
                      series: search,
                    );
                  },
                ),
              ),
              if (serieController.loading) const CircularProgressIndicator(),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Text('?');
  }
}
