import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:isar/isar.dart';

part 'notice_model.g.dart';

@collection
@JsonSerializable()
class Notice {
  Notice(this.text);

  factory Notice.fromJson(Map<String, dynamic> json) => _$NoticeFromJson(json);

  Id id = Isar.autoIncrement;
  String text = '';
  bool isDone = false;

  Map<String, dynamic> toJson() => _$NoticeToJson(this);

  void setId(int id) {
    this.id = id;
  }
}
