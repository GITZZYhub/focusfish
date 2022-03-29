part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const initial = Paths.flash;
  static const splash = Paths.splash;
  static const login = Paths.login;
  static const home = Paths.home;
  static const focus = Paths.home + Paths.focus;
  static const result = Paths.home + Paths.result;
  static const rest = Paths.home + Paths.rest;
  static const daily = Paths.home + Paths.daily;
  static const my_data = Paths.home + Paths.my_data;
}

abstract class Paths {
  Paths._();

  static const flash = '/flash';
  static const splash = '/splash';
  static const login = '/login';
  static const home = '/home';
  static const focus = '/focus';
  static const result = '/result';
  static const rest = '/rest';
  static const daily = '/daily';
  static const my_data = '/my_data';
}
