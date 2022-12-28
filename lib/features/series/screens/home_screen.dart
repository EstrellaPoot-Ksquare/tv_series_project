import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/image.dart' as img;
import 'package:provider/provider.dart';
import 'package:tv_series_app/core/widgets/custom_grid_view_widget.dart';
import 'package:tv_series_app/features/series/controller/serie_controller.dart';
import 'package:tv_series_app/features/series/search/search_delegate.dart';
import 'package:tv_series_app/models/serie.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          width: 140,
          child: img.Image.asset('images/logo.png'),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => showSearch(context: context, delegate: Delegate()),
            icon: const Icon(
              Icons.search,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/settings");
            },
            icon: const Icon(
              Icons.settings,
              size: 30,
            ),
          ),
        ],
      ),
      body: Consumer<SerieController>(
        builder: (context, serieController, child) {
          List<Serie> series = serieController.series;
          return series.isNotEmpty
              ? Container(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  child: Column(
                    children: [
                      Expanded(
                        child: CustomGridView(
                          serieController: serieController,
                          series: series,
                          controller: serieController.controllerSeriesList,
                        ),
                      ),
                      if (serieController.loading)
                        /*Positioned(
                      child: CircularProgressIndicator(),
                      bottom: 40,
                      left: MediaQuery.of(context).size.width * .5 - 30,
                    )*/
                        const CircularProgressIndicator(),
                    ],
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
