part of 'video_bloc.dart';

@immutable
abstract class VideoState {}

class VideoInitial extends VideoState {}

class VideoIsSuccess extends VideoState {
  final VideoModel data;

  VideoIsSuccess(this.data);
}

class VideoIsFailed extends VideoState {
  final String message;

  VideoIsFailed(this.message);
}

class VideoIsLoading extends VideoState {}
