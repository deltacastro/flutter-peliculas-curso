import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';
import 'package:peliculas/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    // TODO: Cambiar luego por una instancia de movie

    final MovieModel movie = ModalRoute.of(context)!.settings.arguments as MovieModel;
    print(movie.title);


    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          _CustomAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([
              _PosterAndTitle(),
              _Overview(),
              CastingCards( movie.id )
            ])
          )
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final MovieModel movie = ModalRoute.of(context)!.settings.arguments as MovieModel;
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 300,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          padding: EdgeInsets.only(bottom: 10),
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
          child: Text(
            movie.title,
            style: TextStyle( fontSize: 16 ),
          )
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage(movie.fullBackdropPath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final TextTheme textTheme = Theme.of(context).textTheme;
    final MovieModel movie = ModalRoute.of(context)!.settings.arguments as MovieModel;

    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'),
              image: NetworkImage(movie.fullPosterImg),
              height: 150,
            ),
          ),
          
          SizedBox(
            width: 20
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                movie.title,
                style: textTheme.headline5,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              Text(
                movie.originalTitle,
                style: textTheme.subtitle1,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              
              Row(
                children: [
                  Icon(Icons.star_outline, size:15, color: Colors.grey),
                  SizedBox( width: 4 ),
                  Text(movie.voteAverage.toString(), style: textTheme.caption)
                ],
              )
            ],
          )
        ],
      )
    );
  }
}

class _Overview extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {

    final TextTheme textTheme = Theme.of(context).textTheme;
    final MovieModel movie = ModalRoute.of(context)!.settings.arguments as MovieModel;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
        style: textTheme.subtitle1,
      ),
    );
  }
}