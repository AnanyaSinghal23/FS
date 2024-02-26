import 'package:flutter/material.dart';

class CropListPage extends StatefulWidget {
  @override
  _CropListPageState createState() => _CropListPageState();
}

class _CropListPageState extends State<CropListPage> {
  List<Crop> _crops = [];

  _generateData() {
    _crops = [
      Crop('चावल', 50),
      Crop('गेहूँ', 40),
      Crop('बाजरा', 60),
      Crop('मक्का', 70),
      Crop('गेहूँ', 45),
    ];
  }

  @override
  void initState() {
    super.initState();
    _generateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('फसलों की सूची'),
      ),
      body: ListView.builder(
        itemCount: _crops.length,
        itemBuilder: (context, index) {
          return Container(
            color: Colors.grey[200],
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    _crops[index].name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  '${_crops[index].price} रुपए',
                  style: TextStyle(color: Colors.green),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _crops.add(Crop('नए फसल', 0));
          });
        },
        tooltip: 'Add Crop',
        child: Icon(Icons.add),
      ),
    );
  }
}

class Crop {
  final String name;
  final int price;

  Crop(this.name, this.price);
}
