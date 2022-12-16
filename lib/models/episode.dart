class Episode {
  int? id;
  String? name;
  int? season;
  int? number;
  ImageS? image;
  String? summary;

  Episode({
    this.id,
    this.name,
    this.season,
    this.number,
    this.image,
    this.summary,
  });

  Episode.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    season = json['season'];
    number = json['number'];
    image = json['image'] != null ? ImageS.fromJson(json['image']) : null;
    summary = json['summary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['season'] = season;
    data['number'] = number;
    if (image != null) {
      data['image'] = image!.toJson();
    }
    data['summary'] = summary;
    return data;
  }
}

class ImageS {
  String? medium;
  String? original;

  ImageS({this.medium, this.original});

  ImageS.fromJson(Map<String, dynamic> json) {
    medium = json['medium'];
    original = json['original'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['medium'] = medium;
    data['original'] = original;
    return data;
  }
}
