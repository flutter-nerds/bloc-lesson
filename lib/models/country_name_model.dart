import 'package:bloc_lesson/exceptions/app_exception.dart';
import 'package:bloc_lesson/models/country_native_name.dart';

class CountryNameModel {
  final String common;
  final String official;
  final CountryNativeNameModel nativeName;

  CountryNameModel({
    required this.common,
    required this.official,
    required this.nativeName,
  });

  factory CountryNameModel.fromJson(Map<String, dynamic> map) {
    try
   { return CountryNameModel(
      common: map['common'],
      official: map['official'],
      nativeName: CountryNativeNameModel.fromJson(map['nativeName']),
    );}
    catch(_){
      throw ParseException(message: 'error on parsing CountryNameModel');
    }
  }
}
