import 'dart:io';
import 'dart:math';

import 'package:darlsco/controller/tainning/trainnig_controller.dart';
import 'package:darlsco/model/training/purchase_order_model.dart';
import 'package:darlsco/view/telr/network_helper_class.dart';
import 'package:darlsco/view/telr/web_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:xml/xml.dart';

import '../../controller/tainning/training_controller_home.dart';

class TelrDummyPage extends StatefulWidget {
  final PurchaseOrderModel model;
  final isReTake;
  final orderMasterId;
  const TelrDummyPage({super.key, required this.model,required this.isReTake,required this.orderMasterId});

  @override
  State<TelrDummyPage> createState() => _TelrDummyPageState();
}

class _TelrDummyPageState extends State<TelrDummyPage> {
  @override
  void initState() {
    init();
   
    super.initState();
  }

  init()async{
    await trainingController.getProfile();
  }
  
  @override
  Widget build(BuildContext context) {
    TextEditingController amount = TextEditingController();
    TextEditingController currency = TextEditingController();

    String storeId = '30267';
    String apiKey = "MF27f#hJF9T@d7QB";
    return Scaffold(
      appBar: AppBar(
        title: const Text('Telr Page'),
      ),
      body: Column(
        children: [
          TextField(
            controller: amount,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 13, color: Colors.red),
            decoration: const InputDecoration(
              hintText: "Enter Amount",
              errorStyle: TextStyle(fontSize: 10),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          TextField(
            controller: currency,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 13),
            decoration: const InputDecoration(
              hintText: "Enter currency",
              errorStyle: TextStyle(fontSize: 10),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          ElevatedButton(
              child: Container(
                height: 50,
                color: Colors.grey,
                child: const Center(
                    child: Text(
                  'PAY',
                  style: TextStyle(color: Colors.black, fontSize: 12),
                )),
              ),
              onPressed: () {
                final builder = XmlBuilder();
                builder.processing('xml', 'version="1.0"');
                builder.element('mobile', nest: () {
                  builder.element('store', nest: () {
                    builder.text(storeId);
                  });
                  builder.element('key', nest: () {
                    builder.text(apiKey);
                  });

                  builder.element('device', nest: () {
                    builder.element('type', nest: () {
                      builder.text(Platform.isAndroid?'Android':'IOS');
                    });
                    builder.element('id', nest: () {
                      builder.text('1');
                    });
                  });

                  // app
                  builder.element('app', nest: () {
                    builder.element('name', nest: () {
                      builder.text('Darlsco');
                    });
                    builder.element('version', nest: () {
                      builder.text('1.1.6');
                    });
                    builder.element('user', nest: () {
                      builder.text('2');
                    });
                    builder.element('id', nest: () {
                      builder.text('1');
                    });
                  });

                  //tran
                  builder.element('tran', nest: () {
                    builder.element('live', nest: () {
                      builder.text('0');
                    });
                    builder.element('type', nest: () {
                      builder.text('auth');
                    });
                    builder.element('class', nest: () {
                      builder.text('paypage');
                    });
                    builder.element('cartid', nest: () {
                      builder.text(100000000 + Random().nextInt(999999999));
                    });
                    builder.element('description', nest: () {
                      builder.text('Test for Mobile API order');
                    });
                    builder.element('currency', nest: () {
                      builder.text(currency.text);
                    });
                    builder.element('amount', nest: () {
                      builder.text(amount.text);
                    });
                    builder.element('language', nest: () {
                      builder.text('en');
                    });
                    builder.element('firstref', nest: () {
                      builder.text('first');
                    });
                    builder.element('ref', nest: () {
                      builder.text('null');
                    });
                  });

                  //billing
                  builder.element('billing', nest: () {
                    // name
                    builder.element('name', nest: () {
                      builder.element('title', nest: () {
                        builder.text('');
                      });
                      builder.element('first', nest: () {
                        builder.text('Div');
                      });
                      builder.element('last', nest: () {
                        builder.text('V');
                      });
                    });
                    // address
                    builder.element('address', nest: () {
                      builder.element('line1', nest: () {
                        builder.text('Dubai');
                      });
                      builder.element('city', nest: () {
                        builder.text('Dubai');
                      });
                      builder.element('region', nest: () {
                        builder.text('');
                      });
                      builder.element('country', nest: () {
                        builder.text('AE');
                      });
                    });

                    builder.element('phone', nest: () {
                      builder.text(trainingController.profileDetails[0].mobile);
                    });
                    builder.element('email', nest: () {
                      builder.text(trainingController.profileDetails[0].email);
                    });
                  });
                });

                final bookshelfXml = builder.buildDocument();

                pay(bookshelfXml, context,widget.isReTake,widget.orderMasterId);
              })
        ],
      ),
    );
  }
}

void pay(XmlDocument xml, context,isReTake,orderMasterId) async {
  NetworkHelper networkHelper = NetworkHelper();
  var response = await NetworkHelper.pay(xml);
  print(response);
  if (response == 'failed' || response == null) {
    print('failed');
    //
    alertShow('Failed', context);
//
  } else {
    final doc = XmlDocument.parse(response);
    final url = doc.findAllElements('start').map((node) => node.text);
    final code = doc.findAllElements('code').map((node) => node.text);
    print(url);
    String url0 = url.toString();
    String code0 = code.toString();
    if (url0.length > 2) {
      url0 = url0.replaceAll('(', '');
      url0 = url0.replaceAll(')', '');
      code0 = code0.replaceAll('(', '');
      code0 = code0.replaceAll(')', '');
      launchURL(url0, code0, context,isReTake,orderMasterId);
    }
    // print(   ' doc file response from telr $doc');
    print(url0);
    final message = doc.findAllElements('message').map((node) => node.text);
    print('Message =  $message');

    print('card number ${tcontoller.cardNumber.value}');

    if (message.toString().length > 2) {
      String msg = message.toString();
      msg = msg.replaceAll('(', '');
      msg = msg.replaceAll(')', '');

      print('successfully');
      alertShow(msg, context);
    }
  }
}

void alertShow(String text, context) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(
        text,
        style: const TextStyle(fontSize: 15),
      ),
      actions: <Widget>[
        ElevatedButton(
            child: const Text('Ok'),
            onPressed: () {
              Navigator.pop(context);
            }),
      ],
    ),
  );
}

void launchURL(String url, String code, context,isRetake,orderMasterId) async {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (BuildContext context) => WebViewScreen(
           isRetake: isRetake,
                url: url,
                code: code,
                orderMasterId: orderMasterId,
              )));
}
