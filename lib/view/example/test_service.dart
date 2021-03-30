



import 'package:flutter/material.dart';
import 'package:flutter_app_fac/service/PlaceServices.dart';
import 'package:provider/provider.dart';

class TestService extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TestServiceState ();
  }

}

class TestServiceState extends State<TestService> {
  String _text = "";
  @override
  Widget build(BuildContext context) {
    return
        Scaffold(
          body: Column(
            children: [
              Text(_text),
              TextButton(onPressed: () {
                var places = Provider.of<PlaceServices>(context,listen: false).getAll();
                print("places");
                print(places);
                if(places != null) {
                  setState() {
                    _text = places.toString();
                  }
                }
                  else {
                    setState() {
                      _text = "pas de données";
                    }

                }

              },

                  child: Text("test"))
            ],
          ),
        );
  }


}

