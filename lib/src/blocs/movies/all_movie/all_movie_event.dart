// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'all_movie_bloc.dart';

@immutable
abstract class AllMovieEvent {}

class FetchAllMovie extends AllMovieEvent {
  final bool? isNew;
  final int? id;
  final int? genreId;

  FetchAllMovie({
    this.isNew = false,
    this.id = 1,
    this.genreId,
  });
}
