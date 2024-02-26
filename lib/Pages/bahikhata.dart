import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Logbook',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LogbookPage(
        userEmail: 'user@example.com',
      ),
    );
  }
}

class LogbookPage extends StatefulWidget {
  final String userEmail;

  LogbookPage({required this.userEmail});

  @override
  _LogbookPageState createState() => _LogbookPageState();
}

class _LogbookPageState extends State<LogbookPage> {
  final TextEditingController cropController = TextEditingController();
  final TextEditingController totalQuantityController = TextEditingController();
  final TextEditingController soldQuantityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController sellerNameController = TextEditingController();
  final TextEditingController totalSalePriceController = TextEditingController();
  final TextEditingController receiptController = TextEditingController();

  final CollectionReference userDatasetCollection =
      FirebaseFirestore.instance.collection('userDatasets');

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? selectedCrop;

  void clearTextControllers() {
    cropController.clear();
    totalQuantityController.clear();
    soldQuantityController.clear();
    priceController.clear();
    sellerNameController.clear();
    totalSalePriceController.clear();
    receiptController.clear();
  }

  Widget buildTextFormField(TextEditingController controller, String labelText, TextInputType keyboardType) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(labelText: labelText),
      validator: (value) => value == null || value.isEmpty ? 'Please enter $labelText' : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Logbook'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('बही खाता'),
                DropdownButtonFormField<String>(
                  value: selectedCrop,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCrop = newValue ?? '';
                    });
                  },
                  decoration: const InputDecoration(labelText: 'कृपया फसल चुनें'),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Please select a crop' : null,
                  items: ['ज्वार', 'गेहूँ', 'अरहर', 'सरसों', 'चावल'].map<DropdownMenuItem<String>>(
                    (String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    ),
                  ).toList(),
                ),
                buildTextFormField(totalQuantityController, 'उगाई गई फसल की कुल मात्रा', TextInputType.number),
                                buildTextFormField(soldQuantityController, 'बेची गई फसल की कुल मात्रा', TextInputType.number),
                buildTextFormField(priceController, 'किस कीमत पर', TextInputType.number),
                buildTextFormField(sellerNameController, 'थोक विक्रेता का नाम', TextInputType.text),
                buildTextFormField(totalSalePriceController, 'कुल विक्रय मूल्य', TextInputType.number),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      await userDatasetCollection.add({
                        'userEmail': widget.userEmail,
                        'crop': selectedCrop,
                        'totalQuantity': int.parse(totalQuantityController.text),
                        'soldQuantity': int.parse(soldQuantityController.text),
                        'price': double.parse(priceController.text),
                        'sellerName': sellerNameController.text,
                        'totalSalePrice': double.parse(totalSalePriceController.text),
                      });

                      clearTextControllers();

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Logbook entry saved successfully!'),
                        ),
                      );
                    }
                  },
                  child: const Text('सेव'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      cropController.clear();
                      totalQuantityController.clear();
                      soldQuantityController.clear();
                      priceController.clear();
                      sellerNameController.clear();
                      totalSalePriceController.clear();
                    });
                  },
                  child: const Text('हटाएं'),
                ),
                // const SizedBox(height: 20),
                // Center(
                //   child: ElevatedButton(
                //     onPressed: () {
                //       showDialog(
                //         context: context,
                //         builder: (BuildContext context) {
                //           return AlertDialog(
                //             title: const Text('रसीद अपलोड करें'),
                //             content: Text('done'),
                //             actions: <Widget>[
                //               TextButton(
                //                 child: const Text('OK'),
                //                 onPressed: () {
                //                   Navigator.of(context).pop();
                //                 },
                //               ),
                //             ],
                //           );
                //         },
                //       );
                //     },
                //     child: const Text('रसीद चुनें'),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class LogbookPage extends StatefulWidget {
//   final String userEmail;

//   LogbookPage({required this.userEmail});

//   @override
//   _LogbookPageState createState() => _LogbookPageState();
// }

// class _LogbookPageState extends State<LogbookPage> {
//   final TextEditingController quantityController = TextEditingController();
//   final TextEditingController sellController = TextEditingController();
//   final TextEditingController priceController = TextEditingController();
//   final TextEditingController totalSaleController = TextEditingController();
//   final TextEditingController receiptController = TextEditingController();

//   final CollectionReference userDatasetCollection =
//       FirebaseFirestore.instance.collection('userDatasets');

//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   String selectedCrop = '';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Logbook'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 DropdownButtonFormField<String>(
//                   value: selectedCrop,
//                   onChanged: (String? newValue) {
//                     setState(() {
//                       selectedCrop = newValue ?? '';
//                     });
//                   },
//                   decoration: InputDecoration(labelText: 'Crop'),
//                   validator: (value) =>
//                       value == null || value.isEmpty ? 'Please select a crop' : null,
//                   items: [
//                     'Crop A',
//                     'Crop B',
//                     'Crop C',
//                     'Crop D',
//                     'Crop E',
//                   ].map<DropdownMenuItem<String>>(
//                     (String value) => DropdownMenuItem<String>(
//                       value: value,
//                       child: Text(value),
//                     ),
//                   ).toList(),
//                 ),
//                 buildTextFormField(quantityController, 'Quantity', TextInputType.number),
//                 buildTextFormField(sellController, 'Sell', TextInputType.text),
//                 buildTextFormField(priceController, 'Price', TextInputType.number),
//                 buildTextFormField(totalSaleController, 'Total Sale', TextInputType.number),
//                 buildTextFormField(receiptController, 'Receipt', TextInputType.text),
//                 SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () async {
//                     if (_formKey.currentState?.validate() ?? false) {
//                       await userDatasetCollection.add({
//                         'userEmail': widget.userEmail,
//                         'crop': selectedCrop,
//                         'quantity': quantityController.text,
//                         'sell': sellController.text,
//                         'price': priceController.text,
//                         'totalSale': totalSaleController.text,
//                         'receipt': receiptController.text,
//                       });

