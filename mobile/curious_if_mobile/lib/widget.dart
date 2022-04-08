import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Primeiro App',
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meu primeiro app'),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.add))],
      ),
      body: Center(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Text(
              '3',
              style: TextStyle(fontSize: 50),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}

class TextRodrigo extends StatefulWidget {
  const TextRodrigo({Key? key}) : super(key: key);

  @override
  State<TextRodrigo> createState() => _TextRodrigoState();
}

class _TextRodrigoState extends State<TextRodrigo> {
  int rodrigo = 0;
  @override
  Widget build(BuildContext context) {
    return Text(
      '$rodrigo',
      style: TextStyle(fontSize: 50),
    );
  }
}
