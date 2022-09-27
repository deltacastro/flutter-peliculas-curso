import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/models/models.dart';
import 'package:peliculas/models/movie_model.dart';

import 'package:peliculas/models/now_playing_response_model.dart';
import 'package:peliculas/models/search_movies_response_model.dart';

class MoviesProvider extends ChangeNotifier {
  final String _baseUrl = 'api.themoviedb.org';
  final String _apiKey = '6b938ba5b1a5140138c70a90db4de917';
  final String _language = 'es-MX';

  List<MovieModel> onDisplayMovies = [];
  List<MovieModel> popularMovies = [];

  Map<int, List<Cast>> moviesCast = {};

  int _popularPage = 0;

  MoviesProvider() {
    getOnDisplayMovies();
    getPopularMovies();
  }

  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    final url = Uri.https(_baseUrl, endpoint, {
      'api_key': _apiKey,
      'language': _language,
      'page': '$page'
    });

    final response = await http.get(url);

    return response.body;
  }

  getOnDisplayMovies() async {

    final jsonData = await _getJsonData('3/movie/now_playing');
    final nowPlayingResponse = NowPlayingResponseModel.fromJson(jsonData);

    onDisplayMovies = nowPlayingResponse.results;

    // Notifica a os widgets que hay un cambio para que los redibuje
    notifyListeners();
  }

  getPopularMovies() async {
    _popularPage++;
    final jsonData = await _getJsonData('3/movie/popular', _popularPage);
    final popularResponse = PopularResponseModel.fromJson(jsonData);

    popularMovies = [...popularMovies, ...popularResponse.results];

    // Notifica a os widgets que hay un cambio para que los redibuje
    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    // TODO: Revisar el mapa

    if (moviesCast.containsKey(movieId)) return moviesCast[movieId]!;

    final jsonData = await _getJsonData('3/movie/$movieId/credits');
    final creditsResponse = CreditsResponseModel.fromJson(jsonData);

    moviesCast[movieId] = creditsResponse.cast;

    return creditsResponse.cast;

  }

  Future<List<MovieModel>> searchMovies (String query) async{
    final url = Uri.https(_baseUrl, '3/search/movie', {
      'api_key': _apiKey,
      'language': _language,
      'query': query
    });

    final response = await http.get(url);
    final searchResponse = SearchMoviesResponseModel.fromJson(response.body);

    return searchResponse.results;
  }

}
