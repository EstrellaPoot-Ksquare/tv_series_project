import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/image.dart' as img;
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:tv_series_app/features/series/controller/serie_controller.dart';
import 'package:tv_series_app/features/series/search/search_delegate.dart';
import 'package:tv_series_app/models/serie.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final serieController = Provider.of<SerieController>(context);
    List<Serie> series = serieController.series;

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
      body: series.isNotEmpty
          ? CustomGridView(serieController: serieController, series: series)
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

class CustomGridView extends StatelessWidget {
  const CustomGridView({
    Key? key,
    required this.serieController,
    required this.series,
  }) : super(key: key);

  final SerieController serieController;
  final List<Serie> series;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: Column(
        children: [
          Expanded(
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              controller: serieController.controllerSeriesList,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                crossAxisSpacing: 12,
              ),
              itemCount: series.length,
              itemBuilder: (context, index) {
                var serie = series[index];
                return GestureDetector(
                  onTap: () {
                    serieController.setSerieDetailsScreen(serie.id!);
                    Navigator.pushNamed(context, '/serie-details');
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 12),
                    child: Stack(children: [
                      SizedBox(
                        height: double.infinity,
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Stack(
                            children: [
                              const Center(child: CircularProgressIndicator()),
                              FadeInImage.memoryNetwork(
                                placeholder: kTransparentImage,
                                image: "${series[index].image!.medium}",
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 80,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.black.withOpacity(0.6),
                            ),
                            padding: const EdgeInsets.all(12),
                            child: Center(
                              child: Text(
                                "${series[index].name}",
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.white),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                );
              },
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
    );
  }
}
