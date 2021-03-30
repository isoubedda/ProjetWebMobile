import 'package:hive/hive.dart';

part 'Resources.g.dart';

@HiveType(typeId: 5)
class Resources {
  @HiveField(0)
  String name;
  @HiveField(1)
  String path;
  @HiveField(2)
  int port;
  @HiveField(3)
  String scheme;
  @HiveField(4)
  String hostname;
  @HiveField(5)
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

  @override
  String toString() {
    return 'Resources{name: $name, path: $path, port: $port, scheme: $scheme, hostname: $hostname, url: $url}';
  }
}