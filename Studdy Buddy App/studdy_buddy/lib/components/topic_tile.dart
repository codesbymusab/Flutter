import 'package:flutter/material.dart';
import 'package:studdy_buddy/models/topic_model.dart';
import 'package:studdy_buddy/pages/learning_mode_page.dart';
import 'package:studdy_buddy/utils/themes/app_colors.dart';
import 'package:studdy_buddy/utils/themes/app_light_theme.dart';

class TopicTile extends StatelessWidget {
  final Topic topic;
  final String topicImage;
  const TopicTile({super.key, required this.topic, required this.topicImage});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          ListTile(
            minTileHeight: 80,
            minLeadingWidth: 80,
            dense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 20),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LearningModePage(topic: topic),
                ),
              );
            },
            tileColor: primaryContainerColor(context),
            splashColor: primaryLightColor(context),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(20),
            ),
            title: Text(
              topic.name,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            leading: Padding(padding: EdgeInsetsGeometry.all(0)),
            trailing: CircleAvatar(
              backgroundColor: primaryTileColor(context),
              radius: 40,
              child: Icon(Icons.topic, size: 30),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: 80,
                padding: EdgeInsets.all(0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.asset(topicImage, fit: BoxFit.fill),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
