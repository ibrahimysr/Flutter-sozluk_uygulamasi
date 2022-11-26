import 'package:flutter/material.dart';
import 'package:sozluk_uygulamasi/DetaySayfasi.dart';
import 'package:sozluk_uygulamasi/kelimeler.dart';
import 'package:sozluk_uygulamasi/kelimelerdao.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: AnaSayfa(),
    );
  }
}

class AnaSayfa extends StatefulWidget {
  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  bool AramaYapiliyormu = false;
  String Aranankelime = "";

  Future<List<Kelimeler>> tumKelimelergoster() async {
    var kelimelerListesi = await kelimelerdao().Tumkelimeler();
    return kelimelerListesi;
  }

  Future<List<Kelimeler>> aramaYap(String ArananKelime) async {
    var kelimelerListesi = await kelimelerdao().Kelimeara(ArananKelime);
    return kelimelerListesi;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AramaYapiliyormu
            ? TextField(
                decoration: const InputDecoration(
                  hintText: "Aramak için bir şey yazınız",
                ),
                onChanged: (aramaSonucu) {
                  print("aramasonucu$aramaSonucu");

                  Aranankelime = aramaSonucu;
                },
              )
            : const Text("Sözlük Uygulaması"),
        actions: [
          AramaYapiliyormu
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      AramaYapiliyormu = false;
                      Aranankelime = "";
                    });
                  },
                  icon: const Icon(Icons.cancel))
              : IconButton(
                  onPressed: () {
                    setState(() {
                      AramaYapiliyormu = true;
                    });
                  },
                  icon: Icon(Icons.search))
        ],
      ),
      body: FutureBuilder<List<Kelimeler>>(
        future:
            AramaYapiliyormu ? aramaYap(Aranankelime) : tumKelimelergoster(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var kelimelerListesi = snapshot.data;
            return ListView.builder(
                itemCount: kelimelerListesi!.length,
                itemBuilder: (context, indeks) {
                  var kelime = kelimelerListesi[indeks];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetaySayfasi(kelime)));
                    },
                    child: SizedBox(
                      height: 75,
                      child: Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(kelime.ingilizce,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18)),
                            Text(
                              kelime.turkce,
                              style: const TextStyle(fontSize: 16),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                });
          } else {
            return Center();
          }
        },
      ),
    );
  }
}
