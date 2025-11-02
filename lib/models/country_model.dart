import 'package:bloc_lesson/exceptions/app_exception.dart';
import 'package:bloc_lesson/models/country_name_model.dart';

class CountryModel {
  final CountryNameModel name;
  final List<String> capital;
  final String region;

  CountryModel({
    required this.name,
    required this.capital,
    required this.region,
  });

  factory CountryModel.fromJson(Map<String, dynamic> map) {
    try {
      return CountryModel(
        name: CountryNameModel.fromJson(map['name']),
        capital: (map['capital'] as List<dynamic>)
            .map((e) => e.toString())
            .toList(),
        region: map['region'],
      );
    } catch (e) {
      throw ParseException(message: 'error on parsing CountryModel');
    }
  }
}
