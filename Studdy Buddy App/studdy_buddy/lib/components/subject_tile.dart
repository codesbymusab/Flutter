import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:studdy_buddy/models/subject_model.dart';
import 'package:studdy_buddy/pages/topics_page.dart';
import 'package:studdy_buddy/utils/themes/app_colors.dart';
import 'package:studdy_buddy/utils/themes/app_dark_theme.dart';
import 'package:studdy_buddy/utils/themes/app_light_theme.dart';

class SubjectTile extends StatelessWidget {
  final Subject subject;
  const SubjectTile({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Colors.transparent,
        child: ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TopicPage(subject: subject),
              ),
            );
          },
          splashColor: primaryLightColor(context),
          contentPadding: EdgeInsets.symmetric(horizontal: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(15),
          ),
          tileColor: primaryTileColor(context),
          isThreeLine: true,
          leading: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: primaryContainerColorLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.asset(subject.icon),
          ),
          title: Text(
            subject.name,
            style: Theme.of(
              context,
            ).textTheme.headlineMedium!.apply(color: primaryColor(context)),
          ),
          subtitle: Column(
            children: [
              Text(
                subject.description,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(
                    Icons.help_rounded,
                    size: 20,
                    color: primaryColor(context),
                  ),
                  Text('10', style: Theme.of(context).textTheme.headlineSmall),
                  SizedBox(width: 10),
                  Icon(Icons.timer, size: 20, color: primaryColor(context)),
                  Text(
                    '15 min',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: primaryColor(context),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                    child: SvgPicture.asset(
                      'assets/icons/trophyoutline.svg',
                      width: 20,
                      height: 20,
                      colorFilter: ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
