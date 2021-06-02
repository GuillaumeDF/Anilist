// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';

import 'package:ani_list/logic/cubit/cubit.dart';

void main() {
  group('TopState', () {
    group('TopState Initial', () {
      test('supports value comparisons', () {
        expect(TopInitial(), TopInitial());
      });
    });

    group('Top In Progress', () {
      test('supports value comparisons', () {
        expect(TopLoading(), TopLoading());
      });
    });

    group('Top Success', () {
      test('supports value comparisons', () {
        expect(TopSuccess(), TopSuccess());
      });
    });
    group('Top Error', () {
      test('supports value comparisons', () {
        expect(TopError(), TopError());
      });
    });
  });
}
