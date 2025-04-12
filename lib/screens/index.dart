import 'package:flutter/material.dart';

class LayoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(color: Colors.amberAccent, width: 50, height: 50),
            Container(color: Colors.blue, width: 50, height: 50),
            Container(color: Colors.green, width: 50, height: 50),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(color: Colors.cyanAccent,
                  child: Text('First container'),
                ),
                Container(color: Colors.deepOrange,
                  child: Text('Second container'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
