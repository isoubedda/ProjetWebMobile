

class EntryPoint {
//  static String url = "http:/0.0.0.0/";
//   static String url = "http://mobile-server.armion.space:8085/";
//   String urlPlace;
//   String urlUser;
//   String urlImage;
//   EntryPoint() {
//     urlPlace = url+"places";
//     urlUser = url+"users";
//     urlImage = url+"images";
//   }
  List<Resources> resources;

  EntryPoint({this.resources});

  String getUrl(String name){
    switch(name) { 
      case "places": { resources.forEach((e) {if(e.name == name) return e.url; }); } 
      break; 
     
      case "users": { resources.forEach((e) {if(e.name == name) return e.url; }); } 
      break; 
     
      case "images": { resources.forEach((e) {if(e.name == name) return e.url; }); } 
      break; 
     
      case "tags": { resources.forEach((e) {if(e.name == name) return e.url; }); } 
      break; 
     
      default: { print("Invalid choice"); } 
      break; 
   } 

  }

  EntryPoint.fromJson(Map<String, dynamic> json) {
    if (json['resources'] != null) {
      resources = new List<Resources>();
      json['resources'].forEach((v) {
        resources.add(new Resources.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.resources != null) {
      data['resources'] = this.resources.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Resources {
  String name;
  String path;
  int port;
  String scheme;
  String hostname;
  String url;

  Resources(
      {this.name, this.path, this.port, this.scheme, this.hostname, this.url});

  Resources.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    path = json['path'];
    port = json['port'];
    scheme = json['scheme'];
    hostname = json['hostname'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['path'] = this.path;
    data['port'] = this.port;
    data['scheme'] = this.scheme;
    data['hostname'] = this.hostname;
    data['url'] = this.url;
    return data;
  }
}