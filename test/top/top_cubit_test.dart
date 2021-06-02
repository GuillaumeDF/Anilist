// ignore_for_file: prefer_const_constructors
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:data/data_repository.dart';
import 'package:ani_list/logic/cubit/cubit.dart';

class MockAuthenticationRepository extends Mock implements DataRepository {}

void main() {
  const page = 1;
  const type = "tv";

  group('TopCubit', () {
    DataRepository dataRepository;

    setUp(() {
      dataRepository = MockAuthenticationRepository();
    });

    test('initial state is TopState', () {
      expect(TopCubit(dataRepository).state, TopInitial());
    });
    group('top', () {
      blocTest<TopCubit, TopState>(
        'fetches top animes',
        build: () => TopCubit(dataRepository),
        act: (cubit) => cubit.fetchTopAnimes(type, page),
        verify: (_) {
          verify(
            dataRepository.fetchTopAnimes(type, page),
          ).called(1);
        },
      );

      blocTest<TopCubit, TopState>(
        'emits [TopLoading, TopSuccess] '
        'when fetch succeeds',
        build: () => TopCubit(dataRepository),
        act: (cubit) => cubit.fetchTopAnimes(type, page),
        expect: () => <TopState>[TopLoading(), TopSuccess()],
      );
    });
  });
}
