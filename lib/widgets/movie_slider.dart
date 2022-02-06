import 'package:flutter/material.dart';
import 'package:practica_final_2/models/models.dart';
import 'package:practica_final_2/providers/movies_provider.dart';


// Canviam a Stateful Widget per a poder realitzar el infinte Scroll
class MovieSlider extends StatefulWidget {
  final List<Movie> movies;
  final Function onNextPage;
  final String? title;

  const MovieSlider(
    {Key? key,
    required this.movies,
    required this.onNextPage,
    this.title}
    ) : super(key: key);

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {

  final ScrollController scrollController = ScrollController();

  // Mètode que s'executa quan es crea el Widget
  @override
  void initState() {
    // TODO: implement initState
    scrollController.addListener(() {
      // Si el scroll supera els 2160 píxels necessitam obtenir la següent pàgina
      if(scrollController.position.pixels>scrollController.position.maxScrollExtent-500){
        print('Hem de fer la petició');
        widget.onNextPage();
      }
      
    });
    super.initState();
  }

  // Mètode que es crida quan es destrueix el Widget
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 260,
      // color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TODO: Si no hi ha títol per a aquesta secció, no mostrar aquest Widget (quedarà un espai en blanc)
          if(widget.title != null)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(widget.title!, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
          SizedBox(height: 5,),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length,
              itemBuilder: (_, int index) => _MoviePoster(movie: widget.movies[index],)
            ),
          )
        ],
      ),
    );
  }
}


class _MoviePoster extends StatelessWidget {
  final String prop = 'slider';
  final Movie movie;
  
  const _MoviePoster({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 190,
      // color: Colors.green,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
            child: Hero(
              tag: movie.setHeroId(prop),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(movie.fullPosterImg),
                  width: 130,
                  height: 190,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 5,),
          Text(
            movie.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}