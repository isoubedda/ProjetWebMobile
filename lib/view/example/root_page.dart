import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uni_links/uni_links.dart';
import 'package:flutter_app_fac/generic_view/simple_icon_button.dart';

import '../../routes.dart';

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Root Page "),
      ),
      body: Row(
        children: [
          SimpleIconButton(icon: Icons.map,onPressed: ()=> {
            toMap(context)
          },),
          SimpleIconButton(icon: Icons.home, onPressed: () => {
            toExemple(context)
          },),
          SimpleIconButton(icon: Icons.location_city, onPressed: () => {
            toLocation(context)
          },),
          SimpleIconButton(icon: Icons.home, onPressed: () => {
            toRegister(context)
          },),
         
        ],
      ),

    );
  }

  void toMap (context) {
    Navigator.pushNamed(context, Routes.maps);
  }

  void toExemple (context) {
    Navigator.pushNamed(context, Routes.exemple);
  }

  void toRegister (context) {
    Navigator.pushNamed(context, Routes.register);
  }

  void toLocation (context) {
    Navigator.pushNamed(context, Routes.location);
  }

}

class MyApp1 extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

enum UniLinksType { string, uri }

class _MyAppState extends State<MyApp1> with SingleTickerProviderStateMixin {
  String _latestLink = 'Unknown';
  Uri _latestUri;

  StreamSubscription _sub;

  TabController _tabController;
  UniLinksType _type = UniLinksType.string;

