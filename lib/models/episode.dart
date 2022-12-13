class Episode {
  int? id;
  String? url;
  String? name;
  int? season;
  int? number;
  String? type;
  String? airdate;
  String? airtime;
  String? airstamp;
  int? runtime;
  Rating? rating;
  Image? image;
  String? summary;
  Links? lLinks;

  Episode(
      {this.id,
      this.url,
      this.name,
      this.season,
      this.number,
      this.type,
      this.airdate,
      this.airtime,
      this.airstamp,
      this.runtime,
      this.rating,
      this.image,
      this.summary,
      this.lLinks});

  Episode.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    name = json['name'];
    season = json['season'];
    number = json['number'];
    type = json['type'];
    airdate = json['airdate'];
    airtime = json['airtime'];
    airstamp = json['airstamp'];
    runtime = json['runtime'];
    rating = json['rating'] != null ? Rating.fromJson(json['rating']) : null;
    image = json['image'] != null ? Image.fromJson(json['image']) : null;
    summary = json['summary'];
    lLinks = json['_links'] != null ? Links.fromJson(json['_links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['url'] = url;
    data['name'] = name;
    data['season'] = season;
    data['number'] = number;
    data['type'] = type;
    data['airdate'] = airdate;
    data['airtime'] = airtime;
    data['airstamp'] = airstamp;
    data['runtime'] = runtime;
    if (rating != null) {
      data['rating'] = rating!.toJson();
    }
    if (image != null) {
      data['image'] = image!.toJson();
    }
    data['summary'] = summary;
    if (lLinks != null) {
      data['_links'] = lLinks!.toJson();
    }
    return data;
  }
}

class Rating {
  num? average;

  Rating({this.average});

  Rating.fromJson(Map<String, dynamic> json) {
    average = json['average'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['average'] = average;
    return data;
  }
}

class Image {
  String? medium;
  String? original;

  Image({this.medium, this.original});

  Image.fromJson(Map<String, dynamic> json) {
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

class Links {
  Self? self;
  Self? show;

  Links({this.self, this.show});

  Links.fromJson(Map<String, dynamic> json) {
    self = json['self'] != null ? Self.fromJson(json['self']) : null;
    show = json['show'] != null ? Self.fromJson(json['show']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (self != null) {
      data['self'] = self!.toJson();
    }
    if (show != null) {
      data['show'] = show!.toJson();
    }
    return data;
  }
}

class Self {
  String? href;

  Self({this.href});

  Self.fromJson(Map<String, dynamic> json) {
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['href'] = href;
    return data;
  }
}
