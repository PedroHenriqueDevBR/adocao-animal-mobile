import 'package:flutter/material.dart';

class DropdownContainerWidget extends StatelessWidget {
  final Widget child;
  const DropdownContainerWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade300,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(4.0),
        ),
      ),
      child: child,
    );
  }
}
