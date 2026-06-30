import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/news_repository.dart';
import 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  final NewsRepository _repository;

  NewsCubit(this._repository) : super(NewsInitial());

  Future<void> getNews() async {
    emit(NewsLoading());
    try {
      final articles = await _repository.fetchTopNews();
      emit(NewsLoaded(articles));
    } catch (e) {
      emit(NewsError(e.toString()));
    }
  }
}
