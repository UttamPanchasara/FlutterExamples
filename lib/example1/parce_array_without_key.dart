import 'package:flutter/material.dart';
import 'package:flutter_examples/example1/bitcoins.dart';

class ParseArrayWithoutKey extends StatefulWidget {
  @override
  _ParseArrayWithoutKeyState createState() => _ParseArrayWithoutKeyState();
}

class _ParseArrayWithoutKeyState extends State<ParseArrayWithoutKey> {
  bool isLoading = false;
  List<Bitcoin> bitcoinList = [];

  @override
  void initState() {
    super.initState();
    _fetchBitcoins();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Array without key'),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Stack(
        children: <Widget>[
          ListView.builder(
            itemCount: bitcoinList.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              var bitcoin = bitcoinList[index];
              return Container(
                padding: EdgeInsets.only(left: 5, right: 5, top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(bitcoin.tid.toString()),
                    Text(
                      bitcoin.price.toUpperCase(),
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              );
            },
          ),
          _showIndicator(),
        ],
      ),
    );
  }

  Widget _showIndicator() {
    if (isLoading) {
      return Container(
        margin: EdgeInsets.all(20),
        child: Center(child: CircularProgressIndicator()),
      );
    } else {
      return Container();
    }
  }

  void _fetchBitcoins() async {
    if (!isLoading) {
      isLoading = true;
      setState(() {});

      await fetchBitcoins().then((bitcoins) {
        for (var value in bitcoins) {
          if (value != null) {
            bitcoinList.add(value);
          }
        }
      }).catchError((error) {
        print(error);
      }).whenComplete(() {
        isLoading = false;
        setState(() {});
      });
    }
  }
}
