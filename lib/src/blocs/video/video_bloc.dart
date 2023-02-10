import 'package:appsensi_coding_test/src/models/models.dart';
import 'package:appsensi_coding_test/src/services/services.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'video_event.dart';
part 'video_state.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  VideoBloc() : super(VideoInitial()) {
    on<FetchVideoByMovieId>((event, emit) async {
      emit(VideoIsLoading());
      final result = await MovieService.fetchVideo(event.id);
      emit(
        result.fold(
          (l) => VideoIsFailed(l),
          (r) => VideoIsSuccess(r),
        ),
      );
    });
  }
}
