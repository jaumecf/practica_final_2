import 'package:flutter/material.dart';
import 'package:practica_final_2/providers/movies_provider.dart';
import 'package:practica_final_2/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // Recollirà la primera instància que trobi de MoviesProvider, sinò en troba cap, en crearà una
    final moviesProvider = Provider.of<MoviesProvider>(context);

    // print('des del build: ${moviesProvider.onDisplayMovies}');

    return Scaffold(
      appBar: AppBar(
        title: Text('Cartellera'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search_outlined)
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            
            children: [

              // Targetes principals
              // CardSwiper(),
              
              CardSwiper(movies: moviesProvider.onDisplayMovies),

              
              // Slider de pel·licules
              MovieSlider(
                movies: moviesProvider.popularMovies,
                onNextPage: () => moviesProvider.getPopularMovies(),
                title: 'Populars'),
              // Poodeu fer la prova d'afegir-ne uns quants, veureu com cada llista és independent
              // MovieSlider(),
              // MovieSlider(),

            ],
          ),
        )
      )
    );
  }
}
