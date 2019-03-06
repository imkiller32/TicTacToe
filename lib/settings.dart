import 'package:flutter/material.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'module.dart';

void main() => runApp(Setting());

class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
      ),
      body: SettingPage(),
    );
  }
}

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  static final MobileAdTargetingInfo targetInfo = MobileAdTargetingInfo(
    testDevices: <String>[],
    keywords: <String>['Game', 'TicTacToe', 'Board'],
    birthday: DateTime.now(),
    childDirected: true,
  );

  bool playWithBot = module.getBot();
  bool enableSound = module.getSound();
  BannerAd _bannerAd;
  BannerAd createBannerAd() {
    return BannerAd(
        adUnitId: BannerAd.testAdUnitId,
        size: AdSize.banner,
        targetingInfo: targetInfo,
        listener: (MobileAdEvent event) {
          print('Banner event $event');
        });
  }

  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
    _bannerAd = createBannerAd()
      ..load()
      ..show();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Options',
                style: TextStyle(fontSize: 16.0, color: Colors.lightBlue),
              ),
              ListTile(
                title: Text('Play with bot'),
                trailing: Switch(
                  value: playWithBot,
                  onChanged: (value) {
                    setState(() {
                      module.setBot(value);
                      playWithBot = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: Text('Enable Sound'),
                trailing: Switch(
                  value: enableSound,
                  onChanged: (value) {
                    setState(() {
                      module.setSound(value);
                      enableSound = value;
                    });
                  },
                ),
              ),
              Divider(
                height: 3.0,
              ),
              Padding(
                padding: EdgeInsets.only(top: 25.0),
              ),
              Text(
                'About',
                style: TextStyle(fontSize: 16.0, color: Colors.lightBlue),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.0),
              ),
              Text('TicTacToe'),
              Text('Version:1.0.0'),
            ],
          ),
        ),
      ),
    );
  }
}
