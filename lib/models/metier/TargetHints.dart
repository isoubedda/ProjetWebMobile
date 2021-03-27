class TargetHints {
  List<String> _allow;

  TargetHints({List<String> allow}) {
    this._allow = allow;
  }

  List<String> get allow => _allow;
  set allow(List<String> allow) => _allow = allow;

  TargetHints.fromJson(Map<String, dynamic> json) {
    _allow = json['allow'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['allow'] = this._allow;
    return data;
  }
}