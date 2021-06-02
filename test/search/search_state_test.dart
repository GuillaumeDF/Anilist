// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';

import 'package:ani_list/logic/cubit/cubit.dart';

void main() {
  group('SearchState', () {
    group('SearchState Initial', () {
      test('supports value comparisons', () {
        expect(SearchInitial(), SearchInitial());
      });
    });

    group('Search In Progress', () {
      test('supports value comparisons', () {
        expect(SearchLoading(), SearchLoading());
      });
    });

    group('Search Success', () {
      test('supports value comparisons', () {
        expect(SearchSuccess(), SearchSuccess());
      });
    });
    group('Search Error', () {
      test('supports value comparisons', () {
        expect(SearchError(), SearchError());
      });
    });
  });
}
