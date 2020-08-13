// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: RandomWords()
      );
  }
}

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = Set<WordPair>();
  final _biggerFont = TextStyle(fontSize: 18.0);
  List<String> _payments = <String>[];
  var _count = 0;

  Widget _buildSuggestions() {

//    return ListView.builder(
//        padding: EdgeInsets.all(16.0),
//        itemBuilder: /*1*/ (context, i) {
//          if (i.isOdd) return Divider(); /*2*/
//
//          final index = i ~/ 2; /*3*/
//          if (index >= _suggestions.length) {
//            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
//          }
//          return _buildRow(_suggestions[index]);
//        });
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null
      ),
      onTap: () {
        setState(() {
          if(alreadySaved) {
            _saved.remove(pair);
          }
          else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  void _pushSaved(){
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context){
          final tiles = _saved.map(
                (WordPair pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        }
      )
    );
  }

  void _addPayment (){
    Navigator.of(context).push(
        MaterialPageRoute<void>(
            builder: (BuildContext context){
//              final tiles = _saved.map(
//                    (WordPair pair) {
//                  return ListTile(
//                    title: Text(
//                      pair.asPascalCase,
//                      style: _biggerFont,
//                    ),
//                  );
//                },
//              );
//              final divided = ListTile.divideTiles(
//                context: context,
//                tiles: tiles,
//              ).toList();

              return Scaffold(
                appBar: AppBar(
                  title: Text('Add Payment'),
                ),
                body: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Add new payment'
                  ),
                  keyboardType: TextInputType.number,
                  onSubmitted: (value) {
                    print('dafug');
                    _payments.add(value);
                    _payments.forEach((element) => {print(element)});
                  }  ,
                )
              );
            }
        )
    );
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: [
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved)
        ],
      ),
     body: Column(
       children: <Widget>[
        Expanded(
          child: ListView.builder(
          padding: const EdgeInsets.all(8),
        itemCount: _payments.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 50,
            margin: EdgeInsets.all(2),
            color: Colors.grey,
        child: Center(
            child: Text('${_payments[index]} (0)',
          style: TextStyle(fontSize: 18),
        )
      ),
      );
      }
      )
      )
      ]
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => _addPayment()),
        tooltip: 'Increment Counter',
        child: const Icon(Icons.add),
      )
    );
  }

}



