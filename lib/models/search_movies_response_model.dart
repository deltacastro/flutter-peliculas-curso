// To parse this JSON data, do
//
//     final searchMoviesResponseModel = searchMoviesResponseModelFromMap(jsonString);

import 'dart:convert';

import 'package:peliculas/models/models.dart';

class SearchMoviesResponseModel {
    SearchMoviesResponseModel({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    int page;
    List<MovieModel> results;
    int totalPages;
    int totalResults;

    factory SearchMoviesResponseModel.fromJson(String str) => SearchMoviesResponseModel.fromMap(json.decode(str));

    factory SearchMoviesResponseModel.fromMap(Map<String, dynamic> json) => SearchMoviesResponseModel(
        page: json["page"],
        results: List<MovieModel>.from(json["results"].map((x) => MovieModel.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );
}