import 'package:isar/isar.dart';

part 'news_local_model.g.dart'; 

@collection
class NewsLocalModel {
  Id id = Isar.autoIncrement; 

  @Index(unique: true, replace: true)
  late String urlId; 

  late String title;
  late String author;
  late String description;
  late String urlToImage;
  late String publishedAt;
  late String content;
}
