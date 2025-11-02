import 'package:bloc_lesson/exceptions/app_exception.dart';
import 'package:bloc_lesson/models/country_model.dart';
import 'package:bloc_lesson/services/api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'country_bloc_event.dart';
part 'country_bloc_state.dart';

class CountryBlocBloc extends Bloc<CountryBlocEvent, CountryBlocState> {
  CountryBlocBloc() : super(CountryBlocInitial()) {
    on<SearchCountryEvent>(_onSearchCountry);
  }

  final ApiService _apiService = ApiService();

  _onSearchCountry(
    SearchCountryEvent event,
    Emitter<CountryBlocState> emit,
  ) async {
    emit(CountryBlocLoading());

    try {
      final countries = await _apiService.searchCountries(
        searchText: event.searchText,
      );
      emit(CountryBlocLoaded(countries: countries));
    } on AppException catch (e) {
      emit(CountryBlocError(message: e.message));
    } catch (e) {
      emit(CountryBlocError(message: 'unknown'));
    }
  }
}
