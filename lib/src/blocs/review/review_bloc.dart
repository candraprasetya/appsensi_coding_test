import 'package:appsensi_coding_test/src/models/models.dart';
import 'package:appsensi_coding_test/src/services/services.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'review_event.dart';
part 'review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  int page = 1;
  bool isFetching = false;
  ReviewBloc() : super(ReviewInitial()) {
    on<FetchReviewByMovieId>((event, emit) async {
      emit(ReviewIsLoading());
      if (event.isNew) {
        page = 1;
      }
      final result = await MovieService.fetchReview(event.id, page);
      emit(result.fold((l) => ReviewIsFailed(l), (r) {
        final data = List<ReviewModel>.from(
            r.results!.map((x) => ReviewModel.fromMap(x)));
        page++;
        return ReviewIsSuccess(data);
      }));
    });
  }
}
