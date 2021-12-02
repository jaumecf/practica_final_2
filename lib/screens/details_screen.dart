import 'package:flutter/material.dart';
import 'package:practica_final_2/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {

  
  @override
  Widget build(BuildContext context) {
    // TODO: Canviar després per una instància de Peli
    final String peli = ModalRoute.of(context)?.settings.arguments.toString() ?? 'no-movie';

    return Scaffold(
        body: CustomScrollView(
          slivers: [
            _CustomAppBar(),
            SliverList(
              delegate: SliverChildListDelegate([
                _PosterAndTitile(),
                _Overview(),
                _Overview(),
                CastingCards()
              ])
            )
          ],
        )
    );
  }
}

class _CustomAppBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // Exactament igual que la AppBaer però amb bon comportament davant scroll
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
          padding: EdgeInsets.only(bottom: 10),
          child: Text(
            'Títol peli',
            style: TextStyle(fontSize: 16)
            ,
          ),
        ),

        background: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage('https://via.placeholder.com/500x300'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitile extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('assets/loading.gif'),
              image: NetworkImage('https://via.placeholder.com/200x300'),
              height: 150,
            ),
          ),
          SizedBox(width: 20,),
          Column(
            children: [
              Text('Títol peli', style: textTheme.headline5, overflow: TextOverflow.ellipsis, maxLines: 2,),
              Text('Títol original', style: textTheme.subtitle1, overflow: TextOverflow.ellipsis, maxLines: 2,),
              Row(
                children: [
                  Icon(Icons.star_outline,size: 15, color: Colors.grey),
                  SizedBox(width: 5,),
                  Text('Nota mitjana', style: textTheme.caption),

                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        'Labore eiusmod ad reprehenderit irure eu sunt ex minim. Lorem fugiat Lorem proident duis ea cupidatat. Commodo duis culpa reprehenderit ad elit. Velit duis officia reprehenderit ullamco sint id anim officia est. Enim mollit nisi et exercitation dolore commodo. Cillum mollit laborum non nulla cillum non do reprehenderit Lorem deserunt ex eu sunt do.',
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}