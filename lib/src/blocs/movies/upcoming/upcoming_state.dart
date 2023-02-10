part of 'upcoming_bloc.dart';

@immutable
abstract class UpcomingState {}

class UpcomingInitial extends UpcomingState {}

class UpcomingIsLoading extends UpcomingState {}

class UpcomingIsSuccess extends UpcomingState {
  final List<MovieModel> data;

  UpcomingIsSuccess(this.data);
}

class UpcomingIsFailed extends UpcomingState {
  final String message;

  UpcomingIsFailed(this.message);
}
