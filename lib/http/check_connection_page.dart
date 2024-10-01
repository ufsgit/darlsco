import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class CheckConnectionPage extends StatelessWidget {
  const CheckConnectionPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Check Connection Page")),
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
            child: const Text("Check Connection"),
            onPressed: () async {
              final connectivityResult =
                  await Connectivity().checkConnectivity();
              if (connectivityResult == ConnectivityResult.none) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text(
                    'You\'re not connected to a network')
                ));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('You\'re connected to a $connectivityResult network')
                ));
              }
            },
          ),
        ),
      ),
    );
  }
}