//                       clearTextControllers();

//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content: Text('Logbook entry saved successfully!'),
//                         ),
//                       );
//                     }
//                   },
//                   child: Text('Save Logbook Entry'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildTextFormField(TextEditingController controller, String labelText, TextInputType keyboardType) {
//     return TextFormField(
//       controller: controller,
//       decoration: InputDecoration(labelText: labelText),
//       keyboardType: keyboardType,
//       validator: (value) => value == null || value.isEmpty ? 'Please enter $labelText information' : null,
//     );
//   }

//   void clearTextControllers() {
//     quantityController.clear();
//     sellController.clear();
//     priceController.clear();
//     totalSaleController.clear();
//     receiptController.clear();
//   }
// }






// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class LogbookPage extends StatefulWidget {
//   final String userEmail;

//   LogbookPage({required this.userEmail});

//   @override
//   _LogbookPageState createState() => _LogbookPageState();
// }

// class _LogbookPageState extends State<LogbookPage> {
//   final TextEditingController cropController = TextEditingController();
//   final TextEditingController quantityController = TextEditingController();
//   final TextEditingController sellController = TextEditingController();
//   final TextEditingController priceController = TextEditingController();
//   final TextEditingController totalSaleController = TextEditingController();
//   final TextEditingController receiptController = TextEditingController();
//   String ddval='';
//   // List<String> cropList = []; // To store the list of crops
//   // final CollectionReference userDatasetCollection =
//   //     FirebaseFirestore.instance.collection('userDatasets');
//   // final CollectionReference cropCollection =
//   //     FirebaseFirestore.instance.collection('crops');

//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Logbook'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // DropdownButtonFormField<String>(
//                 //   value: cropController.text,
//                 //   items: cropList.map((crop) {
//                 //     return DropdownMenuItem<String>(
//                 //       value: crop,
//                 //       child: Text(crop),
//                 //     );
//                 //   }).toList(),
//                 //   onChanged: (value) {
//                 //     setState(() {
//                 //       cropController.text = value!;
//                 //     });
//                 //   },
//                 //   decoration: InputDecoration(labelText: 'Crop'),
//                 //   validator: (value) {
//                 //     if (value == null || value.isEmpty) {
//                 //       return 'Please select a crop';
//                 //     }
//                 //     return null;
//                 //   },
//                 // ),
//                 DropdownButton<String>(value: ddval,onChanged: (String? newValue),items: [const DropdownMenuItem<String>(child: child)],),
//                 TextFormField(
//                   controller: quantityController,
//                   decoration: InputDecoration(labelText: 'Quantity'),
//                   keyboardType: TextInputType.number,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter a quantity';
//                     }
//                     return null;
//                   },
//                 ),
//                 TextFormField(
//                   controller: sellController,
//                   decoration: InputDecoration(labelText: 'Sell'),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter sell information';
//                     }
//                     return null;
//                   },
//                 ),
//                 TextFormField(
//                   controller: priceController,
//                   decoration: InputDecoration(labelText: 'Price'),
//                   keyboardType: TextInputType.number,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter a price';
//                     }
//                     return null;
//                   },
//                 ),
//                 TextFormField(
//                   controller: totalSaleController,
//                   decoration: InputDecoration(labelText: 'Total Sale'),
//                   keyboardType: TextInputType.number,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter total sale information';
//                     }
//                     return null;
//                   },
//                 ),
//                 TextFormField(
//                   controller: receiptController,
//                   decoration: InputDecoration(labelText: 'Receipt'),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter receipt information';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () async {
//                     if (_formKey.currentState?.validate() ?? false) {
//                       await userDatasetCollection.add({
//                         'userEmail': widget.userEmail,
//                         'crop': cropController.text,
//                         'quantity': quantityController.text,
//                         'sell': sellController.text,
//                         'price': priceController.text,
//                         'totalSale': totalSaleController.text,
//                         'receipt': receiptController.text,
//                       });

//                       // Clear text controllers after saving
//                       quantityController.clear();
//                       sellController.clear();
//                       priceController.clear();
//                       totalSaleController.clear();
//                       receiptController.clear();

//                       // Show a snackbar or navigate to another screen after saving
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content:
//                               Text('Logbook entry saved successfully!'),
//                         ),
//                       );
//                     }
//                   },
//                   child: Text('Save Logbook Entry'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


//  /*StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
//                 stream: cropListCollection.snapshots(),
//                 builder: (context, snapshot) {
//                   if (snapshot.hasError) {
//                     return Text('Error: ${snapshot.error}');
//                   }

//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return CircularProgressIndicator();
//                   }

//                   List<String> crops = snapshot.data?.docs
//                           .map((DocumentSnapshot<Map<String, dynamic>> document) =>
//                               document.data()?['name'] as String? ?? '')
//                           .toList() ??
//                       [];

//                   return DropdownButtonFormField<String>(
//                     decoration: InputDecoration(labelText: 'Crop'),
//                     value: cropController.text,
//                     items: crops.map((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(value),
//                       );
//                     }).toList(),
//                     onChanged: (String? newValue) {
//                       setState(() {
//                         cropController.text = newValue ?? '';
//                       });
//                     },
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please select a crop';
//                       }
//                       return null;
//                     },
//                   );
//                 },
//               ),*/