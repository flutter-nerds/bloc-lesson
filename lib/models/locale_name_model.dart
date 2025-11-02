import 'package:bloc_lesson/exceptions/app_exception.dart';

class LocaleNameModel {
  final String common;
  final String official;

  LocaleNameModel({required this.common, required this.official});

  factory LocaleNameModel.fromJson(Map<String, dynamic> map) {
    try {
      return LocaleNameModel(common: map['common'], official: map['official']);
    } catch (e) {
      throw ParseException(message: 'error on parsing LocaleNameModel');
    }
  }
}
