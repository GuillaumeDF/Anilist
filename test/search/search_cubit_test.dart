// ignore_for_file: prefer_const_constructors
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:data/data_repository.dart';
import 'package:ani_list/logic/cubit/cubit.dart';

class MockAuthenticationRepository extends Mock implements DataRepository {}

void main() {
  const page = 1;
  const title = "Fate";

  group('SearchCubit', () {
    DataRepository dataRepository;

    setUp(() {
      dataRepository = MockAuthenticationRepository();
    });

    test('initial state is TopState', () {
      expect(SearchCubit(dataRepository).state, SearchInitial());
    });
    group('Search', () {
      blocTest<SearchCubit, SearchState>(
        'search animes',
        build: () => SearchCubit(dataRepository),
        act: (cubit) => cubit.searchAnime(title, page),
        verify: (_) {
          verify(
            dataRepository.searchAnime(title, page),
          ).called(1);
        },
      );

      blocTest<SearchCubit, SearchState>(
        'emits [SearchLoading, SearchSuccess] '
        'when fetch succeeds',
        build: () => SearchCubit(dataRepository),
        act: (cubit) => cubit.searchAnime(title, page),
        expect: () => <SearchState>[SearchLoading(), SearchSuccess()],
      );
    });
  });
}
