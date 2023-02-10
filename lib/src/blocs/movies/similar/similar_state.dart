part of 'similar_bloc.dart';

@immutable
abstract class SimilarState {}

class SimilarInitial extends SimilarState {}

class SimilarIsFailed extends SimilarState {
  final String message;

  SimilarIsFailed(this.message);
}

class SimilarIsSuccess extends SimilarState {
  final List<MovieModel>? data;

  SimilarIsSuccess(this.data);
}

class SimilarIsLoading extends SimilarState {}
