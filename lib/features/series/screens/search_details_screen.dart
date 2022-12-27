import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_series_app/core/constants/colors.dart';
import 'package:tv_series_app/core/utils/text_format.dart';
import 'package:tv_series_app/features/series/controller/serie_controller.dart';
import 'package:tv_series_app/models/search.dart';
import 'package:tv_series_app/models/serie.dart';
import 'package:flutter/src/widgets/image.dart' as img;

class SearchDetailsScreen extends StatelessWidget {
  const SearchDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer<SerieController>(
      builder: (context, provider, child) {
        var serie = provider.currentSearch;
        return SafeArea(
          child: Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                backgroundColor: !provider.screenDetailsScrolled
                    ? AppColors.appBarBg.withOpacity(0.7)
                    : AppColors.appBarBg,
                title: Text('${serie.show!.name}'.toUpperCase()),
                centerTitle: true,
              ),
              body: PrimaryScrollController(
                controller: provider.controllerScreenDetails,
                child: CupertinoScrollbar(
                  thumbVisibility: true,
                  child: CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        automaticallyImplyLeading: false,
                        backgroundColor: AppColors.appBarBg.withOpacity(0.3),
                        expandedHeight: size.height * 0.35,
                        floating: true,
                        pinned: false,
                        flexibleSpace: FlexibleSpaceBar(
                          background: Stack(
                            children: [
                              const Center(
                                child: CircularProgressIndicator(),
                              ),
                              img.Image.network(
                                width: double.infinity,
                                serie.show!.image!.original.toString(),
                                fit: BoxFit.fill,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 12,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GenreLabels(serie: serie),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    TextFormat()
                                        .removeHTMLTags(serie.show!.summary)
                                        .toUpperCase(),
                                    style: TextStyle(
                                      color: AppColors.normalText,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text('EPISODES',
                                      style: TextStyle(color: AppColors.main)),
                                  const SizedBox(height: 15),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    decoration: BoxDecoration(
                                      color: AppColors.scaffoldBg,
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                        color: AppColors
                                            .main, // red as border color
                                      ),
                                    ),
                                    height: 35,
                                    child: DropdownButton(
                                      style: TextStyle(
                                        color: AppColors.normalText,
                                      ),
                                      iconEnabledColor: AppColors.normalText,
                                      dropdownColor: AppColors.main,
                                      focusColor:
                                          AppColors.main.withOpacity(0.3),
                                      underline: const SizedBox(),
                                      value: provider.getSeasonNum(),
                                      items: provider.getSeasonsForDrowpdown(),
                                      onChanged: (int? value) {
                                        provider.setSeasonNum(value!);
                                        var eps =
                                            provider.getSerieEpisodesBySeason();
                                      },
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(top: 10),
                                    height: size.height * 0.6,
                                    child: ListView.builder(
                                      controller:
                                          provider.controllerEpisodesList,
                                      padding: const EdgeInsets.only(
                                          top: 10, bottom: 40),
                                      itemCount:
                                          provider.episodesBySeason.length,
                                      itemBuilder: (context, index) {
                                        var episode =
                                            provider.episodesBySeason[index];
                                        return provider.loading
                                            ? SizedBox(
                                                width: double.infinity,
                                                height: size.height * 0.1,
                                                child: const Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                  strokeWidth: 2,
                                                )),
                                              )
                                            : Container(
                                                padding: const EdgeInsets.only(
                                                    left: 15,
                                                    right: 15,
                                                    bottom: 15),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: size.width * 0.3,
                                                      height: size.height * 0.1,
                                                      child: Stack(
                                                        children: [
                                                          const Center(
                                                            child:
                                                                CircularProgressIndicator(),
                                                          ),
                                                          ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            child: img.Image
                                                                .network(
                                                              episode.image!
                                                                  .original
                                                                  .toString(),
                                                              fit: BoxFit.fill,
                                                              width: double
                                                                  .infinity,
                                                              height: double
                                                                  .infinity,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(width: 20),
                                                    SizedBox(
                                                      width: size.width * 0.4,
                                                      child: Text(
                                                        '${episode.number}. ${episode.name}',
                                                        maxLines: 3,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          color: AppColors
                                                              .normalText,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        );
      },
    );
  }
}

class GenreLabels extends StatelessWidget {
  const GenreLabels({
    Key? key,
    required this.serie,
  }) : super(key: key);

  final Search serie;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: serie.show!.genres!.length,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            margin: const EdgeInsets.only(right: 5),
            decoration: BoxDecoration(
              color: AppColors.main,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              serie.show!.genres![index],
            ),
          );
        },
      ),
    );
  }
}
