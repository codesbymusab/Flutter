import 'package:calculator_app/gloabal_variables.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: history.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.history,
                    color: const Color.fromARGB(255, 211, 223, 228),
                    size: 30,
                  ),
                  Text(
                    'No History',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 211, 223, 228),
                      fontSize: 35,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: history.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        buttonController.text = history.keys.toList()[index];
                      });
                    },
                    child: Column(
                      spacing: 3,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      textDirection: TextDirection.rtl,
                      children: [
                        Text(
                          history.keys.toList()[index],
                          textAlign: TextAlign.right,
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        Text(
                          history.values.toList()[index],
                          textAlign: TextAlign.right,
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
