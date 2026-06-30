import 'package:dio/dio.dart';
import '../models/news_model.dart';

class NewsRepository {
  final Dio _dio;

  NewsRepository(this._dio);

  Future<List<NewsModel>> fetchTopNews() async {
    try {
      final response = await _dio.get(
        'everything',
        queryParameters: {
          'q': 'technology',
          'pageSize': 15,
          'apiKey': '8ba7f09f0c7e4c3485b0d0cda8d8c347',
        },
      );

      if (response.statusCode == 200) {
        final List articles = response.data['articles'] ?? [];
        List<NewsModel> newsList = articles
            .map((json) => NewsModel.fromJson(json))
            .toList();

        // Urutan Ascending (A ke Z) untuk NIM Genap Rival
        newsList.sort(
          (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()),
        );

        return newsList;
      } else {
        throw Exception('Gagal memuat berita');
      }
    } catch (e) {
      throw Exception('Kesalahan Jaringan: $e');
    }
  }
}
