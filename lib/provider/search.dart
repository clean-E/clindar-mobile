import 'package:clindar_mobile/data/spot.dart';
import 'package:clindar_mobile/view/workOut/add_workout.dart';
import 'package:clindar_mobile/widget/field/search_field.dart';
import 'package:flutter/material.dart';

// class Search extends StatefulWidget {
//   const Search({Key? key, required this.setPlace}) : super(key: key);
//   final Function setPlace;

//   @override
//   State<Search> createState() => _SearchState();
// }

// class _SearchState extends State<Search> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(actions: [
//         IconButton(
//             onPressed: () {

//               // showSearch(context: context, delegate: CustomSearchDelegate());
//             },
//             icon: Icon(Icons.search))
//       ]),
//     );
//   }
// }

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate({
    Key? key,
    required this.setPlace,
    required this.setWhere,
  });
  final Function setPlace;
  final Function setWhere;
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: (() {
            query = '';
          }),
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: (() {
          close(context, null);
        }),
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var place in indoor_spot) {
      if (place.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(place);
      }
    }
    return InkWell(
      onTap: () {},
      child: ListView.builder(
          itemCount: matchQuery.length,
          itemBuilder: (context, index) {
            var result = matchQuery[index];
            return ListTile(
              title: Text(result),
            );
          }),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var place in indoor_spot) {
      if (place.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(place);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
            onTap: () {
              setPlace(result);
              setWhere(result);
              Navigator.pop(context);
            },
            title: Text(result),
          );
        });
  }
}
