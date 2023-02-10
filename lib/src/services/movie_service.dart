part of 'services.dart';

class MovieService {
  static Future<Either<String, ListResponseModel>> fetchNowPlaying(
      int page) async {
    try {
      final param = {
        'page': page,
        'language': 'en-US',
      };
      final result = await Api().get(
          param: param,
          "${Enpoints.nowPlaying}?api_key=${Commons.getApiKey()}");
      final listReponse = ListResponseModel.fromMap(result.data);

      return right(listReponse);
    } catch (e) {
      return left(e.toString());
    }
  }

  static Future<Either<String, ListResponseModel>> fetchReview(
      int id, int page) async {
    try {
      final param = {
        'page': page,
      };
      final result = await Api().get(
          param: param,
          "${Enpoints.movie}/$id/reviews?api_key=${Commons.getApiKey()}");
      final listReponse = ListResponseModel.fromMap(result.data);

      return right(listReponse);
    } catch (e) {
      return left(e.toString());
    }
  }

  static Future<Either<String, ListResponseModel>> fetchUpcoming(
      int page) async {
    try {
      final param = {
        'page': page,
        'language': 'en-US',
      };
      final result = await Api().get(
          param: param, "${Enpoints.upcoming}?api_key=${Commons.getApiKey()}");
      final listReponse = ListResponseModel.fromMap(result.data);

      return right(listReponse);
    } catch (e) {
      return left(e.toString());
    }
  }

  static Future<Either<String, ListResponseModel>> fetchTrending() async {
    try {
      final param = {
        'page': 1,
        'language': 'en-US',
      };
      final result = await Api().get(
          param: param, "${Enpoints.topRated}?api_key=${Commons.getApiKey()}");
      final listReponse = ListResponseModel.fromMap(result.data);

      return right(listReponse);
    } catch (e) {
      return left(e.toString());
    }
  }

  static Future<Either<String, VideoModel>> fetchVideo(int id) async {
    try {
      final param = {
        'language': 'en-US',
      };
      final result = await Api().get(
          param: param,
          "${Enpoints.movie}/$id/videos?api_key=${Commons.getApiKey()}");
      final video = VideoModel.fromMap(result.data);

      return right(video);
    } catch (e) {
      return left(e.toString());
    }
  }

  static Future<Either<String, ListResponseModel>> fetchPopular(
      int page) async {
    try {
      final param = {
        'page': page,
        'language': 'en-US',
      };
      final result = await Api().get(
          param: param, "${Enpoints.popular}?api_key=${Commons.getApiKey()}");
      final listReponse = ListResponseModel.fromMap(result.data);

      return right(listReponse);
    } catch (e) {
      return left(e.toString());
    }
  }

  static Future<Either<String, ListResponseModel>> fetchMovieByGenre(
      int page, int genreId) async {
    try {
      final param = {
        'page': page,
        'language': 'en-US',
      };
      final result = await Api().get(
          param: param,
          "${Enpoints.discover}?api_key=${Commons.getApiKey()}&with_genres=$genreId");
      final listReponse = ListResponseModel.fromMap(result.data);

      return right(listReponse);
    } catch (e) {
      return left(e.toString());
    }
  }

  static Future<Either<String, DetailMovieModel>> fetchMovieDetail(
      int id) async {
    try {
      final param = {
        'language': 'en-US',
      };
      final result = await Api().get(
          param: param, "${Enpoints.movie}/$id?api_key=${Commons.getApiKey()}");
      final listReponse = DetailMovieModel.fromMap(result.data);

      return right(listReponse);
    } catch (e) {
      return left(e.toString());
    }
  }

  static Future<Either<String, ListResponseModel>> fetchSimilarMovie(
      int id) async {
    try {
      final param = {'language': 'en-US', 'page': 1};
      final result = await Api().get(
          param: param,
          "${Enpoints.movie}/$id/similar?api_key=${Commons.getApiKey()}");
      final listReponse = ListResponseModel.fromMap(result.data);

      return right(listReponse);
    } catch (e) {
      return left(e.toString());
    }
  }

  static Future<Either<String, ListResponseModel>> searchByKeyword(
      String keyword) async {
    try {
      final param = {
        'language': 'en-US',
      };
      final result = await Api().get(
          param: param,
          "${Enpoints.search}?api_key=${Commons.getApiKey()}&query=$keyword");
      final listReponse = ListResponseModel.fromMap(result.data);

      return right(listReponse);
    } catch (e) {
      return left(e.toString());
    }
  }
}
