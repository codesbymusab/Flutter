import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studdy_buddy/components/topic_tile.dart';
import 'package:studdy_buddy/models/subject_model.dart';
import 'package:studdy_buddy/services/study_services.dart';
import 'package:studdy_buddy/utils/themes/app_colors.dart';

class TopicPage extends StatelessWidget {
  final Subject subject;
  const TopicPage({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: mainGradinet(context)),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 40,
            children: [
              Row(
                spacing: 10,
                children: [
                  Image.asset(subject.icon, height: 100, width: 100),
                  Text(
                    subject.name,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Which topic you want to study?',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              Expanded(
                child: FutureBuilder(
                  future: context.read<StudyBuddyServices>().fetchSubjectTopics(
                    subject.id,
                  ),
                  builder: (context, asyncSnapshot) {
                    if (asyncSnapshot.hasData) {
                      final topicList = asyncSnapshot.data!;
                      return ListView.builder(
                        itemCount: topicList.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TopicTile(
                            topic: topicList[index],
                            topicImage: 'assets/images/math_0${index + 1}.png',
                          ),
                        ),
                      );
                    } else {
                      return AlertDialog(title: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
