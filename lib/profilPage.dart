import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/services/kullanici_model.dart';

class ProfilPage extends StatefulWidget {
  String profilGosterilecekId;
  ProfilPage({this.profilGosterilecekId});

  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  TextEditingController _textEditingController = TextEditingController();
  File guncelFoto;
  String resimId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Profil"),
        ),
        body: FutureBuilder(
            future: kullaniciGetir(widget.profilGosterilecekId),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Kullanici _gelenKullanici = snapshot.data;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Center(
                        child: CircleAvatar(
                          minRadius: 80,
                          backgroundImage:
                              NetworkImage(snapshot.data.profilFotoUrl),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          Text(
                            "Kullanıcı Adı:",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                          Text(_gelenKullanici.kullaniciAdi),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      widget.profilGosterilecekId == _gelenKullanici.kullaniciId
                          ? Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: _textEditingController,
                                    decoration: InputDecoration(
                                        hintText: "Kullanıcı Adını Güncelle",
                                        border: OutlineInputBorder()),
                                  ),
                                ),
                                TextButton(
                                    onPressed: () async {
                                      await FirebaseFirestore.instance
                                          .collection("Users")
                                          .doc(_gelenKullanici.kullaniciId)
                                          .update({
                                        "kullaniciAdi":
                                            _textEditingController.text
                                      }).then((value) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    "Kullanıcı adı güncellendi")));
                                        setState(() {});
                                      });
                                    },
                                    child: Text(
                                      "Güncelle",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 17),
                                    ))
                              ],
                            )
                          : Container()
                    ],
                  ),
                );
              } else
                return Center(child: CircularProgressIndicator());
            }));
  }

  kullaniciGetir(String kullaniciId) async {
    DocumentSnapshot _query = await FirebaseFirestore.instance
        .collection("Users")
        .doc(kullaniciId)
        .get();
    Kullanici kullanici = Kullanici.fromMap(_query.data());
    return kullanici;
  }
}
