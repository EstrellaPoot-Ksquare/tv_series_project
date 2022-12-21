import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:tv_series_app/core/constants/colors.dart';
import 'package:tv_series_app/features/series/controller/serie_controller.dart';
import 'package:tv_series_app/models/search.dart';

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
    final serieController = Provider.of<SerieController>(context);
    return Container(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<SearchModel>>(
              future: serieController.searchShows(query),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                List<SearchModel> search = snapshot.data!;
                return GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.65,
                    crossAxisSpacing: 12,
                  ),
                  itemCount: search.length,
                  itemBuilder: (context, index) {
                    print(search[index].show!.id!.toInt());
                    return GestureDetector(
                      onTap: () {
                        //print("id: ${search[index].show!.id!}");
                        serieController
                            .setSerieDetailsScreen(search[index].show!.id!);
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
                                  const Center(
                                      child: CircularProgressIndicator()),
                                  FadeInImage.memoryNetwork(
                                    placeholder: kTransparentImage,
                                    image: search[index].show?.image?.medium !=
                                            null
                                        ? "${search[index].show!.image!.medium}"
                                        : 'https://user-images.githubusercontent.com/24848110/33519396-7e56363c-d79d-11e7-969b-09782f5ccbab.png',
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
                                    "${search[index].show!.name}",
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
              },
            ),
          ),
          if (serieController.loading) const CircularProgressIndicator(),
        ],
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Text('?');
  }
}
