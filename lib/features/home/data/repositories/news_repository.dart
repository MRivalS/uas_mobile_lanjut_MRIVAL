import 'package:dio/dio.dart';
import '../../../../core/database/isar_service.dart';
import '../models/news_model.dart';
import '../models/news_local_model.dart';

class NewsRepository {
  final Dio _dio;
  final IsarService _isarService; // Inject Isar Service

  NewsRepository(this._dio, this._isarService);

  Future<List<NewsModel>> fetchTopNews() async {
    try {
      // 1. Ambil data secara live dari NewsAPI
      final response = await _dio.get(
        'everything',
        queryParameters: {
          'q': 'technology',
          'pageSize': 15,
          'sortBy': 'publishedAt',
          'language': 'en',
          'apiKey':
              '4170f3d516114fefac86cf34be63d0c6',
        },
      );

      if (response.statusCode == 200) {
        final List articles = response.data['articles'] ?? [];

        List<NewsModel> newsList = articles
            .map((json) => NewsModel.fromJson(json))
            .toList();
        List<NewsLocalModel> localNewsList = newsList.map((news) {
          return NewsLocalModel()
            ..urlId = news.id
            ..title = news.title
            ..author = news.author
            ..description = news.description
            ..urlToImage = news.urlToImage
            ..publishedAt = news.publishedAt
            ..content = news.content;
        }).toList();

        await _isarService.cacheNews(localNewsList);

        newsList.sort(
          (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()),
        );
        return newsList;
      } else {
        throw Exception();
      }
    } catch (e) {
      final List<NewsLocalModel> localData = await _isarService.getCachedNews();
      if (localData.isNotEmpty) {
        List<NewsModel> cachedList = localData.map((local) {
          return NewsModel(
            id: local.urlId,
            title: local.title,
            author: local.author,
            description: local.description,
            urlToImage: local.urlToImage,
            publishedAt: local.publishedAt,
            content: local.content,
          );
        }).toList();
        cachedList.sort(
          (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()),
        );
        return cachedList;
      }

      throw Exception(
        'Koneksi internet terputus dan tidak ada data cache lokal.',
      );
    }
  }
}
