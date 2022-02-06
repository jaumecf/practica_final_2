import 'package:flutter/material.dart';
import 'package:practica_final_2/models/models.dart';
import 'package:practica_final_2/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate{

  // Implementam aquesta propietat per a posar el "hint" que volguem
  @override
  String? get searchFieldLabel => 'Cerca pel·lícula';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = '',
        icon: Icon(Icons.clear)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: Icon(Icons.arrow_back)
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('buildResults!');
  }

  Widget _emptyWidget(){
    return Container(
      child: Center(
        child: Icon(Icons.movie_creation_outlined, color: Colors.black38,size: 100,),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if(query.isEmpty){
      return _emptyWidget();
    }

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.searchMovies(query),
      builder: ( _ , AsyncSnapshot<List<Movie>> snapshot) {
        if(!snapshot.hasData) return _emptyWidget();
        final movies = snapshot.data!;
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: ( _ ,int index) => _MovieItem(movies[index])
        );
      },
    );
  }
}

class _MovieItem extends StatelessWidget {
  final String prop = 'search';
  final Movie  movie;

  const _MovieItem(this.movie);
  
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Hero(
        tag: movie.setHeroId(prop),
        child: FadeInImage(
          placeholder: AssetImage('assets/no-image.jpg'),
          image: NetworkImage(movie.fullPosterImg),
          width: 50,
          fit: BoxFit.contain,
        ),
      ),
      title: Text(movie.title),
      subtitle: Text(movie.originalTitle),
      onTap: (){
        print(movie.title);
        Navigator.pushNamed(context, 'details',arguments: movie);
      },
    );
  }
}