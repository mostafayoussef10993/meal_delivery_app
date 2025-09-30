class Meal {
  final String id;
  final String name;
  final String description;
  final double price;
  final String image;
  final double rating;
  final String country;

  Meal({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.rating,
    required this.country,
  });

  factory Meal.fromMap(Map<String, dynamic> map) {
    return Meal(
      id: map['id']?.toString() ?? '',
      name: map['name'] ?? '',
      description: map['dsc'] ?? '',
      price: (map['price'] is num)
          ? (map['price'] as num).toDouble()
          : double.tryParse(map['price'].toString()) ?? 0.0,
      image: map['img'] ?? '',
      rating: (map['rate'] is num)
          ? (map['rate'] as num).toDouble()
          : double.tryParse(map['rate'].toString()) ?? 0.0,
      country: map['country'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'dsc': description,
      'price': price,
      'img': image,
      'rate': rating,
      'country': country,
    };
  }
}
