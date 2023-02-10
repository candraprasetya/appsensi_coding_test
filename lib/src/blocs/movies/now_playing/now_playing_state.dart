part of 'now_playing_bloc.dart';

@immutable
abstract class NowPlayingState {}

class NowPlayingInitial extends NowPlayingState {}

class NowPlayingIsLoading extends NowPlayingState {}

class NowPlayingIsFailed extends NowPlayingState {
  final String message;

  NowPlayingIsFailed(this.message);
}

class NowPlayingIsSuccess extends NowPlayingState {
  final List<MovieModel> data;

  NowPlayingIsSuccess(this.data);
}
