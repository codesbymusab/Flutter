import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import 'package:studdy_buddy/components/custom_app_bar.dart';
import 'package:studdy_buddy/components/elevated_button.dart';
import 'package:studdy_buddy/components/page_background.dart';
import 'package:studdy_buddy/models/flashcard_model.dart';
import 'package:studdy_buddy/services/study_services.dart';
import 'package:studdy_buddy/utils/themes/app_colors.dart';
import 'package:studdy_buddy/utils/themes/app_dark_theme.dart';

class FlashCardPage extends StatefulWidget {
  final List<String> flashCards;
  const FlashCardPage({super.key, required this.flashCards});

  @override
  State<FlashCardPage> createState() => _FlashCardPageState();
}

class _FlashCardPageState extends State<FlashCardPage> {
  bool revealed = false;
  bool speaking = false;

  final flipController = FlipCardController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int cardNo = context.watch<StudyBuddyServices>().questionNo;

    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          'Card No.${cardNo + 1}',
          style: Theme.of(
            context,
          ).textTheme.headlineMedium!.apply(color: Colors.white),
        ),
        showActionIcon: true,
        onMenuActionTap: () {},
      ),
      backgroundColor: secondaryColor(context),
      body: Background(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FutureBuilder(
              future: context.read<StudyBuddyServices>().getFlashCardDetails(
                widget.flashCards[cardNo],
              ),
              builder: (context, asyncSnapshot) {
                if (asyncSnapshot.hasData) {
                  final card = asyncSnapshot.data!;

                  return FlipCard(
                    controller: flipController,
                    speed: 1000,
                    onFlip: () async {
                      if (revealed == true) {
                        setState(() {
                          revealed = !revealed;
                        });
                      } else {
                        Future.delayed(Duration(milliseconds: 800), () {
                          setState(() {
                            revealed = !revealed;
                          });
                        });
                      }
                    },
                    front: Stack(
                      children: [
                        SizedBox(
                          height: 300,
                          width: double.maxFinite,
                          child: Card(
                            elevation: 10,
                            surfaceTintColor: Colors.white,
                            shadowColor: elevationColor(context),
                            margin: EdgeInsets.symmetric(vertical: 10),
                            color: secondaryColor(context),
                            child: SizedBox(
                              width: 200,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0,
                                  vertical: 80,
                                ),
                                child: Text(
                                  card.question,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium!
                                      .apply(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            onPressed: () async {
                              await context
                                  .read<StudyBuddyServices>()
                                  .bookmarkCard(card);
                              setState(() {});
                            },
                            icon: SvgPicture.asset(
                              'assets/icons/bookmark.svg',
                              colorFilter: ColorFilter.mode(
                                card.isBookMarked == true
                                    ? Colors.white
                                    : Colors.black45,
                                BlendMode.srcIn,
                              ),
                              height: 80,
                            ),
                          ),
                        ),
                      ],
                    ),
                    back: Stack(
                      children: [
                        SizedBox(
                          height: 300,
                          width: double.maxFinite,
                          child: Card(
                            elevation: 4,
                            surfaceTintColor: Colors.white,
                            shadowColor: elevationColor(context),
                            margin: EdgeInsets.symmetric(vertical: 10),
                            color: secondaryColor(context),

                            child: SizedBox(
                              width: 200,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0,
                                  vertical: 80,
                                ),
                                child: Text(
                                  card.answer,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium!
                                      .apply(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            onPressed: () async {
                              await context
                                  .read<StudyBuddyServices>()
                                  .bookmarkCard(card);
                              setState(() {});
                            },
                            icon: SvgPicture.asset(
                              'assets/icons/bookmark.svg',
                              colorFilter: ColorFilter.mode(
                                card.isBookMarked == true
                                    ? Colors.white
                                    : Colors.black45,
                                BlendMode.srcIn,
                              ),
                              height: 80,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (asyncSnapshot.hasError) {
                  throw (asyncSnapshot.error!);
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),

            if (revealed) ...{
              Padding(
                padding: EdgeInsetsGeometry.all(8),
                child: Text(
                  'How close were you?',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              Container(
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: unselectedTileColor(context).withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(12),
                ),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10,
                  children: [
                    AppElevatedButton(
                      onPressed: () {},
                      label: 'No Clue',
                      backgroundColor: incorrrectColor(context),
                      labelStyle: Theme.of(context).textTheme.headlineSmall,
                    ),
                    AppElevatedButton(
                      onPressed: () {},
                      label: 'Almost ',
                      backgroundColor: Colors.amberAccent.shade400,
                      labelStyle: Theme.of(context).textTheme.headlineSmall,
                    ),
                    AppElevatedButton(
                      onPressed: () {},
                      label: 'Got It',
                      backgroundColor: correctColor(context),
                      labelStyle: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
              ),
            },
            Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(12),
                backgroundColor: secondaryColor(context),
              ),
              onPressed: () async {
                setState(() {
                  speaking = !speaking;
                });
              },
              child: Icon(
                speaking ? Icons.play_arrow_rounded : Icons.volume_up_rounded,
                color: Colors.white,
                size: 30,
              ),
            ),
            Spacer(),
            Row(
              spacing: 10,
              children: [
                cardNo == 0
                    ? SizedBox()
                    : Container(
                        decoration: BoxDecoration(
                          color: secondaryColor(context),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                          onPressed: () {
                            context.read<StudyBuddyServices>().prevQuestion();
                          },
                        ),
                      ),
                Expanded(
                  child: AppElevatedButton(
                    onPressed: () {
                      if (revealed) {
                        flipController.toggleCardWithoutAnimation();
                      }
                      context.read<StudyBuddyServices>().nextQuestion();
                    },
                    label: 'Next',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
