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
  const validConfirmString = 't0pS3cret1234';

  group('RegisterCubit', () {
    AuthenticationRepository authenticationRepository;

    setUp(() {
      authenticationRepository = MockAuthenticationRepository();
    });

    test('throws AssertionError when authenticationRepository is null', () {
      expect(() => RegisterCubit(null), throwsA(isA<AssertionError>()));
    });

    test('initial state is RegisterState', () {
      expect(RegisterCubit(authenticationRepository).state, RegisterInitial());
    });

    group('register', () {
      blocTest<RegisterCubit, RegisterState>(
        'calls register with correct email/password/confirm',
        build: () => RegisterCubit(authenticationRepository),
        act: (cubit) => cubit.register(
            validEmailString, validPasswordString, validConfirmString),
        verify: (_) {
          verify(
            authenticationRepository.signUp(
              email: validEmailString,
              password: validPasswordString,
            ),
          ).called(1);
        },
      );

      blocTest<RegisterCubit, RegisterState>(
        'emits [RegisterInProgress, RegisterSuccess] '
        'when register succeeds',
        build: () => RegisterCubit(authenticationRepository),
        act: (cubit) => cubit.register(
            validEmailString, validPasswordString, validConfirmString),
        expect: () => <RegisterState>[RegisterInProgress(), RegisterSuccess()],
      );
    });
  });
}
