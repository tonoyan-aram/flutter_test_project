import 'package:json_annotation/json_annotation.dart';
import 'package:test_project/api/models/auth/token/token_model.dart';
import 'package:test_project/api/models/auth/user/user_model.dart';

part 'logged_model.g.dart';

@JsonSerializable()
class LoggedModel {
  TokenModel tokens;
  UserModel user;

  LoggedModel({
    required this.tokens,
    required this.user,
  });

  factory LoggedModel.fromJson(Map<String, dynamic> data) =>
      _$LoggedModelFromJson(data);

  Map<String, dynamic> toJson() => _$LoggedModelToJson(this);
}
