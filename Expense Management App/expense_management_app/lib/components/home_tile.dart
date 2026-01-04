import 'package:flutter/material.dart';

class HomeTile extends StatelessWidget {
  final VoidCallback onTap1;
  final String text1;
  final VoidCallback onTap2;
  final String text2;
  const HomeTile({
    super.key,
    required this.onTap1,
    required this.text1,
    required this.onTap2,
    required this.text2,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 100,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.red, Colors.teal]),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: InkResponse(
                onTap: onTap1,
                child: Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    text1,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ),
            ),
            VerticalDivider(color: Colors.orange, indent: 10, endIndent: 10),
            Expanded(
              child: InkResponse(
                onTap: onTap2,
                child: Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    text2,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
