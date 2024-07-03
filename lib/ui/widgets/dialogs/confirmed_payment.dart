import 'package:flutter/material.dart';

import '../spacing.dart';

class ConfirmedPaymentDialog extends StatelessWidget {
  const ConfirmedPaymentDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
        ),
        decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.circular(10),
        ),
        width: 250,
        height: 140,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 40,
              width: 40,
              child: CircularProgressIndicator(),
            ),
            vs(16),
            Text(
              'Payment confirmed. Thank you',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 18,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
