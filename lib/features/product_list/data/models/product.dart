class Product {
  int? id;
  String? title;
  String? description;
  int? price;
  int? rating;
  String? thumbnail;
  String? youtubeVideo;

  Product({
    this.id,
    this.title,
    this.description,
    this.price,
    this.rating,
    this.thumbnail,
    this.youtubeVideo,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    rating = json['rating'];
    thumbnail = json['thumbnail'];
    youtubeVideo = json['youtube_video'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['price'] = price;
    data['rating'] = rating;
    data['thumbnail'] = thumbnail;
    data['youtube_video'] = youtubeVideo;
    return data;
  }
}
