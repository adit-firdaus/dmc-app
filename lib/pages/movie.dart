import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

Future<List<Movie>> fetchMovies(String category) async {
  final response = await http.get(Uri.parse(
      'https://api.themoviedb.org/3/movie/$category?api_key=cccdb33259f45b2fe6742f53a2655d52'));

  if (response.statusCode == 200) {
    final json = jsonDecode(response.body);
    final List movies = json['results'];
    return movies.map((movie) => Movie.fromJson(movie)).toList();
  } else {
    throw Exception('Failed to load movies');
  }
}

class Movie {
  final String id;
  final String title;
  final String posterPath;
  final String overview;

  // Random id
  Movie({
    required this.title,
    required this.posterPath,
    required this.overview,
    this.id = '',
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: const Uuid().v4(),
      title: json['title'],
      posterPath: json['poster_path'],
      overview: json['overview'],
    );
  }
}
