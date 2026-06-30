import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/home/presentation/cubit/news_cubit.dart';
import '../di/injection.dart' as di; 

class AppRouter {
  AppRouter._();

  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          return BlocProvider<NewsCubit>(
            create: (context) => di.locator<NewsCubit>(),
            child: const HomePage(),
          );
        },
      ),
    ],
  );
}
