// La idea d'aquesta classe és que sigui el proveidor d'informació d'aquesta classe
//  que sigui accessible des de qualsevol Widget de l'aplicació

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:practica_final_2/models/models.dart';
import 'package:practica_final_2/models/now_playing_response.dart';

class MoviesProvider extends ChangeNotifier{

  String _baseUrl   = 'api.themoviedb.org';
  String _apiKey    = 'de2a09a17d2ed51404265e50bfaf5868';
  String _language    = 'es-ES';

  // Cream aquest llistat públic per a que sigui accessible des de les altres classes
  List<Movie> onDisplayMovies = [];
  

  MoviesProvider(){
    print('Movies Provider inicialitzat!');
    this.getOnDisplayMovies();
  }

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
}
