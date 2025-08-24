import 'package:flutter/widgets.dart';

class PageContentWrapper extends StatelessWidget {
  const PageContentWrapper({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsetsGeometry.all(14), child: child);
  }
}
