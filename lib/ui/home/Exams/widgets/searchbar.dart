import 'package:flutter/material.dart';
import 'package:prep_pro/ui/widgets/spacing.dart';
import 'package:prep_pro/utils/colors.dart';

class SearchBarWithFilter extends StatelessWidget {
  const SearchBarWithFilter(
      {required this.onFilterTap, required this.onTextChanged, super.key});

  final Function(String)? onTextChanged;
  final VoidCallback onFilterTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: onTextChanged,
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          hs(4),
          ElevatedButton(
            onPressed: onFilterTap,
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(), backgroundColor: AppColors.primary,
              padding: const EdgeInsets.all(16.0), // Button color
            ),
            child: const Icon(
              Icons.filter_list,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
