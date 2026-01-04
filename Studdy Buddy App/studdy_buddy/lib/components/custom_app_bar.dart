import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:studdy_buddy/components/background_painter.dart';
import 'package:studdy_buddy/utils/themes/app_colors.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final double? height;
  final Widget title;
  final Widget? leading;
  final bool showActionIcon;
  final VoidCallback? onMenuActionTap;

  const CustomAppBar({
    super.key,
    this.height,
    required this.title,
    required this.showActionIcon,

    this.leading,
    this.onMenuActionTap,
  });
  @override
  Size get preferredSize => Size(double.infinity, height ?? 80);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          color: secondaryColor(context),
          child: CustomPaint(painter: BackgroundPainter()),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 45.0,
              bottom: 8,
              left: 12,
              right: 12,
            ),
            child: Builder(
              builder: (context) {
                return Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child:
                          widget.leading ??
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                    ),

                    Positioned.fill(child: Center(child: widget.title)),

                    if (widget.showActionIcon) ...{
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          onPressed: widget.onMenuActionTap,
                          icon: SvgPicture.asset(
                            'assets/icons/menu.svg',
                            colorFilter: ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                            height: 20,
                          ),
                        ),
                      ),
                    },
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
