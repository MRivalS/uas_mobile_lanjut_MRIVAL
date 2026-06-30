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
          'sortBy': 'publishedAt',
          'language': 'en', 
          'apiKey': '4170f3d516114fefac86cf34be63d0c6',
        },
      );

      if (response.statusCode == 200) {
        final List articles = response.data['articles'] ?? [];
        
        List<NewsModel> newsList = articles
            .map((json) => NewsModel.fromJson(json))
            .toList();

        newsList.sort(
          (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()),
        );

        return newsList;
      } else {
        throw Exception('Server mengembalikan status: ${response.statusCode}');
      }
    } on DioException catch (e) {
      final errorMsg = e.response?.data['message'] ?? e.message;
      throw Exception('Gagal memuat API Berita: $errorMsg');
    } catch (e) {
      throw Exception('Kesalahan Sistem: $e');
    }
  }
}
