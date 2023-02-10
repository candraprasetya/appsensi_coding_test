part of 'similar_bloc.dart';

@immutable
abstract class SimilarEvent {}

class FetchSimilarByMovieId extends SimilarEvent {
  final int id;

  FetchSimilarByMovieId(this.id);
}
