part of 'country_bloc_bloc.dart';

@immutable
sealed class CountryBlocState {}

final class CountryBlocInitial extends CountryBlocState {}

final class CountryBlocLoading extends CountryBlocState{}

final class CountryBlocLoaded extends CountryBlocState{
  final List<CountryModel> countries;

  CountryBlocLoaded({required this.countries});
}

final class CountryBlocError extends CountryBlocState{
  final String? message;

  CountryBlocError({required this.message});
}
