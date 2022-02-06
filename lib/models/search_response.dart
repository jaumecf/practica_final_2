// To parse this JSON data, do
//
//     final searchMovie = searchMovieFromMap(jsonString);

import 'dart:convert';

import 'package:practica_final_2/models/models.dart';

class SearchResponse {
    SearchResponse({
        required this.page,
        required this.movies,
        required this.totalPages,
        required this.totalResults,
    });

    int? page;
    List<Movie> movies;
    int? totalPages;
    int? totalResults;

    factory SearchResponse.fromJson(String str) => SearchResponse.fromMap(json.decode(str));

    factory SearchResponse.fromMap(Map<String, dynamic> json) => SearchResponse(
        page: json["page"],
        movies: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );
}
