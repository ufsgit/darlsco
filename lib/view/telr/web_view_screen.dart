import 'dart:async';
import 'dart:io';

import 'package:darlsco/controller/tainning/training_controller_home.dart';
import 'package:darlsco/controller/tainning/trainnig_controller.dart';
import 'package:darlsco/view/home/bottom_navigation_screen.dart';
import 'package:darlsco/view/telr/network_helper_class.dart';
import 'package:darlsco/view/training_phase2/ordered_successfully.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xml/xml.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../core/constants/image_url.dart';

class WebViewScreen extends StatefulWidget {
  final url;
  final code;
  final isRetake;
  final orderMasterId;
  const WebViewScreen(
      {super.key,
      required this.url,
      required this.code,
      required this.isRetake,
      required this.orderMasterId});

  @override
  WebViewScreenState createState() => WebViewScreenState();
}

class WebViewScreenState extends State<WebViewScreen> {
  String _url = '';
  String _code = '';
  final bool _showLoader = false;
  bool _showedOnce = false;

  @override
  void initState() {
    super.initState();

    print(
        'web view bill list ${trainingController.retakePurchaseBillDataList}');

    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    _url = widget.url;
    _code = widget.code;
    print('url in webview $_url, $_code');
  }

  void complete(XmlDocument xml) async {
    homeController.isFromPurchase.value = false;
    // setState(() {
    //   _showLoader = true;
    // });
    NetworkHelper networkHelper = NetworkHelper();
    var response = await NetworkHelper.completed(xml);
    print("telr   $response");
    if (response == 'failed' || response == null) {
      alertShow('Failed. Please try again', false);
      // setState(() {
      //   _showLoader = false;
      // });
    } else {
      final doc = XmlDocument.parse(response);
      print(' element  $doc ');
      final message = doc.findAllElements('message').first.text;

      tcontoller.cardNumber.value = doc.findAllElements('cardlast4').first.text;
      tcontoller.orderNo.value = doc.findAllElements('tranref').first.text;
      print("card number  ${tcontoller.cardNumber.value}");
      if (message.toString().length > 2) {
        String msg = message.toString();
        msg = msg.replaceAll('(', '');
        msg = msg.replaceAll(')', '');
        // setState(() {
        //   _showLoader = false;
        // });
        // if (!_showedOnce) {
        if (msg == 'Authorised') {
          print("dgsrgerw ${tcontoller.totalPrice}");
          tcontoller.isPaymentSuccessful.value = true;

          Get.to(() => OrderedSuccessfully(
                isPayment: true,
                isRetake: widget.isRetake,
                orderMasterId: widget.orderMasterId,
              ));
        } else {
          print(' order failed message  $msg');
          tcontoller.isPaymentSuccessful.value = false;

          Get.to(() => OrderedSuccessfully(
                isRetake: widget.isRetake,
                isPayment: false,
                orderMasterId: widget.orderMasterId,
              ));
        }

        _showedOnce = true;

        // alertShow('Your transaction is $msg', true);

        // https://secure.telr.com/gateway/webview_start.html?code=a8caa483fe7260ace06a255cc32e
      }
    }
  }

  void alertShow(String text, bool pop) {
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
              if (pop) {
                Navigator.pop(context);
                Navigator.pop(context);
              } else {
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }

  void createXml() {
    final builder = XmlBuilder();
    builder.processing('xml', 'version="1.0"');
    builder.element('mobile', nest: () {
      builder.element('store', nest: () {
        builder.text('30267');
      });
      builder.element('key', nest: () {
        builder.text("MF27f#hJF9T@d7QB");
      });
      builder.element('complete', nest: () {
        builder.text(_code);
      });
    });

    final bookshelfXml = builder.buildDocument();
    print(bookshelfXml);
    complete(bookshelfXml);
  }

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    print('rebuilded again');
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'Payment',
            style: TextStyle(color: Colors.black),
          ),
          leading: Center(
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ),
        ),
        body: Center(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(splashScreenLogo))),
            child: WebView(
              onProgress: (progress) {
                print('WEB VIEW PROGRESS   $progress');
              },
              initialUrl: _url,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
              navigationDelegate: (NavigationRequest request) {
                print('allowing navigation to $request');
                return NavigationDecision.navigate;
              },
              onPageStarted: (String url) {
                print('Page started loading: $url');
                _showedOnce = false;
                if (url.contains('close')) {
                  print('call the api');
                }
                if (url.contains('abort')) {
                  print('show fail and pop');
                }
              },
              onPageFinished: (String url) {
                print('Page finished loading: $url');
                if (url.contains('close')) {
                  print('call the api');
                  createXml();
                }
                if (url.contains('abort')) {
                  print('show fail and pop');
                }
              },
              onWebResourceError: (error) {
                print('web view error ${error.description}');
              },
              gestureNavigationEnabled: true,
            ),
          ),
        ));
  }
}
