import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpDialouge extends StatelessWidget {
  const HelpDialouge({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.amberAccent,
        borderRadius: BorderRadius.circular(20),
        child: SizedBox(
          width: 300,
          height: 350,

          child: Column(
            children: [
              Text(
                'Help',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              ListTile(
                onTap: () async {
                  final Uri launchUri = Uri(
                    scheme: 'mailto',
                    path: 'example@example.com',
                  );

                  await launchUrl(launchUri);
                },
                splashColor: Colors.white,
                leading: Icon(Icons.mail),
                title: Text('Email'),
                subtitle: Text('Send us an email'),
                shape: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              ListTile(
                onTap: () async {
                  final Uri launchUri = Uri(scheme: 'tel', path: '03068422727');

                  await launchUrl(launchUri);
                },
                splashColor: Colors.white,
                leading: Icon(Icons.phone),
                title: Text('Phone'),
                subtitle: Text('Call our helpline'),
                shape: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              ListTile(
                onTap: () async {
                  await launchUrl(
                    Uri.parse('https://anifast.site'),
                    mode: LaunchMode.externalApplication,
                  );
                },
                splashColor: Colors.white,
                leading: Icon(CupertinoIcons.globe),
                title: Text('Website'),
                subtitle: Text('Visit our website'),
                shape: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Close', style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
