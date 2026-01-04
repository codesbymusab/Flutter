import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MenuDrawerButton extends StatelessWidget {
  final String buttonLabel;
  final String icon;
  final String route;
  const MenuDrawerButton({
    super.key,
    required this.buttonLabel,
    required this.icon,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(20),
        ),
        leading: SvgPicture.asset(
          icon,
          height: 20,
          width: 20,
          colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
        title: Text(
          buttonLabel,
          style: Theme.of(
            context,
          ).textTheme.headlineMedium!.apply(color: Colors.white),
        ),
        onTap: () {},
      ),
    );
  }
}
