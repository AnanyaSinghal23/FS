import 'package:flutter/material.dart';

class News extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('ताज़ा खबरे'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildNewsItem('खेती में यूरिया छिड़काव के लिए ये नई तकनीक की शुरू, किसानों बस 100 रूपए में करवा सकेंगे छिड़काव'),
              buildNewsItem('PM कुसुम किसान योजना के तहत किसानों को मिलेंगे सोलर पंप, जानें कैसे करें आवेदन '),
              buildNewsItem('भीलवाड़ा में इजरायली तकनीक से बिना मिट्टी के हो रही खेती! किसानों को बढ़िया मुनाफा'),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNewsItem(String heading) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey, 
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  heading,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