  final List<String> _cmds = getCmds();
  final TextStyle _cmdStyle = const TextStyle(
      fontFamily: 'Courier', fontSize: 12.0, fontWeight: FontWeight.w700);
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 2);
    _tabController.addListener(_handleTabChange);
    initPlatformState();
  }

  @override
  dispose() {
    if (_sub != null) _sub.cancel();
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }


  initPlatformState() async {
    if (_type == UniLinksType.string) {
      await initPlatformStateForStringUniLinks();
    } else {
      await initPlatformStateForUriUniLinks();
    }
  }


  initPlatformStateForStringUniLinks() async {
    
    _sub = getLinksStream().listen((String link) {
      if (!mounted) return;
      setState(() {
        _latestLink = link ?? 'Unknown';
        _latestUri = null;
        try {
          if (link != null) _latestUri = Uri.parse(link);
        } on FormatException {}
      });
    }, onError: (err) {
      if (!mounted) return;
      setState(() {
        _latestLink = 'Failed to get latest link: $err.';
        _latestUri = null;
      });
    });

  
    getLinksStream().listen((String link) {
    }, onError: (err) {
    });

    String initialLink;
    Uri initialUri;

    try {
      initialLink = await getInitialLink();
      if (initialLink != null) initialUri = Uri.parse(initialLink);
    } on PlatformException {
      initialLink = 'Failed to get initial link.';
      initialUri = null;
    } on FormatException {
      initialLink = 'Failed to parse the initial link as Uri.';
      initialUri = null;
    }


    if (!mounted) return;

    setState(() {
      _latestLink = initialLink;
      _latestUri = initialUri;
    });
  }

  initPlatformStateForUriUniLinks() async {

    _sub = getUriLinksStream().listen((Uri uri) {
      if (!mounted) return;
      setState(() {
        _latestUri = uri;
        _latestLink = uri?.toString() ?? 'Unknown';
      });
    }, onError: (err) {
      if (!mounted) return;
      setState(() {
        _latestUri = null;
        _latestLink = 'Failed to get latest link: $err.';
      });
    });

 
    getUriLinksStream().listen((Uri uri) {
    }, onError: (err) {
    });


    Uri initialUri;
    String initialLink;
    
    try {
      initialUri = await getInitialUri();
      initialLink = initialUri?.toString();
    } on PlatformException {
      initialUri = null;
      initialLink = 'Failed to get initial uri.';
    } on FormatException {
      initialUri = null;
      initialLink = 'Bad parse the initial link as Uri.';
    }


    if (!mounted) return;

    setState(() {
      _latestUri = initialUri;
      _latestLink = initialLink;
    });
  }

  @override
  Widget build(BuildContext context) {
    final queryParams = _latestUri?.queryParametersAll?.entries?.toList();

    return new MaterialApp(
      home: new Scaffold(
        key: _scaffoldKey,
        appBar: new AppBar(
          title: new Text('Plugin example app'),
          bottom: new TabBar(
            controller: _tabController,
            tabs: <Widget>[
              new Tab(text: 'STRING LINK'),
              new Tab(text: 'URI'),
            ],
          ),
        ),
        body: new ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(8.0),
          children: <Widget>[
            new ListTile(
              title: const Text('Link'),
              subtitle: new Text('$_latestLink'),
            ),
            new ListTile(
              title: const Text('Uri Path'),
              subtitle: new Text('${_latestUri?.path}'),
            ),
            new ExpansionTile(
              initiallyExpanded: true,
              title: const Text('Query params'),
              children: queryParams?.map((item) {
                return new ListTile(
                  title: new Text('${item.key}'),
                  trailing: new Text('${item.value?.join(', ')}'),
                );
              })?.toList() ??
                  <Widget>[
                    new ListTile(
                      dense: true,
                      title: const Text('null'),
                    ),
                  ],
            ),
            _cmdsCard(_cmds),
          ],
        ),
      ),
    );
  }

  Widget _cmdsCard(commands) {
    Widget platformCmds;

    if (commands == null) {
      platformCmds = const Center(child: const Text('Unsupported platform'));
    } else {
      platformCmds = new Column(
        children: <List<Widget>>[
          [
            const Text(
                'To populate above fields open a terminal shell and run:\n')
          ],
          intersperse(
              commands.map<Widget>((cmd) => new InkWell(
                onTap: () => _printAndCopy(cmd),
                child: new Text('\n$cmd\n', style: _cmdStyle),
              )),
              const Text('or')),
          [
            new Text(
                '(tap on any of the above commands to print it to'
                    ' the console/logger and copy to the device clipboard.)',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.caption),
          ]
        ].expand((el) => el).toList(),
      );
    }

    return new Card(
      margin: const EdgeInsets.only(top: 20.0),
      child: new Padding(
        padding: const EdgeInsets.all(10.0),
        child: platformCmds,
      ),
    );
  }

  _handleTabChange() {
    if (_tabController.indexIsChanging) {
      setState(() {
        _type = UniLinksType.values[_tabController.index];
      });
      initPlatformState();
    }
  }

  _printAndCopy(String cmd) async {

    await Clipboard.setData(new ClipboardData(text: cmd));
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: const Text('Copied to Clipboard'),
    ));
  }
}

List<String> getCmds() {
  String cmd;
  String cmdSuffix = '';

  if (Platform.isIOS) {
    cmd = '/usr/bin/xcrun simctl openurl booted';
  } else if (Platform.isAndroid) {
    cmd = '\$ANDROID_HOME/platform-tools/adb shell \'am start'
        ' -a android.intent.action.VIEW'
        ' -c android.intent.category.BROWSABLE -d';
    cmdSuffix = "'";
  } else {
    return null;
  }

  // https://orchid-forgery.glitch.me/mobile/redirect/
  return [
    '$cmd "unilinks://host/path/subpath"$cmdSuffix',
    '$cmd "unilinks://example.com/path/portion/?uid=123&token=abc"$cmdSuffix',
    '$cmd "unilinks://example.com/?arr%5b%5d=123&arr%5b%5d=abc'
        '&addr=1%20Nowhere%20Rd&addr=Rand%20City%F0%9F%98%82"$cmdSuffix',
  ];
}

List<Widget> intersperse(Iterable<Widget> list, Widget item) {
  List<Widget> initialValue = [];
  return list.fold(initialValue, (all, el) {
    if (all.length != 0) all.add(item);
    all.add(el);
    return all;
  });
}
