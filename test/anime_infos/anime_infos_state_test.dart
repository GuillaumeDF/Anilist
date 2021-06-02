// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';

import 'package:ani_list/logic/cubit/cubit.dart';

void main() {
  group('AnimeInfosState', () {
    group('AnimeInfosState Initial', () {
      test('supports value comparisons', () {
        expect(AnimeInfosInitial(), AnimeInfosInitial());
      });
    });

    group('AnimeInfos In Progress', () {
      test('supports value comparisons', () {
        expect(AnimeInfosLoading(), AnimeInfosLoading());
      });
    });

    group('AnimeInfos Success', () {
      test('supports value comparisons', () {
        expect(AnimeInfosSuccess(), AnimeInfosSuccess());
      });
    });
    group('AnimeInfos Error', () {
      test('supports value comparisons', () {
        expect(AnimeInfosError(), AnimeInfosError());
      });
    });
  });
}
