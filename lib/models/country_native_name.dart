import 'package:bloc_lesson/exceptions/app_exception.dart';
import 'package:bloc_lesson/models/locale_name_model.dart';

class CountryNativeNameModel {
  final Map<String, LocaleNameModel> data;

  CountryNativeNameModel({required this.data});

  factory CountryNativeNameModel.fromJson(Map<String, dynamic> map) {
    try {
      //getting a keys from map
      final List<String> keys = map.keys.toList();

      //getting the values of map to list
      final List<dynamic> dynamicValues = map.values.toList();

      //convert List<dynamic> to List<LocaleNameModel>
      final List<LocaleNameModel> values = dynamicValues.map((e) {
        return LocaleNameModel.fromJson(e);
      }).toList();

      return CountryNativeNameModel(data: Map.fromIterables(keys, values));
    } catch (e) {
      throw ParseException(message: 'error on parsing CountryNativeNameModel');
    }
  }
}
