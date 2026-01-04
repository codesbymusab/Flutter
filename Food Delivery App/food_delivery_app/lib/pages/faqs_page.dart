import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants/colors.dart';
import 'package:food_delivery_app/constants/faqs_sample.dart';

class FaqsPage extends StatelessWidget {
  const FaqsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: Text(
          'FoodVille Faqs',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_rounded),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: AlignmentDirectional.topCenter,
            end: Alignment.bottomRight,
            colors: [Colors.white, backgroundColor],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: faqs.length,
            itemBuilder: (context, index1) {
              String faqKey = faqs.keys.toList()[index1];
              return Padding(
                padding: const EdgeInsetsGeometry.all(8.0),
                child: ExpansionTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(12),
                  ),
                  backgroundColor: Colors.amberAccent,
                  tilePadding: EdgeInsets.all(12),
                  childrenPadding: EdgeInsets.all(12),
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  title: Text(
                    faqKey,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  children: [
                    for (int i = 0; i < faqs[faqKey]!.length; i++) ...{
                      Text(
                        faqs[faqKey]!.keys.toList()[i],
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Padding(
                        padding: EdgeInsetsGeometry.all(8),
                        child: Text(
                          faqs[faqKey]!.values.toList()[i],
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                    },
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
