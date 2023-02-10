part of 'video_bloc.dart';

@immutable
abstract class VideoEvent {}

class FetchVideoByMovieId extends VideoEvent {
  final int id;

  FetchVideoByMovieId(this.id);
}
