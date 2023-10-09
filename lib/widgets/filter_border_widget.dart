import 'package:flutter/material.dart';
import '../autoload/autoloader.dart';

class FilterBorderWidget extends StatelessWidget {
  const FilterBorderWidget({
    super.key,
    required this.clearPressed,
    required this.label,
    required this.onPressed,
    this.selectedFilter,
  });

  final VoidCallback clearPressed;
  final String label;
  final VoidCallback onPressed;
  final String? selectedFilter;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (selectedFilter != null)
          RoundedIconButton(
            icon: Icons.clear,
            onPressed: clearPressed,
          ),
        if (selectedFilter != null) const SizedBox(width: 10),
        CustomBorderLabel(
          label: selectedFilter ?? label,
          onPressed: onPressed,
          backgroundColor:
              selectedFilter == null ? null : selectedBackgroundColor,
        ),
      ],
    );
  }
}
