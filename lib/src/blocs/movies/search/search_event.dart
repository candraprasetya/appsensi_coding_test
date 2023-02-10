part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class SearchMovieByKeyword extends SearchEvent {
  final String keyword;

  SearchMovieByKeyword(this.keyword);
}

class ResetSearch extends SearchEvent {}
