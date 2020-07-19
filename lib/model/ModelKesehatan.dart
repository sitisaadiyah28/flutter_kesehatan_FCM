// To parse this JSON data, do
//
//     final modelKesehatan = modelKesehatanFromJson(jsonString);

import 'dart:convert';

ModelKesehatan modelKesehatanFromJson(String str) => ModelKesehatan.fromJson(json.decode(str));

String modelKesehatanToJson(ModelKesehatan data) => json.encode(data.toJson());

class ModelKesehatan {
  ModelKesehatan({
    this.message,
    this.status,
    this.kesehatan,
  });

  String message;
  int status;
  List<Kesehatan> kesehatan;

  factory ModelKesehatan.fromJson(Map<String, dynamic> json) => ModelKesehatan(
    message: json["message"],
    status: json["status"],
    kesehatan: List<Kesehatan>.from(json["kesehatan"].map((x) => Kesehatan.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "kesehatan": List<dynamic>.from(kesehatan.map((x) => x.toJson())),
  };
}

class Kesehatan {
  Kesehatan({
    this.idKesehatan,
    this.judul,
    this.deskripsi,
    this.image,
    this.date,
  });

  String idKesehatan;
  String judul;
  String deskripsi;
  String image;
  DateTime date;

  factory Kesehatan.fromJson(Map<String, dynamic> json) => Kesehatan(
    idKesehatan: json["id_kesehatan"],
    judul: json["judul"],
    deskripsi: json["deskripsi"],
    image: json["image"],
    date: DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "id_kesehatan": idKesehatan,
    "judul": judul,
    "deskripsi": deskripsi,
    "image": image,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
  };
}
