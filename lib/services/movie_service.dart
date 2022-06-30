import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:netflix/constants/apikey.dart';
import 'package:netflix/constants/tmdb.dart';

class MovieService {
  static Future<List> fetchMovies({
    required String type,
  }) async {
    List moviesList = [];
    final String? endpoint = TMDB.endPoints[type];
    if (endpoint == null) {
      return [];
    }

    final String uriString =
        '${TMDB.baseUrl + endpoint}?api_key=${ApiKey.apiKey}';

    HttpClient httpClient = HttpClient();
    try {
      var request = await httpClient.getUrl(Uri.parse(uriString));
      var response = await request.close();
      if (response.statusCode == HttpStatus.ok) {
        var jsonResponse = await response.transform(utf8.decoder).join();

        var data = jsonDecode(jsonResponse);
        // Get the result list
        moviesList = data["results"];
      } else {
        print("Failed http call.");
      }
    } catch (exception) {
      print(exception.toString());
      return Future.error(exception);
    }
    return moviesList;
  }

  static Future<List> getSimilarMovies(int movieId) async {
    List moviesList = [];
    final String uriString =
        '${TMDB.baseUrl}/movie/$movieId/similar?api_key=${ApiKey.apiKey}';
    HttpClient httpClient = HttpClient();
    try {
      var request = await httpClient.getUrl(Uri.parse(uriString));
      var response = await request.close();
      if (response.statusCode == HttpStatus.ok) {
        var jsonResponse = await response.transform(utf8.decoder).join();
        var data = jsonDecode(jsonResponse);
        // Get the result list
        moviesList = data["results"];
      } else {
        print("Failed http call.");
      }
    } catch (exception) {
      print(exception.toString());
      return Future.error(exception);
    }
    return moviesList;
  }

  static Future<List> searchMovies(String query) async {
    List moviesList = [];
    final String uriString =
        '${TMDB.baseUrl}/search/movie?api_key=${ApiKey.apiKey}&query="$query"';
    HttpClient httpClient = HttpClient();
    try {
      var request = await httpClient.getUrl(Uri.parse(uriString));

      var response = await request.close();
      if (response.statusCode == HttpStatus.ok) {
        var jsonResponse = await response.transform(utf8.decoder).join();
        var data = jsonDecode(jsonResponse);
        // Get the result list
        moviesList = data["results"];
      } else {
        print("Failed http call.");
      }
    } catch (exception) {
      print(exception.toString());
      return Future.error(e.toString());
    }
    return moviesList;
  }
}
