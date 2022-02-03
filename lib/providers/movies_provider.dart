// La idea d'aquesta classe és que sigui el proveidor d'informació d'aquesta classe
//  que sigui accessible des de qualsevol Widget de l'aplicació

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:practica_final_2/models/models.dart';
import 'package:practica_final_2/models/now_playing_response.dart';
import 'package:practica_final_2/models/popular_response.dart';

class MoviesProvider extends ChangeNotifier{

  String _baseUrl   = 'api.themoviedb.org';
  String _apiKey    = 'de2a09a17d2ed51404265e50bfaf5868';
  String _language    = 'es-ES';

  // Cream aquest llistat públic per a que sigui accessible des de les altres classes
  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  Map<int, List<Cast>> moviesCast = {};

  int _popularPage = 0;
  

  MoviesProvider(){
    print('Movies Provider inicialitzat!');
    this.getOnDisplayMovies();
    this.getPopularMovies();
  }

  // Optimització del codi, per a implementar un mètode que realitzi la petició HTTP 
  // i rebi per paràmetre l'endpoint al qual l'ha de fer. Retornrà el body del response.

  _getJsonData(String endpoint, [int page = 1]) async{
    var url = Uri.https(_baseUrl, endpoint,{
      'api_key'   : _apiKey,
      'language'  : _language,
      'page'      : '$page'
      });
    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);

    return response.body;
  }

  getOnDisplayMovies() async{
    final jsonData = await _getJsonData('3/movie/now_playing');
    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);
    // print(nowPlayingResponse.results[0].title);

    // Emmagatzemam la llista de pel·licules dintre de la variable local
    onDisplayMovies = nowPlayingResponse.results;

    // Quan hi ha algun canvi, en el conjunt de dades que conté el nostre provider,
    // els Widgets que l'estan utilitzant, han de ser notificats, i s'han d'actualitzar
    // les seves dades. Això ho podem fer amb el següent mètode, que notificarà al Widgets
    // que han canviat les dades i que es repinti.
    notifyListeners();
  }

  getPopularMovies() async{

    // Utilitzam una variable per a mantenir el nombre de la pàgina, i anar-lo incrementant cada cop,
    // que cridam aquest mètode. El cridarem des de Movie Slider quan arribem al final del "scroll". Així tindrem un "infinite scroll"

    _popularPage++;
    final jsonData = await _getJsonData('3/movie/popular',_popularPage);
    final popularResponse = PopularResponse.fromJson(jsonData);
    // print(nowPlayingResponse.results[0].title);

    // Emmagatzemam la llista de pel·licules dintre de la variable local
    // Amb aquesta sintaxi el que fem es concatenar als resultats previs de popular  movies,
    // els nous resultats de la cerca, que correpondran a una nova pàgina, etc...
    popularMovies = [...popularMovies, ...popularResponse.results];
    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int movieId) async{
    // TODO: revisar mapa
    print('Demanam info al server:');
    final jsonData = await _getJsonData('3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromJson(jsonData);

    // Emmagatzemam la llista d'actors
    moviesCast[movieId] = creditsResponse.cast;
    return creditsResponse.cast;

    // Quan hi ha algun canvi, en el conjunt de dades que conté el nostre provider,
    // els Widgets que l'estan utilitzant, han de ser notificats, i s'han d'actualitzar
    // les seves dades. Això ho podem fer amb el següent mètode, que notificarà al Widgets
    // que han canviat les dades i que es repinti.
    notifyListeners();

  }




  /* BLOC de codi comentat: Mètode anterior.
  
  getOnDisplayMovies() async{
    var url = Uri.https(_baseUrl, '3/movie/now_playing',{
      'api_key'   : _apiKey,
      'language'  : _language,
      'page'      : '1'
      });
    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);

    // final Map<String,dynamic> decodedData = json.decode(response.body);
    // print(decodedData['results']);

    final nowPlayingResponse = NowPlayingResponse.fromJson(response.body);
    // print(nowPlayingResponse.results[0].title);

    // Emmagatzemam la llista de pel·licules dintre de la variable local
    onDisplayMovies = nowPlayingResponse.results;

    // Quan hi ha algun canvi, en el conjunt de dades que conté el nostre provider,
    // els Widgets que l'estan utilitzant, han de ser notificats, i s'han d'actualitzar
    // les seves dades. Això ho podem fer amb el següent mètode, que notificarà al Widgets
    // que han canviat les dades i que es repinti.
    notifyListeners();
  }

  getPopularMovies() async{
    //String url = 'https://api.themoviedb.org/3/movie/popular?api_key=de2a09a17d2ed51404265e50bfaf5868&language=en-US&page=1';
    var url = Uri.https(_baseUrl, '3/movie/popular',{
      'api_key'   : _apiKey,
      'language'  : _language,
      'page'      : '1'
      });
    // Await the http get response, then decode the json-formatted response.
    final responsePop = await http.get(url);

    // final Map<String,dynamic> decodedData = json.decode(response.body);
    // print(decodedData['results']);

    final popularResponse = PopularResponse.fromJson(responsePop.body);
    // print(nowPlayingResponse.results[0].title);

    // Emmagatzemam la llista de pel·licules dintre de la variable local
    // Amb aquesta sintaxi el que fem es concatenar als resultats previs de popular  movies,
    // els nous resultats de la cerca, que correpondran a una nova pàgina, etc...
    popularMovies = [...popularMovies, ...popularResponse.results];
    print('Popular: ${popularMovies[0]}');

    notifyListeners();
  } */
}
