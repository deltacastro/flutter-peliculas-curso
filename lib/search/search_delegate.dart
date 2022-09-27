import 'package:flutter/material.dart';

class MovieSearchDelegate extends SearchDelegate{

  @override
  String? get searchFieldLabel => 'Buscar película';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      }
    );
    // throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Text('build results');
    // throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
  
    if (query.isEmpty) {
      return Container(
        child: const Center(
          child: Icon(
            Icons.movie_creation_outlined,
            color: Colors.black38,
            size: 130
          ),
        ),
      );
    } else {
      return Container();
    }
  }

}