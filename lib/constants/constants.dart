import 'package:flutter/material.dart';

// Enums
enum TabScreens {
  AnimesList,
  Search,
  Home,
  Favorites,
  Profile,
}

enum AuthenticationStatus {
  Authenticated,
  Unauthenticated,
  Unknown,
  Success,
  Error
}

enum UserStatus { Initial, Loading, Success, Error, NoUser }

enum StorageStatus { Initial, Loading, UploadSuccess, DownloadSuccess, Error }

// Routes
const String splashRoute = '/';
const String homeRoute = '/home';
const String loginRoute = '/login';
const String detailsRoute = '/details';
const String favoritesRoute = '/favorites';
const String profileRoute = '/profile';
const String registerRoute = '/register';
const String settingsRoute = '/settings';
const String profileEditRoute = '/profileEdit';
const String reviewDetailsRoute = '/reviewDetails';

// List
const tabTitles = ['All', 'Airing', 'Upcoming'];

// Maps
const Map<String, MaterialColor> status = {
  "airing": Colors.green,
  "Currently Airing": Colors.lightGreen,
  "completed": Colors.yellow,
  "Finished Airing": Colors.yellow,
  "to_be_aired": Colors.cyan,
  "upcoming": Colors.cyan,
};

// Preferences
const String themePref = 'theme';
