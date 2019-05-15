import 'package:meta/meta.dart';
import 'package:milestone/src/models/category.dart';

@immutable
class CategoryState {
  final bool loading;
  final bool loaded;
  final Map error;
  final List<Category> categories;

  CategoryState({
    @required this.loading,
    @required this.loaded,
    @required this.error,
    @required this.categories,
  });

  factory CategoryState.initial() {
    return CategoryState(
      loading: false,
      loaded: false,
      error: null,
      categories: List<Category>(),
    );
  }

  CategoryState copyWith({
    bool loading,
    bool loaded,
    Map error,
    List<Category> categories,
  }) {
    return CategoryState(
      loading: loading ?? this.loading,
      loaded: loaded ?? this.loaded,
      error: error ?? this.error,
      categories: categories ?? this.categories,
    );
  }
}
