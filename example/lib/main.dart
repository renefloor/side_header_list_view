import 'package:flutter/material.dart';
import 'package:side_header_list_view/side_header_list_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HeaderList Demo',
      theme: ThemeData(),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HeaderList Demo')),
      body: SideHeaderListView(
        itemCount: names.length,
        padding: EdgeInsets.all(16.0),
        itemExtend: 48.0,
        headerBuilder: (BuildContext context, int index) {
          return SizedBox(
              width: 32.0,
              child: Text(
                names[index].substring(0, 1),
                style: Theme.of(context).textTheme.headline5,
              ));
        },
        itemBuilder: (BuildContext context, int index) {
          return Text(
            names[index],
            style: Theme.of(context).textTheme.headline5,
          );
        },
        hasSameHeader: (int a, int b) {
          return names[a].substring(0, 1) == names[b].substring(0, 1);
        },
      ),
    );
  }
}

const names = <String>[
  'Annie',
  'Arianne',
  'Bertie',
  'Bettina',
  'Bradly',
  'Caridad',
  'Carline',
  'Cassie',
  'Chloe',
  'Christin',
  'Clotilde',
  'Dahlia',
  'Dana',
  'Dane',
  'Darline',
  'Deena',
  'Delphia',
  'Donny',
  'Echo',
  'Else',
  'Ernesto',
  'Fidel',
  'Gayla',
  'Grayce',
  'Henriette',
  'Hermila',
  'Hugo',
  'Irina',
  'Ivette',
  'Jeremiah',
  'Jerica',
  'Joan',
  'Johnna',
  'Jonah',
  'Joseph',
  'Junie',
  'Linwood',
  'Lore',
  'Louis',
  'Merry',
  'Minna',
  'Mitsue',
  'Napoleon',
  'Paris',
  'Ryan',
  'Salina',
  'Shantae',
  'Sonia',
  'Taisha',
  'Zula',
];
