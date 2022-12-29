class Serie {
  int? id;
  String? name;
  List<String>? genres;
  ImageS? image;
  String? summary;

  Serie({
    this.id,
    this.name,
    this.genres,
    this.image,
    this.summary,
  });

  Serie.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    genres = json['genres'].cast<String>();
    image = json['image'] != null ? ImageS.fromJson(json['image']) : null;
    summary = json['summary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name ?? 'No title';
    data['genres'] = genres;
    if (image != null) {
      data['image'] = image!.toJson();
    }
    data['summary'] = summary ?? 'No desciption';
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
