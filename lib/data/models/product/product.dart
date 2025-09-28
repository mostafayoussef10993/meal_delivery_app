//Product Model

class Product {
  final int id;
  final String title;
  final double price;
  final String thumbnail;
  final double rating;
  final String description;
  final String brand;
  final String category;
  final List<String> tags;
  final double discountPercentage;
  final List<Review> reviews;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.thumbnail,
    required this.rating,
    required this.description,
    required this.brand,
    required this.category,
    required this.tags,
    required this.discountPercentage,
    required this.reviews,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] ?? 0,
      title: map['title'] ?? 'No title',
      price: (map['price'] != null) ? (map['price'] as num).toDouble() : 0.0,
      thumbnail: map['thumbnail'] ?? 'https://via.placeholder.com/150',
      rating: (map['rating'] != null) ? (map['rating'] as num).toDouble() : 0.0,
      description: map['description'] ?? 'No description',
      brand: map['brand'] ?? 'Unknown',
      category: map['category'] ?? 'Uncategorized',
      tags: (map['tags'] != null) ? List<String>.from(map['tags']) : [],
      discountPercentage: (map['discountPercentage'] != null)
          ? (map['discountPercentage'] as num).toDouble()
          : 0.0,
      reviews: (map['reviews'] != null)
          ? List<Map<String, dynamic>>.from(
              map['reviews'],
            ).map((e) => Review.fromMap(e)).toList()
          : [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'thumbnail': thumbnail,
      'rating': rating,
      'description': description,
      'brand': brand,
      'category': category,
      'tags': tags,
      'discountPercentage': discountPercentage,
      'reviews': reviews.map((e) => e.toMap()).toList(),
    };
  }
}

// Review Model

class Review {
  final int rating;
  final String comment;
  final DateTime date;
  final String reviewerName;
  final String reviewerEmail;

  Review({
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerName,
    required this.reviewerEmail,
  });

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      rating: (map['rating'] ?? 0) as int,
      comment: map['comment'] ?? '',
      date: DateTime.tryParse(map['date'] ?? '') ?? DateTime.now(),
      reviewerName: map['reviewerName'] ?? 'Anonymous',
      reviewerEmail: map['reviewerEmail'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'rating': rating,
      'comment': comment,
      'date': date.toIso8601String(),
      'reviewerName': reviewerName,
      'reviewerEmail': reviewerEmail,
    };
  }
}
