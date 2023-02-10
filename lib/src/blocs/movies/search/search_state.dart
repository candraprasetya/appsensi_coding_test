part of 'search_bloc.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchIsSuccess extends SearchState {
  final List<MovieModel> data;

  SearchIsSuccess(this.data);
}

class SearchIsFailed extends SearchState {
  final String message;

  SearchIsFailed(this.message);
}

class SearchIsLoading extends SearchState {}
