import 'dart:convert';
import 'package:http/http.dart' as http;

List<Bitcoin> clientFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<Bitcoin>.from(jsonData.map((x) => Bitcoin.fromJson(x)));
}

String clientToJson(List<Bitcoin> data) {
  final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}

class Bitcoin {
  String tid;
  String date;
  String type;
  String price;
  String amount;

  Bitcoin({this.tid, this.date, this.type, this.price, this.amount});

  factory Bitcoin.fromJson(Map<String, dynamic> json) {
    return Bitcoin(
      tid: json['tid'].toString(),
      date: json['date'].toString(),
      type: json['type'].toString(),
      price: json['price'].toString(),
      amount: json['amount'].toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        "tid": tid,
        "date": date,
        "type": type,
        "price": price,
        "amount": amount,
      };
}

Future<List<Bitcoin>> fetchBitcoins() async {
  final response =
      await http.get('https://www.mercadobitcoin.net/api/XRP/trades/');
  if (response.statusCode == 200) {
    return clientFromJson(response.body);
  } else {
    throw Exception('Failed to fetch Images');
  }
}
