// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';

import 'package:ani_list/logic/cubit/cubit.dart';

void main() {
  group('LoginState', () {
    group('LoginState Initial', () {
      test('supports value comparisons', () {
        expect(LoginInitial(), LoginInitial());
      });
    });

    group('Login In Progress', () {
      test('supports value comparisons', () {
        expect(LoginInProgress(), LoginInProgress());
      });
    });

    group('Login Success', () {
      test('supports value comparisons', () {
        expect(LoginSuccess(), LoginSuccess());
      });
    });
    group('Login Error', () {
      test('supports value comparisons', () {
        expect(LoginError(), LoginError());
      });
    });
  });
}
