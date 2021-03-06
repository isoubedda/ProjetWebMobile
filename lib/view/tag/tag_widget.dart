import 'package:flutter/material.dart';
import 'package:flutter_app_fac/models/metier/TagList.dart';
import 'package:flutter_app_fac/models/metier/TagModel.dart';
import 'package:provider/provider.dart';

class SelectOrCreateTagWidget extends StatefulWidget {
  var model;

  SelectOrCreateTagWidget(this.model,);

  @override
  _SelectOrCreateTagWidgetState createState() => _SelectOrCreateTagWidgetState();
}
class _SelectOrCreateTagWidgetState extends State<SelectOrCreateTagWidget> {
  final  keyForm = new GlobalKey<FormState>();
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
    return Form(
        key: keyForm,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: mediaQuery.size.height * 0.35,
                  child: TextField(
                    controller: _textController,
                    decoration:  new InputDecoration(


                    focusColor: Colors.red,
                    labelText: "nom du tag",
                    labelStyle: TextStyle(
                        color: Colors.black
                    ),
                    alignLabelWithHint: true,
                  ),
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
                IconButton(icon: Icon(Icons.add), onPressed: () {submit();})
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
                    padding: EdgeInsets.only(top: 10),
                    itemCount: filteredList.length,
                    itemBuilder: (BuildContext context, index) {
                      return InkWell(
                        onTap: () {widget.model.addTag(filteredList[index]);},
                        child: Container(
                          height: 30,
                          child: Align(alignment : AlignmentDirectional.centerStart,child: Text(filteredList[index].name)),
                        ),
                      );
                    }),
              ),
          ],
        ));
  }

  bool saveAndValidate () {
    final form = keyForm.currentState;
    if(form.validate()){
      form.save();
      return true;
    }
    return false;
  }

  void submit () {
    if(saveAndValidate()){
      var tag = new Tag(name : _textController.text);
      Provider.of<TagList>(context, listen: false).tags.add(tag);
      widget.model.addTag(tag);
      _textController.clear();
    }
  }

}