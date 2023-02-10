part of 'review_bloc.dart';

@immutable
abstract class ReviewEvent {}

class FetchReviewByMovieId extends ReviewEvent {
  final int id;
  final bool isNew;

  FetchReviewByMovieId(
    this.id, {
    this.isNew = false,
  });
}
