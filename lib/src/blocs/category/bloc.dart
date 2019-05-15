import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:milestone/src/blocs/category/event.dart';
import 'package:milestone/src/blocs/category/state.dart';
import 'package:milestone/src/models/category.dart';
import 'package:milestone/src/resources/api.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final ApiProvider _apiProvider = ApiProvider();

  void getCategories() {
    dispatch(GetCategories());
  }

  @override
  CategoryState get initialState => CategoryState.initial();

  @override
  Stream<CategoryState> mapEventToState(
    CategoryEvent event,
  ) async* {
    if (event is GetCategories) {
      yield currentState.copyWith(loading: true);

      try {
        final response = await _apiProvider.getCategories();

        if (response.body != null) {
          final results = json.decode(response.body);
          List categories = results['categories'];

          if (categories.isNotEmpty) {
            yield currentState.copyWith(
              loaded: true,
              loading: false,
              categories: Category.fromList(categories),
            );
          }
        }
      } catch (e) {
        yield currentState.copyWith(
          loaded: true,
          loading: false,
          error: {"error": "Error, Something bad happened."},
        );
      }
    }
  }
}
