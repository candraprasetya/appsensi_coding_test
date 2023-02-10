part of 'trending_bloc.dart';

@immutable
abstract class TrendingState {}

class TrendingInitial extends TrendingState {}

class TrendingIsLoading extends TrendingState {}

class TrendingIsSuccess extends TrendingState {
  final List<MovieModel>? data;

  TrendingIsSuccess(this.data);
}

class TrendingIsFailed extends TrendingState {
  final String message;

  TrendingIsFailed(this.message);
}
