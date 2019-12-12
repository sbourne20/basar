import 'package:flutter/foundation.dart';

class Transaction {
  String nama;
  double harga;
  DateTime tanggal;

  Transaction({@required this.nama, @required this.harga,@required this.tanggal});

  /*Transaction.fromJson(Map<String, Object> json) {
    nama = json['nama'];
    harga = json['harga'];
    tanggal = json['tanggal'];
  }

  Map<String, Object> toJson() {
    final Map<String, Object> data = new Map<String, Object>();
    data['nama'] = this.nama;
    data['harga'] = this.harga;
    data['tanggal'] = this.tanggal;
    return data;
  }*/
}