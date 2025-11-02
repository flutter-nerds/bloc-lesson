import 'package:bloc_lesson/blocs/country_bloc/country_bloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CountryBlocBloc(),
      child: HomePageContent(),
    );
  }
}

class HomePageContent extends StatefulWidget {
  const HomePageContent({super.key});

  @override
  State<HomePageContent> createState() => _HomePageState();
}

class _HomePageState extends State<HomePageContent> {
  final searchContoller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bloc lesson'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextField(
              controller: searchContoller,
              decoration: InputDecoration(
                suffixIcon: ValueListenableBuilder(
                  valueListenable: searchContoller,
                  builder: (context, value, child) {
                    return IconButton(
                      onPressed: value.text.isEmpty
                          ? null
                          : () {
                              context.read<CountryBlocBloc>().add(
                                SearchCountryEvent(searchText: value.text.toLowerCase()),
                              );
                            },
                      icon: Icon(Icons.send),
                    );
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(width: 1),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocBuilder<CountryBlocBloc, CountryBlocState>(
          builder: (context, state) {
            //if the state is CountryBlocLoading we are show a CircularProgressIndicator
            if (state is CountryBlocLoading) {
              return Center(child: CircularProgressIndicator());

              //if state is CountryBlocError show a Text with error
            } else if (state is CountryBlocError) {
              return Center(child: Text(state.message ?? 'error'));

              //if state is CountryBlocLoaded show a list of countries
            } else if (state is CountryBlocLoaded) {
              final countries = state.countries;


              
              return ListView.builder(
                itemCount: countries.length,
                itemBuilder: (context, index) {
                  final country = countries[index];
                  final nativeNames = country.name.nativeName.data.entries.map((e){
                          return Text('${e.key} ${e.value.official}');
                        }).toList();
                  return ListTile(
                    title: Text(country.name.official),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Capital: ${country.capital.first}"),
                        Text('Region: ${country.region}'),
                        ...nativeNames
                      ],
                    ),
                  );
                },
              );

              //last state that we didn't handle it is a initial. Therefore just show a simple text
            } else {
              return Text('Initial state');
            }
          },
        ),
      ),
    );
  }
}
