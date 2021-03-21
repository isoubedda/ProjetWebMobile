import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart' as cu;
import 'package:flutter_app_fac/models/metier/TagList.dart';
import 'package:flutter_app_fac/models/metier/TagModel.dart';
import 'package:provider/provider.dart';

class DialogWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new DialogWidgetState();
  }
}

class DialogWidgetState extends State<DialogWidget> {
  bool onFirstPage = false;
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: [
        Container(
          height: 300,
          child : Column(

            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("nouveau"),
                  cu.CupertinoSwitch(
                      activeColor: Colors.blue,
                      trackColor: Colors.blue,
                      value: onFirstPage,
                      onChanged: (bool state) {
                        setState(() {
                          onFirstPage = state;
                        });
                      }),
                  Text("inscription")
                ],
              ),
              Expanded(

                child: PageTransitionSwitcher(
                  duration: const Duration(milliseconds: 1500),
                  reverse: !onFirstPage,
                  transitionBuilder: (Widget child, Animation<double> animation,
                      Animation<double> secondaryAnimation) {
                    return FadeThroughTransition(
                      child: child,
                      animation: animation,
                      secondaryAnimation: secondaryAnimation,
                    );
                  },
                  child: onFirstPage ?Container(color: Colors.blue,) : Container(color : Colors.red),

                ),)
            ],
          ) ,
        )
      ],

    );
  }
}

class TestPage extends StatefulWidget {
  var model;

  TestPage(this.model);

  @override
  _TestPageState createState() => _TestPageState();
}
class _TestPageState extends State<TestPage> {
  TextEditingController _textController = TextEditingController();
  List<Tag> initialList;
  List<Tag> filteredList = [];



  @override
  void initState() {
    initialList = Provider.of<TagList>(context, listen: false).tags;

  }
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Column(
          children: <Widget>[
            Row(
              children: [
                Container(
                  width: mediaQuery.size.height * 0.4,
                  child: TextField(
                    controller: _textController,
                    onChanged: (text) {
                      text = text.toLowerCase();
                      setState(() {
                        filteredList = initialList
                            .where((element) => element.name.toLowerCase().contains(text))
                            .toList();
                      });
                    },
                  ),
                ),
                IconButton(icon: Icon(Icons.add), onPressed: () {})
              ],
            ),
            if (filteredList.length == 0 && _textController.text.isEmpty)
              Expanded(child: Container(),
//                  child: ListView.builder(
//                      itemCount: initialList.length,
//                      itemBuilder: (BuildContext context, index) {
//                        return Container(
//                          height: 0,
//                          child: Text(initialList[index].name),
//                        );
//                      })
              )
            else if (filteredList.length==0 && _textController.text.isNotEmpty)
              Container()
            else
              Expanded(
                child: ListView.builder(
                    padding: cu.EdgeInsets.only(top: 10),
                    itemCount: filteredList.length,
                    itemBuilder: (BuildContext context, index) {
                      return InkWell(
                        onTap: () {print("add");widget.model.addTag(filteredList[index]);},
                        child: Container(
                          height: 30,
                          child: Align(alignment : AlignmentDirectional.centerStart,child: Text(filteredList[index].name)),
                        ),
                      );
                    }),
              ),
          ],
        );
  }
}