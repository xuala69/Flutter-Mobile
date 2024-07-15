import 'package:flutter/material.dart';
import 'package:prep_pro/ui/widgets/spacing.dart';
import 'package:prep_pro/utils/nums.dart';

class HomeChildTitle extends StatelessWidget {
  const HomeChildTitle({
    super.key,
    required this.title,
    this.action,
  });

  final String title;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize: Nums.appbarHeight,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        action ?? hs(0),
      ],
    );
  }
}
