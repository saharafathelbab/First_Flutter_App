import 'package:flutter/material.dart';
// import 'package:english_words/english_words.dart';
import 'package:random_words/random_words.dart';
// import 'package:random_words/random_words.dart';

class Hello extends StatelessWidget{
  @override
  Widget build(BuildContext context){
   return Scaffold(
     appBar: AppBar(
       title: Text('Select Only Things i.e. bag etc.'),
     ),
     body: Center(
       child: RandomWords(),
     ) 
     ); 
  }
}

class RandomWordsState extends State <RandomWords>{
  void _pushSaved(){
    Navigator.of(context).push(
       MaterialPageRoute<void>(   // Add 20 lines from here...
      builder: (BuildContext context) {
        final Iterable<ListTile> tiles = _saved.map(
          (WordNoun noun) {
            return ListTile(
              title: Text(
                noun.asUpperCase,
                style: _biggerFont,
              ),
            );
          },
        );
        final List<Widget> divided = ListTile
          .divideTiles(
            context: context,
            tiles: tiles,
          )
          .toList();
          return Scaffold(        
          appBar: AppBar(
            title: Text('Saved List of Things'),
          ),
          body: ListView(children: divided),
        );                       
      },
    ),                      
  );
  }
  final _suggestions = <WordNoun>[];
  final Set<WordNoun> _saved = Set<WordNoun>(); // this stores the nouns the user selects
  //Set is preferred to List because a properly implemented Set does not allow duplcate entries.
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context){
      return Scaffold(
        appBar: AppBar(
          title: Text('Select Only Things i.e. bag'),
    ),
        bottomNavigationBar:       
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        
    body: _buildSuggestions(),
  );
  }
  Widget _buildRow(WordNoun noun) {
    final bool alreadySaved = _saved.contains(noun); // This checks to ensure a word pairing hasn't already been added to favorites
      return ListTile(
       title: Text(
         noun.asUpperCase,
          style: _biggerFont,
    ),
    trailing: Icon(
      alreadySaved ? Icons.favorite : Icons.favorite_border, // adds heart shaped icons to ListTile objects
      color: alreadySaved ? Colors.red:null,
    ),
    onTap: (){
      setState((){
        if (alreadySaved){
          _saved.remove(noun);
        } else {
          _saved.add(noun);
        }
      });
    },
  );
}
  Widget _buildSuggestions() {
  return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: /*1*/ (context, i) {
        //the item builder is called once per suggested noun, and places
        //each suggestion into a ListTItle row. For even rows, the function
        // adds a Divider widget to visually separate the entries. The divider
        // mght be difficuly to see on smaller devices
        if (i.isOdd) return Divider(); /*2*/
        // Adds a one pixel high divider widget befre each row in the ListView

        final index = i ~/ 2; /*3*/
        // The expression divides i by 2 and returns an integer result.
        // For example: 1,2,3,4,5 becomes 0,1,1,2,2. This calculates the actual number
        // of nouns in the listiew minus the divider widgets
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateNoun().take(10)); /*4*/
          // if you've reached the end of the available nounds, then generate
          // 10 more and add them to the suggestions list
        }
        return _buildRow(_suggestions[index]);
        // The _buildSuggestions() function calls _buildRow() once per noun.
        // This function displays each new pair in a ListTitle, which allows you
        // to make the rows more attractive.
      });
}
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}