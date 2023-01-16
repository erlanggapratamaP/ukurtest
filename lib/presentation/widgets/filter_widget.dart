import 'package:flutter/material.dart';

class FilterWidget extends StatefulWidget {
  final VoidCallback filterOnTap;

  const FilterWidget({
    Key? key,
    required this.filterOnTap,
  }) : super(key: key);

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: IconButton(
        iconSize: 30,
        onPressed: widget.filterOnTap,
        icon: const Icon(Icons.filter_alt_outlined),
        color: Colors.black,
      ),
    );
  }
}
