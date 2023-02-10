part of 'all_movie_bloc.dart';

@immutable
abstract class AllMovieState {}

class AllMovieInitial extends AllMovieState {}

class AllMovieIsLoading extends AllMovieState {}

class AllMovieIsFailed extends AllMovieState {
  final String message;

  AllMovieIsFailed(this.message);
}

class AllMovieIsSuccess extends AllMovieState {
  final List<MovieModel> data;

  AllMovieIsSuccess(this.data);
}
