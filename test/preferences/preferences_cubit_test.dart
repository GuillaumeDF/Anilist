// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';

import 'package:ani_list/logic/cubit/cubit.dart';

void main() {
  group('PreferencesCubit', () {
    test('state is PreferencesLoading', () {
      expect(PreferencesCubit().state, PreferencesLoading());
    });
  });
}
