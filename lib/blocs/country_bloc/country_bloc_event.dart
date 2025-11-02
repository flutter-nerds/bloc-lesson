part of 'country_bloc_bloc.dart';

@immutable
sealed class CountryBlocEvent {}

class SearchCountryEvent extends CountryBlocEvent {
  final String searchText;

  SearchCountryEvent({required this.searchText});
}
