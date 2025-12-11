import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/features/movies/data/models/movie_details_model.dart';
import 'package:movie_app/features/movies/data/repositories/movie_detalis_repository.dart';
part 'movie_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  MovieDetailsCubit() : super(MovieDetailsInitial());

  Future<void> fetchMovieDetails(int movieId) async {
    emit(MovieDetailsLoadingState());

    try {
      final result = await MovieDetailsRepository.getMovieDetails(movieId: movieId);

      if (result == null) {
        emit(MovieDetailsErrorState('فشل تحميل تفاصيل الفيلم'));
        return;
      }
      final List<String> screenShoots = [
        if (result.largeScreenshotImage1 != null && result.largeScreenshotImage1!.isNotEmpty)
          result.largeScreenshotImage1!,
        if (result.largeScreenshotImage2 != null && result.largeScreenshotImage2!.isNotEmpty)
          result.largeScreenshotImage2!,
        if (result.largeScreenshotImage3 != null && result.largeScreenshotImage3!.isNotEmpty)
          result.largeScreenshotImage3!,
      ];

      emit(MovieDetailsSuccessState(
        movieDetails: result,
        screenShoots: screenShoots,
      ));
    } catch (e) {
      emit(MovieDetailsErrorState('حدث خطأ: ${e.toString()}'));
    }
  }
}