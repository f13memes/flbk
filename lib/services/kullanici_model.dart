import 'package:flutter/material.dart';

class Kullanici {
  Kullanici({
    @required this.kullaniciAdi,
    @required this.kullaniciId,
    @required this.profilFotoUrl,
  });

  String kullaniciAdi;
  String kullaniciId;
  String profilFotoUrl;

  factory Kullanici.fromMap(Map<String, dynamic> json) => Kullanici(
        kullaniciAdi: json["kullaniciAdi"],
        kullaniciId: json["kullaniciId"],
        profilFotoUrl: json["profilFotoUrl"],
      );

  Map<String, dynamic> toMap() => {
        "kullaniciAdi": kullaniciAdi,
        "kullaniciId": kullaniciId,
        "profilFotoUrl": profilFotoUrl,
      };
}
