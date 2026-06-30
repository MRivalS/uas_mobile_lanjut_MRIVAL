class NewsModel {
  final String id;
  final String title;
  final String author;
  final String description;
  final String urlToImage;
  final String publishedAt;
  final String content;

  NewsModel({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['url'] ?? '', 
      title: json['title'] ?? 'No Title',
      author: json['author'] ?? 'Unknown Author',
      description: json['description'] ?? '',
      urlToImage: json['urlToImage'] ?? 'https://via.placeholder.com/150',
      publishedAt: json['publishedAt'] ?? '',
      content: json['content'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': id,
      'title': title,
      'author': author,
      'description': description,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'content': content,
    };
  }
}
