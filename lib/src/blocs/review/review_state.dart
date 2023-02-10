part of 'review_bloc.dart';

@immutable
abstract class ReviewState {}

class ReviewInitial extends ReviewState {}

class ReviewIsLoading extends ReviewState {}

class ReviewIsSuccess extends ReviewState {
  final List<ReviewModel> data;

  ReviewIsSuccess(this.data);
}

class ReviewIsFailed extends ReviewState {
  final String message;

  ReviewIsFailed(this.message);
}
