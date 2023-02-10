import 'package:appsensi_coding_test/src/models/models.dart';
import 'package:appsensi_coding_test/src/services/services.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'upcoming_event.dart';
part 'upcoming_state.dart';

class UpcomingBloc extends Bloc<UpcomingEvent, UpcomingState> {
  bool isFetching = false;
  UpcomingBloc() : super(UpcomingInitial()) {
    on<FetchUpcoming>(
      (event, emit) async {
        emit(UpcomingIsLoading());
        final result = await MovieService.fetchUpcoming(1);
        emit(
          result.fold(
            (l) => UpcomingIsFailed(l),
            (r) {
              final data = List<MovieModel>.from(
                  r.results!.map((x) => MovieModel.fromMap(x)));
              return UpcomingIsSuccess(data);
            },
          ),
        );
      },
    );
  }
}
