// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';

class MovieSlider extends StatefulWidget {

  //TODO: recibir las peliculas
  const MovieSlider({
    Key? key, 
    required this.movies,
    required this.onNextPage,
    this.title
  }) : super(key: key);

  final String? title;
  final List<MovieModel> movies;
  final Function onNextPage;

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {

      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 500) {
        widget.onNextPage();
      }

      print(scrollController.position.pixels);
      print(scrollController.position.maxScrollExtent);
    });

  }

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
      child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            
            if (this.widget.title != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  '${this.widget.title}',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),

            const SizedBox(
              height: 5,
            ),

            Expanded(
              child: ListView.builder(
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: widget.movies.length,
                itemBuilder: ( _ , int index ) => _MoviePoster(
                  movie: widget.movies[index]
                )
              ),
            )
          ]
        ),
    );
  }
}

class _MoviePoster extends StatelessWidget {

  const _MoviePoster({
    required this.movie
  });

  final MovieModel movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 190,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movie.fullPosterImg),
                width: 130,
                height: 190,
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(
            height: 5,
          ),

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