class Prompt {
  final String id;
  final String title;
  final String text;
  final String imageUrl;
  final String category;
  final bool isPremium;
  bool isFavorite;

  Prompt({
    required this.id,
    required this.title,
    required this.text,
    required this.imageUrl,
    required this.category,
    this.isPremium = false,
    this.isFavorite = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'text': text,
      'imageUrl': imageUrl,
      'category': category,
      'isPremium': isPremium ? 1 : 0,
      'isFavorite': isFavorite ? 1 : 0,
    };
  }

  factory Prompt.fromMap(Map<String, dynamic> map) {
    return Prompt(
      id: map['id'],
      title: map['title'],
      text: map['text'],
      imageUrl: map['imageUrl'],
      category: map['category'],
      isPremium: map['isPremium'] == 1,
      isFavorite: map['isFavorite'] == 1,
    );
  }
}
