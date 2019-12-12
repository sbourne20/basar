import '../models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class trx extends StatelessWidget {
  final List<Transaction> recentTrx;

  trx(this.recentTrx);

  List<Map<String, Object>> get groupedTrx {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(
        Duration(days: index),
      );
      double jumlahHarga = 0.0;
      for (var i = 0; i < recentTrx.length; i++) {
        if (recentTrx[i].tanggal.day == weekday.day &&
            recentTrx[i].tanggal.month == weekday.month &&
            recentTrx[i].tanggal.year == weekday.year) {
          jumlahHarga += recentTrx[i].harga;
        }
      }
      //print(DateFormat.E().format(weekday).toString());
      //print(jumlahHarga);

      return {'day': DateFormat.E().format(weekday).toString(), 'harga': jumlahHarga};
    });
  }

  double get totalAll{
    return groupedTrx.fold(0, (sumx, amnt) {
      return sumx + amnt['harga'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print (totalAll);
    return Column(
      children: groupedTrx.map((data){
        return Text("${data['day']}");
      }).toList()
      
      
      );


    
  }
}
