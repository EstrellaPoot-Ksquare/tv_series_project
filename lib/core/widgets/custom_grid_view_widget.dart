import 'package:flutter/material.dart';
import 'package:tv_series_app/features/series/controller/serie_controller.dart';
import 'package:tv_series_app/models/serie.dart';

class CustomGridView extends StatelessWidget {
  const CustomGridView({
    Key? key,
    required this.serieController,
    required this.series,
    this.controller,
  }) : super(key: key);

  final SerieController serieController;
  final List<Serie> series;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: controller,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.65,
        crossAxisSpacing: 12,
      ),
      itemCount: series.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            serieController.setSerieDetailsScreen(series[index].id!, series);
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
                      Image.network(
                        series[index].image != null
                            ? "${series[index].image!.medium}"
                            : 'https://www.azendportafolio.com/static/img/not-found.png',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                      // FadeInImage.memoryNetwork(
                      //   placeholder: kTransparentImage,
                      //   image: series[index].image != null
                      //       ? "${series[index].image!.medium}"
                      //       : 'https://www.azendportafolio.com/static/img/not-found.png',
                      //   fit: BoxFit.cover,
                      //   width: double.infinity,
                      //   height: double.infinity,
                      // ),
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
    );
  }
}
