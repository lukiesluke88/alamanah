class User {
  final String id;
  final String name;
  final String? lastName;
  final int age;
  final int? gender;
  final String mobile;
  final String email;
  final String? imageUrl;
  final List<String>? searchKeywords;

  User({
    required this.id,
    required this.name,
    this.lastName,
    required this.age,
    this.gender,
    required this.mobile,
    required this.email,
    this.imageUrl,
    this.searchKeywords,
  });

  /// Convert to Firestore JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'last_name': lastName,
      'age': age,
      'gender': gender,
      'mobile': mobile,
      'email': email,
      'imageUrl': imageUrl,
      'searchKeywords': searchKeywords,
    };
  }

  /// Create User from Firestore
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      lastName: json['last_name'] ?? '',
      age: json['age'] ?? 0,
      gender: json['gender'] ?? 0,
      mobile: json['mobile'] ?? '',
      email: json['email'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      searchKeywords: List<String>.from(json['searchKeywords'] ?? []),
    );
  }

  /// Helper: generate keywords (use this before saving)
  static List<String> generateSearchKeywords(String name, String? lastName) {
    final fullText = '${name.trim()} ${lastName ?? ''}'.toLowerCase().trim();

    final words = fullText.split(' ');
    final keywords = <String>{};

    // full name (important for search)
    keywords.add(fullText);

    // individual words + prefixes
    for (final word in words) {
      if (word.isEmpty) continue;

      keywords.add(word);

      for (int i = 1; i <= word.length; i++) {
        keywords.add(word.substring(0, i));
      }
    }

    return keywords.toList();
  }

  /// Optional: copyWith (very useful in MVVM / Riverpod)
  User copyWith({
    String? id,
    String? name,
    String? lastName,
    int? age,
    int? gender,
    String? mobile,
    String? email,
    String? imageUrl,
    List<String>? searchKeywords,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      mobile: mobile ?? this.mobile,
      email: email ?? this.email,
      imageUrl: imageUrl ?? this.imageUrl,
      searchKeywords: searchKeywords ?? this.searchKeywords,
    );
  }
}