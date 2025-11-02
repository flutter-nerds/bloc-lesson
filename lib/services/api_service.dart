import 'package:bloc_lesson/exceptions/app_exception.dart';
import 'package:bloc_lesson/models/country_model.dart';
import 'package:dio/dio.dart';

class ApiService {
  final Dio dio = Dio();

  Future<List<CountryModel>> searchCountries({
    required String searchText,
  }) async {
    try {

      //we are sending request to the url
      final response = await dio.get(
        'https://restcountries.com/v3.1/name/$searchText',
      );

      //getting body as a list of dynamic
      final body = response.data as List;

      //mapping the dynamic list to CountryModel and returning
      return body.map((e) => CountryModel.fromJson(e)).toList();
    //hanlding the dio exception
    } on DioException catch (e) {
      throw ApiException(
        statusCode: e.response?.statusCode,
        message: e.message,
      );

    //handling the other exceptions
    } catch (e) {
      throw UnknownException();
    }
  }
}
