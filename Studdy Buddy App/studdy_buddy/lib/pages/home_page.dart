import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';
import 'package:studdy_buddy/components/subject_tile.dart';
import 'package:studdy_buddy/models/subject_model.dart';
import 'package:studdy_buddy/services/study_services.dart';
import 'package:studdy_buddy/utils/themes/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(gradient: mainGradinet(context)),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 20,
            children: [
              IconButton(
                icon: SvgPicture.asset(
                  'assets/icons/menuleft.svg',
                  width: 20,
                  height: 20,
                  colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
                onPressed: () {
                  ZoomDrawer.of(context)!.toggle();
                },
              ),

              Row(
                spacing: 10,
                children: [
                  SvgPicture.asset(
                    'assets/icons/peace.svg',
                    width: 40,
                    height: 30,
                    colorFilter: ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                  Text(
                    'Hello Friend',
                    style: Theme.of(
                      context,
                    ).textTheme.headlineSmall!.apply(color: Colors.white),
                  ),
                ],
              ),
              Text(
                'What do you want to learn today?',
                style: Theme.of(
                  context,
                ).textTheme.headlineMedium!.apply(color: Colors.white),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: primaryContainerColor(context),
                    borderRadius: BorderRadius.circular(20),
                  ),

                  padding: EdgeInsets.all(20),
                  child: FutureBuilder(
                    future: context.read<StudyBuddyServices>().fetchSubjects(),
                    builder: (context, asyncSnapshot) {
                      if (asyncSnapshot.hasData) {
                        return ListView.builder(
                          itemCount: asyncSnapshot.data!.length,
                          itemBuilder: (context, index) =>
                              SubjectTile(subject: asyncSnapshot.data![index]),
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
