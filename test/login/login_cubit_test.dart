// ignore_for_file: prefer_const_constructors
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ani_list/logic/cubit/cubit.dart';
import 'package:authentication/authentication_repository.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  const validEmailString = 'test@gmail.com';
  const validPasswordString = 't0pS3cret1234';

  group('LoginCubit', () {
    AuthenticationRepository authenticationRepository;

    setUp(() {
      authenticationRepository = MockAuthenticationRepository();
    });

    test('throws AssertionError when authenticationRepository is null', () {
      expect(() => LoginCubit(null), throwsA(isA<AssertionError>()));
    });

    test('initial state is LoginState', () {
      expect(LoginCubit(authenticationRepository).state, LoginInitial());
    });

    group('logInWithCredentials', () {
      blocTest<LoginCubit, LoginState>(
        'calls logInWithEmailAndPassword with correct email/password',
        build: () => LoginCubit(authenticationRepository),
        act: (cubit) =>
            cubit.logInWithCredentials(validEmailString, validPasswordString),
        verify: (_) {
          verify(
            authenticationRepository.logInWithEmailAndPassword(
              email: validEmailString,
              password: validPasswordString,
            ),
          ).called(1);
        },
      );

      blocTest<LoginCubit, LoginState>(
        'emits [LoginInProgress, LoginSuccess] '
        'when logInWithEmailAndPassword succeeds',
        build: () => LoginCubit(authenticationRepository),
        act: (cubit) =>
            cubit.logInWithCredentials(validEmailString, validPasswordString),
        expect: () => <LoginState>[LoginInProgress(), LoginSuccess()],
      );

      blocTest<LoginCubit, LoginState>(
        'emits [LoginProgress, LoginError] '
        'when logInWithEmailAndPassword fails',
        build: () {
          when(authenticationRepository.logInWithEmailAndPassword(
            email: anyNamed('email'),
            password: anyNamed('password'),
          )).thenThrow(Exception('oops'));
          return LoginCubit(authenticationRepository);
        },
        act: (cubit) => cubit.logInWithCredentials('email', 'password'),
        expect: () => <LoginState>[LoginInProgress(), LoginError()],
      );
    });

    group('logInWithGoogle', () {
      blocTest<LoginCubit, LoginState>(
        'calls logInWithGoogle',
        build: () => LoginCubit(authenticationRepository),
        act: (cubit) => cubit.logInWithGoogle(),
        verify: (_) {
          verify(authenticationRepository.logInWithGoogle()).called(1);
        },
      );

      blocTest<LoginCubit, LoginState>(
        'emits [LoginInProgress, LoginSuccess] '
        'when logInWithGoogle succeeds',
        build: () => LoginCubit(authenticationRepository),
        act: (cubit) => cubit.logInWithGoogle(),
        expect: () => <LoginState>[LoginInProgress(), LoginSuccess()],
      );

      blocTest<LoginCubit, LoginState>(
        'emits [LoginInProgress, LoginError] '
        'when logInWithGoogle fails',
        build: () {
          when(
            authenticationRepository.logInWithGoogle(),
          ).thenThrow(Exception('oops'));
          return LoginCubit(authenticationRepository);
        },
        act: (cubit) => cubit.logInWithGoogle(),
        expect: () => <LoginState>[LoginInProgress(), LoginError()],
      );
    });
  });
}
