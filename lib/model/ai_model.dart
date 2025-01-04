import 'dart:typed_data';

class AImodel {
  bool? isUser;
  String? text;
  List<Uint8List>? images;

  AImodel({this.isUser, this.text, this.images});

  AImodel.fromJson(Map<String, dynamic> json) {
    isUser = json['isUser'];
    text = json['text'];
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isUser'] = isUser;
    data['text'] = text;
    data['images'] = images;
    return data;
  }
}
