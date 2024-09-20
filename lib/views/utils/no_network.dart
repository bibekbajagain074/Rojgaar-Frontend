import 'package:flutter/material.dart';

class NoNetwork extends StatefulWidget {
  const NoNetwork({super.key});

  @override
  State<NoNetwork> createState() => _NoNetworkState();
}

class _NoNetworkState extends State<NoNetwork> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SafeArea(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'No network connection found!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
                child: Text(
              'Please establish a connection to continue',
              textAlign: TextAlign.center,
            )),
          ],
        )
      ],
    )));
  }
}
