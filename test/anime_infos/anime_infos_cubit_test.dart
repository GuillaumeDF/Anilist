// ignore_for_file: prefer_const_constructors
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:data/data_repository.dart';
import 'package:ani_list/logic/cubit/cubit.dart';

class MockAuthenticationRepository extends Mock implements DataRepository {}

void main() {
  const id = "9253";

  group('AnimeInfosCubit', () {
    DataRepository dataRepository;

    setUp(() {
      dataRepository = MockAuthenticationRepository();
    });

    test('initial state is TopState', () {
      expect(AnimeInfosCubit(dataRepository).state, AnimeInfosInitial());
    });
    group('AnimeInfos', () {
      blocTest<AnimeInfosCubit, AnimeInfosState>(
        'fetch anime infos',
        build: () => AnimeInfosCubit(dataRepository),
        act: (cubit) => cubit.fetchAnimeInfos(id),
        verify: (_) {
          verify(
            dataRepository.fetchAnimeInfos(id),
          ).called(1);
        },
      );

      blocTest<AnimeInfosCubit, AnimeInfosState>(
        'emits [AnimeInfosLoading, AnimeInfosSuccess] '
        'when fetch succeeds',
        build: () => AnimeInfosCubit(dataRepository),
        act: (cubit) => cubit.fetchAnimeInfos(id),
        expect: () =>
            <AnimeInfosState>[AnimeInfosLoading(), AnimeInfosSuccess()],
      );
    });
    group('AnimeInfos Review', () {
      blocTest<AnimeInfosCubit, AnimeInfosState>(
        'fetch anime reviews',
        build: () => AnimeInfosCubit(dataRepository),
        act: (cubit) => cubit.fetchAnimeReviews(id),
        verify: (_) {
          verify(
            dataRepository.fetchAnimeReviews(id),
          ).called(1);
        },
      );

      blocTest<AnimeInfosCubit, AnimeInfosState>(
        'emits [AnimeInfosLoading, AnimeInfosSuccess] '
        'when fetch succeeds',
        build: () => AnimeInfosCubit(dataRepository),
        act: (cubit) => cubit.fetchAnimeReviews(id),
        expect: () =>
            <AnimeInfosState>[AnimeInfosLoading(), AnimeInfosReviewsSuccess()],
      );
    });
  });
}
