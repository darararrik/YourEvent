class Agency {
  final String id;
  final String name;
  final String avatarUrl;
  final double rating;
  final String city;

  Agency({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.rating,
    required this.city,
  });

  factory Agency.fromJson(Map<String, dynamic> json, String id) {
    return Agency(
      id: id,
      name: json['name'],
      avatarUrl: json['avatarUrl'],
      rating: (json['rating'] as num).toDouble(),
      city: json['city'],
    );
  }

}