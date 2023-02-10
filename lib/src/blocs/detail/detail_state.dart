part of 'detail_bloc.dart';

@immutable
abstract class DetailState {}

class DetailInitial extends DetailState {}

class DetailIsLoading extends DetailState {}

class DetailIsSuccess extends DetailState {
  final DetailMovieModel? data;
  final List<ReviewModel>? reviews;

  DetailIsSuccess({this.data, this.reviews = const []});
}

class DetailIsFailed extends DetailState {
  final String message;

  DetailIsFailed(this.message);
}
