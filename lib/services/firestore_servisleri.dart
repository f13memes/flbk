import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServisleri {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future kullaniciVeritabaninaKaydet(
      String profilFotoUrl, kullaniciAdi, kullaniciId) async {
    try {
      await _firestore.collection("Users").doc(kullaniciId).set({
        "profilFotoUrl": profilFotoUrl,
        "kullaniciAdi": kullaniciAdi,
        "kullaniciId": kullaniciId
      }).then((value) => print("Kullanıcı veritabanına basarıyla kaydedildi."));
    } catch (e) {
      print("Kullanıcı veritabanına eklenirken bir hata cıktı.Hata $e");
    }
  }
}
