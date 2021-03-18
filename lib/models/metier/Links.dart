

class Links {
  String href;

  Links(this.href);

  Links.fromJson(Map<String, dynamic> document) :
        href = document['href'];

}
