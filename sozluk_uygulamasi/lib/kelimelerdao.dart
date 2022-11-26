import 'package:sozluk_uygulamasi/veritabaniyardimcisi.dart';

import 'kelimeler.dart';

class kelimelerdao {


  Future<List<Kelimeler>> Tumkelimeler() async {
    var db = await VeritabaniYardimcisi.veritabanierisim();

    List<Map<String, dynamic>> maps =
    await db.rawQuery("SELECT * FROM kelimeler");

    return List.generate(maps.length, (i) {
      var satir = maps[i];

      return Kelimeler(satir["kelime_id"], satir["ingilizce"], satir["turkce"]);
    });
  }
  Future<List<Kelimeler>> Kelimeara(String ArananKelime) async {
    var db = await VeritabaniYardimcisi.veritabanierisim();

    List<Map<String, dynamic>> maps =
    await db.rawQuery("SELECT * FROM kelimeler WHERE kisi_ad like '%$ArananKelime%'");

    return List.generate(maps.length, (i) {
      var satir = maps[i];

      return Kelimeler(satir["kelime_id"], satir["ingilizce"], satir["turkce"]);
    });
  }

}