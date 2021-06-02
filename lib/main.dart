import 'package:ani_list/models/notifications.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:data/data_repository.dart';
import 'package:users/users_repository.dart';
import 'package:storage/storage_repository.dart';
import 'package:authentication/authentication_repository.dart';

import 'ui/theme.dart';
import 'logic/bloc/bloc.dart';
import 'logic/cubit/cubit.dart';
import 'ui/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // For real device replace localhost by your IP address
  FirebaseFunctions.instance
      .useFunctionsEmulator(origin: 'http://localhost:5001');
  AwesomeNotifications().initialize(null, [
    NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: Color(0xFF9D50DD),
        ledColor: Colors.white)
  ]);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();
  final AuthenticationRepository authenticationRepository =
      AuthenticationRepository<FirebaseProvider>();
  final UsersRepository usersRepository = UsersRepository();
  final StorageRepository storageRepository = StorageRepository();
  final DataRepository dataRepository = DataRepository();

  ThemeData getTheme(BuildContext context, PreferencesState state) {
    if (state is PreferencesLoaded) {
      context.watch<PreferencesCubit>().loadTheme();
    }
    if (state is PreferencesTheme) {
      return state.theme ? lightTheme : darkTheme;
    }
    return darkTheme;
  }

  @override
  Widget build(BuildContext context) {
    AniNotification(dataRepository: dataRepository);
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: authenticationRepository,
        ),
        RepositoryProvider.value(
          value: usersRepository,
        ),
        RepositoryProvider.value(
          value: storageRepository,
        ),
        RepositoryProvider.value(
          value: dataRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthenticationBloc(
                authenticationRepository: authenticationRepository),
          ),
          BlocProvider(create: (context) => PreferencesCubit()),
          BlocProvider(
              lazy: false,
              create: (context) => UserBloc(
                  usersRepository: usersRepository,
                  authBloc: BlocProvider.of<AuthenticationBloc>(context))),
          BlocProvider(
              lazy: false,
              create: (context) => AnimeInfosCubit(dataRepository)),
          BlocProvider(
              lazy: false,
              create: (context) =>
                  StorageBloc(storageRepository: storageRepository)),
          BlocProvider<TopCubit>(
            lazy: false,
            create: (_) => TopCubit(dataRepository),
          ),
          BlocProvider<FavsCubit>(
              lazy: false, create: (context) => FavsCubit(usersRepository)),
          BlocProvider<AnimesListCubit>(
              lazy: false,
              create: (context) => AnimesListCubit(usersRepository)),
        ],
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus &&
                currentFocus.focusedChild != null) {
              FocusManager.instance.primaryFocus.unfocus();
            }
          },
          child: BlocBuilder<PreferencesCubit, PreferencesState>(
            builder: (context, state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'AniList',
                theme: getTheme(context, state),
                onGenerateRoute: _appRouter.onGenerateRoute,
              );
            },
          ),
        ),
      ),
    );
  }
}
