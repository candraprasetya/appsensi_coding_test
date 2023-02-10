import 'package:appsensi_coding_test/src/models/models.dart';
import 'package:appsensi_coding_test/src/services/services.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'now_playing_event.dart';
part 'now_playing_state.dart';

class NowPlayingBloc extends Bloc<NowPlayingEvent, NowPlayingState> {
  bool isFetching = false;
  NowPlayingBloc() : super(NowPlayingInitial()) {
    on<FetchListNowPlaying>(
      (event, emit) async {
        emit(NowPlayingIsLoading());
        final result = await MovieService.fetchNowPlaying(1);
        emit(
          result.fold(
            (l) => NowPlayingIsFailed(l),
            (r) {
              final data = List<MovieModel>.from(
                  r.results!.map((x) => MovieModel.fromMap(x)));

              return NowPlayingIsSuccess(data);
            },
          ),
        );
      },
    );
  }
}
