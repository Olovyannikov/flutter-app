import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _decrementClickCounter = 0;
  int _incrementClickCounter = 0;

  void _incrementCounter() {
    setState(() {
      _incrementClickCounter++;
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _decrementClickCounter++;
      _counter > 0 ? _counter-- : _counter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              'Incremented:'
                  '$_incrementClickCounter',
            ),
            Text(
              'Decremented:'
                  '$_decrementClickCounter',
              style: TextStyle(
                color: _counter == 0 ? Colors.red : Colors.black
              ),
            )

          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        spacing: 20,
        children: [
          FloatingActionButton(
            onPressed: _decrementCounter,
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
          ),
          FloatingActionButton(
            onPressed: _counter > 5 ? null: _incrementCounter,
            tooltip: 'Increment',
            backgroundColor: _counter > 5 ? Colors.grey : Colors.lightBlue,
            child: const Icon(Icons.add),
          ),
        ],
      )
    );
  }
}
