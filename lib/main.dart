import 'package:flutter/material.dart';
//For make icon package.
import 'package:flutter_launcher_icons/android.dart';
import 'package:flutter_launcher_icons/constants.dart';
import 'package:flutter_launcher_icons/custom_exceptions.dart';
import 'package:flutter_launcher_icons/ios.dart';
import 'package:flutter_launcher_icons/main.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
//For url_launcher Package.
import 'package:url_launcher/url_launcher.dart';
//For use NoSQL Database package.
import 'package:shared_preferences/shared_preferences.dart'; // 追記する


//constitution
//main->Myapp->AppMain->_AppMainState
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'm2memo',
      theme: ThemeData(
      ),
      home: AppMain(title: 'm2memo'),
    );
  }
}

class AppMain extends StatefulWidget{

  AppMain({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AppMainState createState() => _AppMainState();
}

class _AppMainState extends State<AppMain> {

  @override
  //All drawings on the screen will be displayed exactly as written here.
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Visibility(
          visible: isLoaded,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text(''),//Blank lines are represented by Text('').
                Text(''),
                Text('m2memo'),
                Text(''),
                //The only TextField in this app
                TextField(
                    controller: memoController,
                    onChanged: (text) {
                      save('memo', text);
                    },
                    minLines: 25,
                    maxLines: 25,
                    maxLength: 5000,
                    maxLengthEnforced: true,
                    decoration: InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(),
                      hintText: 'Memo',
                    )),
                Text(''),
                //Link
                RaisedButton(
                  onPressed: _launchURL,
                  child: Text('ABOUT'),
                ),
              ],
            ),
          ),
        ));
  }

  //These code is not need after widget.
  //No problem even before the widget.
  //However, do not write it outside of _AppMainState~{}.
  //Prepare for link. https://pub.dev/packages/link
  _launchURL() async {
    const url = 'https://9vox2.netlify.com/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
    throw 'Could not launch $url';
    }
  }

  //Prepare for use NoSQL, this code make controller.
  final memoController = TextEditingController();
  var isLoaded = false;
  
  //Prepare for load().
  //There is no problem if there are multiple @overrude.
  @override
  void initState() {
    super.initState();
    load();
  }

  //load function
  Future<void> load() async {
    final prefs1 = await SharedPreferences.getInstance();
    memoController.text = prefs1.getString('memo');
    setState(() {
      isLoaded = true;
    });
  }

  //save function
  Future<void> save(key, text) async {
    final prefs2 = await SharedPreferences.getInstance();
    await prefs2.setString(key, text);
    setState(() {
      isLoaded = true;
    });
  }
}