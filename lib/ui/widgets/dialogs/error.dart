import 'package:flutter/material.dart';

class NetworkErrorDialog extends StatelessWidget {
  final String errorMsg;
  const NetworkErrorDialog({required this.errorMsg, super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.grey[700],
      child: ListTile(
        title: const Text("Network Error"),
        subtitle: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(errorMsg),
            MaterialButton(
              onPressed: () {},
              child: const Text("OKAY"),
            )
          ],
        ),
      ),
    );
  }
}