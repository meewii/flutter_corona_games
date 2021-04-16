import 'package:core/src/ui/show_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CoGa',
      theme: ThemeData(
        primaryColor: Colors.red,
      ),
      home: Scaffold(
        body: ShowList(),
      ),
    );
  }
}


// class RandomWord extends StatefulWidget {
//   @override
//   _RandomWordState createState() => _RandomWordState();
// }
//
// class _RandomWordState extends State<RandomWord> {
//   final _suggestions = <WordPair>[];
//   final _saved = <WordPair>{};
//   final _biggerFont = TextStyle(fontSize: 18.0);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Startup Name Generator'),
//         actions: [
//           IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
//         ],
//       ),
//       body: _buildSuggestions(),
//     );
//   }
//
//   void _pushSaved() {
//     Navigator.of(context).push(
//       MaterialPageRoute<void>(builder: (BuildContext context) {
//         final tiles = _saved.map(
//               (WordPair pair) {
//             return ListTile(
//               title: Text(
//                 pair.asPascalCase,
//                 style: _biggerFont,
//               ),
//             );
//           },
//         );
//         final divided =
//         ListTile.divideTiles(context: context, tiles: tiles).toList();
//         return Scaffold(
//           appBar: AppBar(
//             title: Text('Saved Suggestions'),
//           ),
//           body: ListView(children: divided),
//         );
//       }),
//     );
//   }
//
//   Widget _buildSuggestions() {
//     return ListView.builder(
//         padding: EdgeInsets.all(16.0),
//         itemBuilder: (context, i) {
//           if (i.isOdd) return Divider();
//
//           final index = i ~/ 2;
//           if (index >= _suggestions.length) {
//             _suggestions.addAll(generateWordPairs().take(10));
//           }
//
//           return _buildRow(_suggestions[index]);
//         });
//   }
//
//   Widget _buildRow(WordPair pair) {
//     final alreadySaved = _saved.contains(pair);
//     return ListTile(
//       title: Text(
//         pair.asPascalCase,
//         style: _biggerFont,
//       ),
//       trailing: Icon(
//         alreadySaved ? Icons.favorite : Icons.favorite_border,
//         color: alreadySaved ? Colors.red : null,
//       ),
//       onTap: () {
//         setState(() {
//           if (alreadySaved) {
//             _saved.remove(pair);
//           } else {
//             _saved.add(pair);
//           }
//         });
//       },
//     );
//   }
// }
