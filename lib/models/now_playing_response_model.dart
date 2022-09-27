// To parse this JSON data, do
//
//     final nowPlayingResponseModel = nowPlayingResponseModelFromMap(jsonString);

import 'dart:convert';

import 'package:peliculas/models/movie_model.dart';

class NowPlayingResponseModel {
  
    NowPlayingResponseModel({
        required this.dates,
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    Dates dates;
    int page;
    List<MovieModel> results;
    int totalPages;
    int totalResults;

    factory NowPlayingResponseModel.fromJson(String str) => NowPlayingResponseModel.fromMap(json.decode(str));

    factory NowPlayingResponseModel.fromMap(Map<String, dynamic> json) => NowPlayingResponseModel(
        dates: Dates.fromMap(json["dates"]),
        page: json["page"],
        results: List<MovieModel>.from(json["results"].map((x) => MovieModel.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );
}

class Dates {
    Dates({
        required this.maximum,
        required this.minimum,
    });

    DateTime maximum;
    DateTime minimum;

    factory Dates.fromJson(String str) => Dates.fromMap(json.decode(str));

    factory Dates.fromMap(Map<String, dynamic> json) => Dates(
        maximum: DateTime.parse(json["maximum"]),
        minimum: DateTime.parse(json["minimum"]),
    );
}