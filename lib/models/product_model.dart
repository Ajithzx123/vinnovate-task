class ProductModel {
  int? id;
  String? title;
  dynamic price;
  String? description;
  String? category;
  String? image;
  Rating? rating;

  ProductModel({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.rating,
  });

  ProductModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        title = json['title'] as String?,
        price = json['price'],
        description = json['description'] as String?,
        category = json['category'] as String?,
        image = json['image'] as String?,
        rating = (json['rating'] as Map<String, dynamic>?) != null ? Rating.fromJson(json['rating'] as Map<String, dynamic>) : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'price': price,
        'description': description,
        'category': category,
        'image': image,
        'rating': rating?.toJson()
      };
}

class Rating {
  final dynamic rate;
  final int? count;

  Rating({
    this.rate,
    this.count,
  });

  Rating.fromJson(Map<String, dynamic> json)
      : rate = json['rate'],
        count = json['count'] as int?;

  Map<String, dynamic> toJson() => {'rate': rate, 'count': count};
}
