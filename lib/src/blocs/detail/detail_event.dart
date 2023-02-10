part of 'detail_bloc.dart';

@immutable
abstract class DetailEvent {}

class FetchDetailMovieById extends DetailEvent {
  final int id;

  FetchDetailMovieById(this.id);
}
