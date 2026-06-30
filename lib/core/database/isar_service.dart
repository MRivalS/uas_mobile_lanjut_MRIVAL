import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../../features/home/data/models/news_local_model.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      return await Isar.open(
        [NewsLocalModelSchema], 
        directory: dir.path,
      );
    }
    return Isar.getInstance()!;
  }

  Future<void> cacheNews(List<NewsLocalModel> newsList) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.newsLocalModels.putAll(newsList);
    });
  }

  Future<List<NewsLocalModel>> getCachedNews() async {
    final isar = await db;
    return await isar.newsLocalModels.where().findAll();
  }
}
