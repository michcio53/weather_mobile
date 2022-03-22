import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_mobile/app/dimen.dart';
import 'package:weather_mobile/screens/search/bloc/search_bloc.dart';
import 'package:weather_mobile/screens/search/widget/search_body_failure.dart';
import 'package:weather_mobile/screens/search/widget/search_body_loading.dart';
import 'package:weather_mobile/screens/search/widget/search_body_success.dart';
import 'package:weather_mobile/screens/search/widget/serach_body_initial.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  static const String routeName = '/search';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: const [
            SizedBox(
              height: Insets.medium,
            ),
            SearchPageInput(),
            Expanded(
              child: SearchPageBody(),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchPageInput extends StatelessWidget {
  const SearchPageInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) => context.read<SearchBloc>()..add(SearchTyped(query: value)),
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.teal),
        ),
      ),
    );
  }
}

class SearchPageBody extends StatelessWidget {
  const SearchPageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchInitial) {
          return const SearchBodyInitial();
        } else if (state is SearchLoading) {
          return const SearchBodyLoading();
        } else if (state is SearchSuccess) {
          return SearchBodySuccess(locations: state.locations);
        } else if (state is SearchFailure) {
          return const SearchBodyFailure();
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
