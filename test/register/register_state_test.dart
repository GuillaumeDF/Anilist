// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';

import 'package:ani_list/logic/cubit/cubit.dart';

void main() {
  group('RegisterState', () {
    group('RegisterState Initial', () {
      test('supports value comparisons', () {
        expect(RegisterInitial(), RegisterInitial());
      });
    });

    group('Register In Progress', () {
      test('supports value comparisons', () {
        expect(RegisterInProgress(), RegisterInProgress());
      });
    });

    group('Register Success', () {
      test('supports value comparisons', () {
        expect(RegisterSuccess(), RegisterSuccess());
      });
    });
    group('Register Error', () {
      test('supports value comparisons', () {
        expect(RegisterError(), RegisterError());
      });
    });
  });
}
