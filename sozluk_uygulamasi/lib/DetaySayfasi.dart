import 'package:flutter/material.dart';

import 'kelimeler.dart';

class DetaySayfasi extends StatefulWidget {
  late Kelimeler kelime;

  DetaySayfasi(this.kelime);

  @override
  State<DetaySayfasi> createState() => _DetaySayfasiState();
}

class _DetaySayfasiState extends State<DetaySayfasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detay Sayfası"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(widget.kelime.ingilizce,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35,color: Colors.red)),
            Text(widget.kelime.turkce,
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
