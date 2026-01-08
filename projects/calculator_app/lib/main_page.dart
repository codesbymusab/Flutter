import 'package:calculator_app/gloabal_variables.dart';
import 'package:calculator_app/history.dart';
import 'package:flutter/material.dart';
import 'package:math_parser/math_parser.dart';
import 'package:url_launcher/url_launcher.dart';

num calculateExpression(String expression) {
  return MathNodeExpression.fromString(
    expression,
  ).calc(MathVariableValues.none);
}

String expressionParser(String expression) {
  expression = expression.replaceAll('×', '*');
  expression = expression.replaceAll('÷', '/');
  expression = expression.replaceAll('%', '/100');

  return expression;
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static const buttonsText = [
    {'(': 'surface', ')': 'surface', '^': 'surface', '!': 'surface'},
    {'AC': 'purple', '%': 'grey', 'π': 'grey', '÷': 'grey'},
    {'7': 'black', '8': 'black', '9': 'black', '×': 'grey'},
    {'4': 'black', '5': 'black', '6': 'black', '-': 'grey'},
    {'1': 'black', '2': 'black', '3': 'black', '+': 'grey'},
    {'0': 'black', '.': 'black', '<×': 'black', '=': 'blue'},
  ];
  static const buttonColors = {
    'black': Color.fromARGB(155, 49, 49, 49),
    'grey': Color.fromARGB(155, 38, 54, 78),
    'purple': Color.fromARGB(155, 71, 20, 89),
    'blue': Color.fromARGB(155, 63, 82, 201),
    'surface': Color.fromARGB(28, 8, 8, 8),
  };
  double textFieldHeight = 200.0;
  double buttonRadius = 42.0;
  String currentResult = '';
  bool showHistory = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: showHistory
          ? AppBar(
              leadingWidth: 25,
              backgroundColor: Theme.of(context).colorScheme.primary,
              title: Text(
                'History',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              leading: IconButton(
                onPressed: () {
                  setState(() {
                    showHistory = false;
                  });
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    showMenu(
                      position: RelativeRect.fromDirectional(
                        textDirection: TextDirection.ltr,
                        start: double.infinity,
                        end: double.infinity,
                        top: 30,
                        bottom: double.infinity,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(30),
                      ),
                      menuPadding: EdgeInsets.all(8),
                      color: const Color.fromARGB(255, 94, 85, 119),
                      context: context,
                      items: [
                        PopupMenuItem(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  backgroundColor: Theme.of(
                                    context,
                                  ).colorScheme.primary,
                                  title: Text(
                                    'Clear history and memory?',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.displaySmall,
                                  ),

                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        'Dismiss',
                                        style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          Navigator.pop(context);
                                          history.clear();
                                        });
                                      },
                                      child: Text(
                                        'Clear',
                                        style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Text(
                            'Clear History',
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ),
                      ],
                    );
                  },
                  icon: Icon(
                    Icons.more_vert,
                    color: Theme.of(context).colorScheme.tertiary,
                    size: 30,
                  ),
                ),
              ],
            )
          : null,
      body: Flexible(
        child: SingleChildScrollView(
          physics: showHistory
              ? AlwaysScrollableScrollPhysics()
              : NeverScrollableScrollPhysics(),

          child: Column(
            children: [
              if (showHistory) ...{SizedBox(height: 400, child: HistoryPage())},
              SizedBox(
                height: textFieldHeight,
                child: Stack(
                  children: [
                    GestureDetector(
                      onDoubleTap: () {
                        setState(() {
                          buttonController.text = '';
                          currentResult = '';
                        });
                      },
                      child: TextField(
                        showCursor: true,
                        readOnly: true,
                        controller: buttonController,
                        cursorColor: Colors.lightBlue,
                        maxLines: null,
                        textAlign: TextAlign.right,
                        textAlignVertical: TextAlignVertical.center,
                        expands: true,
                        enabled: true,
                        autofocus: true,
                        keyboardAppearance: Brightness.dark,
                        keyboardType: TextInputType.number,
                        style: size.width > 500
                            ? Theme.of(context).textTheme.displayLarge
                            : Theme.of(context).textTheme.displayMedium,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(30),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(30),
                            ),
                          ),
                          filled: true,
                          fillColor: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Align(
                        alignment: AlignmentDirectional.bottomEnd,
                        child: Text(
                          currentResult,
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional.topEnd,
                      child: IconButton(
                        onPressed: () {
                          showMenu(
                            position: RelativeRect.fromDirectional(
                              textDirection: TextDirection.ltr,
                              start: double.infinity,
                              end: double.infinity,
                              top: 30,
                              bottom: double.infinity,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(20),
                            ),
                            menuPadding: EdgeInsets.all(8),
                            color: const Color.fromARGB(255, 94, 85, 119),
                            context: context,
                            items: [
                              PopupMenuItem(
                                onTap: () {
                                  setState(() {
                                    showHistory = true;
                                  });
                                },
                                child: Text(
                                  'History',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.displaySmall,
                                ),
                              ),
                              PopupMenuItem(
                                onTap: () async {
                                  await launchUrl(
                                    Uri.parse(
                                      'https://policies.google.com/privacy?hl=en',
                                    ),
                                    mode: LaunchMode.platformDefault,
                                  );
                                },
                                child: Text(
                                  'Privacy policy',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.displaySmall,
                                ),
                              ),
                              PopupMenuItem(
                                onTap: () async {
                                  await launchUrl(
                                    Uri.parse(
                                      'https://www.google.com/tools/feedback/reports?hl=en',
                                    ),
                                    mode: LaunchMode.platformDefault,
                                  );
                                },
                                child: Text(
                                  'Send Feedback',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.displaySmall,
                                ),
                              ),
                              PopupMenuItem(
                                onTap: () async {
                                  await launchUrl(
                                    Uri.parse(
                                      'https://support.google.com/android#topic=7313011',
                                    ),
                                    mode: LaunchMode.platformDefault,
                                  );
                                },
                                child: Text(
                                  'Help',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.displaySmall,
                                ),
                              ),
                            ],
                          );
                        },
                        icon: Icon(Icons.menu),
                        color: const Color.fromARGB(255, 211, 223, 228),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional.bottomCenter,
                      child: GestureDetector(
                        onVerticalDragDown: (details) {
                          setState(() {
                            showHistory = true;
                          });
                        },

                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.remove),
                          color: const Color.fromARGB(255, 211, 223, 228),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  for (int i = 0; i < 6; i++) ...{
                    TextFieldTapRegion(
                      child: Padding(
                        padding: size.width > 500
                            ? EdgeInsetsGeometry.symmetric(
                                horizontal: size.width / 8,
                              )
                            : EdgeInsets.all(0),
                        child: Row(
                          children: [
                            for (int j = 0; j < 4; j++) ...{
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: buttonsText[i].keys.toList()[j] == '<×'
                                      ? IconButton(
                                          onPressed: () {
                                            int length =
                                                buttonController.text.length;
                                            setState(() {
                                              if (length >= 1) {
                                                buttonController
                                                    .text = buttonController
                                                    .text
                                                    .substring(0, length - 1);
                                              }
                                              currentResult = '';
                                            });
                                          },
                                          icon: Icon(
                                            Icons.backspace,
                                            color: const Color.fromARGB(
                                              255,
                                              211,
                                              223,
                                              228,
                                            ),
                                            size: 50,
                                          ),
                                          style: IconButton.styleFrom(
                                            padding: EdgeInsets.all(17),
                                            backgroundColor:
                                                buttonColors['black'],
                                            overlayColor: Colors.blueGrey,
                                          ),
                                        )
                                      : TextButton(
                                          style: TextButton.styleFrom(
                                            backgroundColor:
                                                buttonColors[buttonsText[i]
                                                    .values
                                                    .toList()[j]],
                                            fixedSize: Size.fromRadius(
                                              buttonRadius,
                                            ),
                                            overlayColor: Colors.blueGrey,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              final buttonText = buttonsText[i]
                                                  .keys
                                                  .toList()[j];
                                              if (buttonText == '=') {
                                                if (buttonController
                                                    .text
                                                    .isNotEmpty) {
                                                  try {
                                                    String expression =
                                                        buttonController.text;
                                                    expression =
                                                        expressionParser(
                                                          expression,
                                                        );

                                                    final result =
                                                        calculateExpression(
                                                          expression,
                                                        ).toString();
                                                    history[buttonController
                                                            .text] =
                                                        result;
                                                    buttonController.text =
                                                        result;
                                                  } catch (e) {
                                                    buttonController.text =
                                                        'Invalid format';
                                                  } finally {
                                                    currentResult = '';
                                                  }
                                                }
                                              } else if (buttonText == 'AC') {
                                                buttonController.clear();
                                                currentResult = '';
                                              } else {
                                                buttonController.text +=
                                                    buttonText;

                                                try {
                                                  final currentExpression =
                                                      expressionParser(
                                                        buttonController.text,
                                                      );
                                                  currentResult =
                                                      calculateExpression(
                                                        currentExpression,
                                                      ).toString();
                                                } catch (e) {
                                                  currentResult = '';
                                                }
                                              }
                                            });
                                          },
                                          child: Text(
                                            buttonsText[i].keys.toList()[j],
                                            style: Theme.of(
                                              context,
                                            ).textTheme.displayMedium,
                                          ),
                                        ),
                                ),
                              ),
                            },
                          ],
                        ),
                      ),
                    ),
                  },
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
