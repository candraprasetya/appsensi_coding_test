part of 'popular_bloc.dart';

@immutable
abstract class PopularState {}

class PopularInitial extends PopularState {}

class PopularIsLoading extends PopularState {}

class PopularIsSuccess extends PopularState {
  final List<MovieModel> data;

  PopularIsSuccess(this.data);
}

class PopularIsFailed extends PopularState {
  final String message;

  PopularIsFailed(this.message);
}
