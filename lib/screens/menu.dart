import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/containers/page_container_with_footer.dart';
import 'package:in_zone_app/widgets/screens/menu/menu_widget.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return PageContainerWithFooter(
      background: Theme.of(context).splashColor,
      body: const MenuWidget());
  }
}