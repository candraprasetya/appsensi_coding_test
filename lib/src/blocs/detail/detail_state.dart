part of 'detail_bloc.dart';

@immutable
abstract class DetailState {}

class DetailInitial extends DetailState {}

class DetailIsLoading extends DetailState {}

class DetailIsSuccess extends DetailState {
  final DetailMovieModel data;

  DetailIsSuccess(this.data);
}

class DetailIsFailed extends DetailState {
  final String message;

  DetailIsFailed(this.message);
}
