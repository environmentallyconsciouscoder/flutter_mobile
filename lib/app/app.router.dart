// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i25;
import 'package:flutter/material.dart';
import 'package:limetrack/app/custom_route_transition.dart' as _i24;
import 'package:limetrack/enums/scan_mode.dart' as _i30;
import 'package:limetrack/models/address.dart' as _i29;
import 'package:limetrack/models/bin.dart' as _i26;
import 'package:limetrack/models/caddy.dart' as _i27;
import 'package:limetrack/models/producer.dart' as _i28;
import 'package:limetrack/ui/views/account/account_view.dart' as _i3;
import 'package:limetrack/ui/views/account_management/account_management_view.dart' as _i4;
import 'package:limetrack/ui/views/account_management_bins_and_caddies/account_management_bins_and_caddies_view.dart' as _i5;
import 'package:limetrack/ui/views/account_management_liners/account_management_liners_view.dart' as _i6;
import 'package:limetrack/ui/views/account_management_notifications/account_management_notifications_view.dart' as _i7;
import 'package:limetrack/ui/views/account_management_team/account_management_team_view.dart' as _i8;
import 'package:limetrack/ui/views/enter_deposit/enter_deposit_view.dart' as _i9;
import 'package:limetrack/ui/views/enter_weight/enter_weight_view.dart' as _i10;
import 'package:limetrack/ui/views/forgot_password/forgot_password_view.dart' as _i11;
import 'package:limetrack/ui/views/home/home_view.dart' as _i12;
import 'package:limetrack/ui/views/locate_bin/locate_bin_view.dart' as _i13;
import 'package:limetrack/ui/views/login/login_view.dart' as _i14;
import 'package:limetrack/ui/views/producer_registration/producer_registration_view.dart' as _i15;
import 'package:limetrack/ui/views/producer_site_registration/producer_site_registration_view.dart' as _i16;
import 'package:limetrack/ui/views/register/register_view.dart' as _i17;
import 'package:limetrack/ui/views/register_bin/register_bin_view.dart' as _i18;
import 'package:limetrack/ui/views/register_caddy/register_caddy_view.dart' as _i19;
import 'package:limetrack/ui/views/reports/reports_view.dart' as _i20;
import 'package:limetrack/ui/views/scan/scan_view.dart' as _i21;
import 'package:limetrack/ui/views/share/share_view.dart' as _i22;
import 'package:limetrack/ui/views/startup/startup_view.dart' as _i2;
import 'package:limetrack/ui/views/transfer_details/transfer_details_view.dart' as _i23;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i31;

class Routes {
  static const startupView = '/startup-view';

  static const accountView = '/account-view';

  static const accountManagementView = '/account-management-view';

  static const accountManagementBinsAndCaddiesView = '/account-management-bins-and-caddies-view';

  static const accountManagementLinersView = '/account-management-liners-view';

  static const accountManagementNotificationsView = '/account-management-notifications-view';

  static const accountManagementTeamView = '/account-management-team-view';

  static const enterDepositView = '/enter-deposit-view';

  static const enterWeightView = '/enter-weight-view';

  static const forgotPasswordView = '/forgot-password-view';

  static const homeView = '/home-view';

  static const locateBinView = '/locate-bin-view';

  static const loginView = '/login-view';

  static const producerRegistrationView = '/producer-registration-view';

  static const producerSiteRegistrationView = '/producer-site-registration-view';

  static const registerView = '/register-view';

  static const registerBinView = '/register-bin-view';

  static const registerCaddyView = '/register-caddy-view';

  static const reportsView = '/reports-view';

  static const scanView = '/scan-view';

  static const shareView = '/share-view';

  static const transferDetailsView = '/transfer-details-view';

  static const all = <String>{
    startupView,
    accountView,
    accountManagementView,
    accountManagementBinsAndCaddiesView,
    accountManagementLinersView,
    accountManagementNotificationsView,
    accountManagementTeamView,
    enterDepositView,
    enterWeightView,
    forgotPasswordView,
    homeView,
    locateBinView,
    loginView,
    producerRegistrationView,
    producerSiteRegistrationView,
    registerView,
    registerBinView,
    registerCaddyView,
    reportsView,
    scanView,
    shareView,
    transferDetailsView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.startupView,
      page: _i2.StartupView,
    ),
    _i1.RouteDef(
      Routes.accountView,
      page: _i3.AccountView,
    ),
    _i1.RouteDef(
      Routes.accountManagementView,
      page: _i4.AccountManagementView,
    ),
    _i1.RouteDef(
      Routes.accountManagementBinsAndCaddiesView,
      page: _i5.AccountManagementBinsAndCaddiesView,
    ),
    _i1.RouteDef(
      Routes.accountManagementLinersView,
      page: _i6.AccountManagementLinersView,
    ),
    _i1.RouteDef(
      Routes.accountManagementNotificationsView,
      page: _i7.AccountManagementNotificationsView,
    ),
    _i1.RouteDef(
      Routes.accountManagementTeamView,
      page: _i8.AccountManagementTeamView,
    ),
    _i1.RouteDef(
      Routes.enterDepositView,
      page: _i9.EnterDepositView,
    ),
    _i1.RouteDef(
      Routes.enterWeightView,
      page: _i10.EnterWeightView,
    ),
    _i1.RouteDef(
      Routes.forgotPasswordView,
      page: _i11.ForgotPasswordView,
    ),
    _i1.RouteDef(
      Routes.homeView,
      page: _i12.HomeView,
    ),
    _i1.RouteDef(
      Routes.locateBinView,
      page: _i13.LocateBinView,
    ),
    _i1.RouteDef(
      Routes.loginView,
      page: _i14.LoginView,
    ),
    _i1.RouteDef(
      Routes.producerRegistrationView,
      page: _i15.ProducerRegistrationView,
    ),
    _i1.RouteDef(
      Routes.producerSiteRegistrationView,
      page: _i16.ProducerSiteRegistrationView,
    ),
    _i1.RouteDef(
      Routes.registerView,
      page: _i17.RegisterView,
    ),
    _i1.RouteDef(
      Routes.registerBinView,
      page: _i18.RegisterBinView,
    ),
    _i1.RouteDef(
      Routes.registerCaddyView,
      page: _i19.RegisterCaddyView,
    ),
    _i1.RouteDef(
      Routes.reportsView,
      page: _i20.ReportsView,
    ),
    _i1.RouteDef(
      Routes.scanView,
      page: _i21.ScanView,
    ),
    _i1.RouteDef(
      Routes.shareView,
      page: _i22.ShareView,
    ),
    _i1.RouteDef(
      Routes.transferDetailsView,
      page: _i23.TransferDetailsView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.StartupView: (data) {
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => const _i2.StartupView(),
        settings: data,
      );
    },
    _i3.AccountView: (data) {
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => const _i3.AccountView(),
        settings: data,
      );
    },
    _i4.AccountManagementView: (data) {
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => const _i4.AccountManagementView(),
        settings: data,
      );
    },
    _i5.AccountManagementBinsAndCaddiesView: (data) {
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => const _i5.AccountManagementBinsAndCaddiesView(),
        settings: data,
      );
    },
    _i6.AccountManagementLinersView: (data) {
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => const _i6.AccountManagementLinersView(),
        settings: data,
      );
    },
    _i7.AccountManagementNotificationsView: (data) {
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => const _i7.AccountManagementNotificationsView(),
        settings: data,
      );
    },
    _i8.AccountManagementTeamView: (data) {
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => const _i8.AccountManagementTeamView(),
        settings: data,
      );
    },
    _i9.EnterDepositView: (data) {
      final args = data.getArgs<EnterDepositViewArguments>(nullOk: false);
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => _i9.EnterDepositView(key: args.key, bin: args.bin),
        settings: data,
      );
    },
    _i10.EnterWeightView: (data) {
      final args = data.getArgs<EnterWeightViewArguments>(nullOk: false);
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => _i10.EnterWeightView(key: args.key, caddy: args.caddy),
        settings: data,
      );
    },
    _i11.ForgotPasswordView: (data) {
      final args = data.getArgs<ForgotPasswordViewArguments>(
        orElse: () => const ForgotPasswordViewArguments(),
      );
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => _i11.ForgotPasswordView(key: args.key),
        settings: data,
      );
    },
    _i12.HomeView: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) => const _i12.HomeView(),
        settings: data,
        transitionsBuilder: data.transition ?? _i24.CustomRouteTransition.sharedAxisScaled,
        transitionDuration: const Duration(milliseconds: 550),
        reverseTransitionDuration: const Duration(milliseconds: 350),
      );
    },
    _i13.LocateBinView: (data) {
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => const _i13.LocateBinView(),
        settings: data,
      );
    },
    _i14.LoginView: (data) {
      final args = data.getArgs<LoginViewArguments>(
        orElse: () => const LoginViewArguments(),
      );
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => _i14.LoginView(key: args.key),
        settings: data,
      );
    },
    _i15.ProducerRegistrationView: (data) {
      final args = data.getArgs<ProducerRegistrationViewArguments>(
        orElse: () => const ProducerRegistrationViewArguments(),
      );
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => _i15.ProducerRegistrationView(key: args.key),
        settings: data,
      );
    },
    _i16.ProducerSiteRegistrationView: (data) {
      final args = data.getArgs<ProducerSiteRegistrationViewArguments>(nullOk: false);
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => _i16.ProducerSiteRegistrationView(key: args.key, producer: args.producer, producerAddress: args.producerAddress),
        settings: data,
      );
    },
    _i17.RegisterView: (data) {
      final args = data.getArgs<RegisterViewArguments>(
        orElse: () => const RegisterViewArguments(),
      );
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => _i17.RegisterView(key: args.key),
        settings: data,
      );
    },
    _i18.RegisterBinView: (data) {
      final args = data.getArgs<RegisterBinViewArguments>(nullOk: false);
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => _i18.RegisterBinView(key: args.key, bin: args.bin, scanMode: args.scanMode),
        settings: data,
      );
    },
    _i19.RegisterCaddyView: (data) {
      final args = data.getArgs<RegisterCaddyViewArguments>(nullOk: false);
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => _i19.RegisterCaddyView(key: args.key, caddy: args.caddy, scanMode: args.scanMode),
        settings: data,
      );
    },
    _i20.ReportsView: (data) {
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => const _i20.ReportsView(),
        settings: data,
      );
    },
    _i21.ScanView: (data) {
      final args = data.getArgs<ScanViewArguments>(
        orElse: () => const ScanViewArguments(),
      );
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => _i21.ScanView(key: args.key, scanMode: args.scanMode),
        settings: data,
      );
    },
    _i22.ShareView: (data) {
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => const _i22.ShareView(),
        settings: data,
      );
    },
    _i23.TransferDetailsView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const _i23.TransferDetailsView(),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;
  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class EnterDepositViewArguments {
  const EnterDepositViewArguments({
    this.key,
    required this.bin,
  });

  final _i25.Key? key;

  final _i26.Bin bin;
}

class EnterWeightViewArguments {
  const EnterWeightViewArguments({
    this.key,
    required this.caddy,
  });

  final _i25.Key? key;

  final _i27.Caddy caddy;
}

class ForgotPasswordViewArguments {
  const ForgotPasswordViewArguments({this.key});

  final _i25.Key? key;
}

class LoginViewArguments {
  const LoginViewArguments({this.key});

  final _i25.Key? key;
}

class ProducerRegistrationViewArguments {
  const ProducerRegistrationViewArguments({this.key});

  final _i25.Key? key;
}

class ProducerSiteRegistrationViewArguments {
  const ProducerSiteRegistrationViewArguments({
    this.key,
    required this.producer,
    required this.producerAddress,
  });

  final _i25.Key? key;

  final _i28.Producer producer;

  final _i29.Address producerAddress;
}

class RegisterViewArguments {
  const RegisterViewArguments({this.key});

  final _i25.Key? key;
}

class RegisterBinViewArguments {
  const RegisterBinViewArguments({
    this.key,
    required this.bin,
    this.scanMode = _i30.ScanMode.auto,
  });

  final _i25.Key? key;

  final _i26.Bin bin;

  final _i30.ScanMode scanMode;
}

class RegisterCaddyViewArguments {
  const RegisterCaddyViewArguments({
    this.key,
    required this.caddy,
    this.scanMode = _i30.ScanMode.auto,
  });

  final _i25.Key? key;

  final _i27.Caddy caddy;

  final _i30.ScanMode scanMode;
}

class ScanViewArguments {
  const ScanViewArguments({
    this.key,
    this.scanMode = _i30.ScanMode.auto,
  });

  final _i25.Key? key;

  final _i30.ScanMode scanMode;
}

extension NavigatorStateExtension on _i31.NavigationService {
  Future<dynamic> navigateToStartupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
  ]) async {
    return navigateTo<dynamic>(Routes.startupView,
        id: routerId, preventDuplicates: preventDuplicates, parameters: parameters, transition: transition);
  }

  Future<dynamic> navigateToAccountView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
  ]) async {
    return navigateTo<dynamic>(Routes.accountView,
        id: routerId, preventDuplicates: preventDuplicates, parameters: parameters, transition: transition);
  }

  Future<dynamic> navigateToAccountManagementView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
  ]) async {
    return navigateTo<dynamic>(Routes.accountManagementView,
        id: routerId, preventDuplicates: preventDuplicates, parameters: parameters, transition: transition);
  }

  Future<dynamic> navigateToAccountManagementBinsAndCaddiesView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
  ]) async {
    return navigateTo<dynamic>(Routes.accountManagementBinsAndCaddiesView,
        id: routerId, preventDuplicates: preventDuplicates, parameters: parameters, transition: transition);
  }

  Future<dynamic> navigateToAccountManagementLinersView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
  ]) async {
    return navigateTo<dynamic>(Routes.accountManagementLinersView,
        id: routerId, preventDuplicates: preventDuplicates, parameters: parameters, transition: transition);
  }

  Future<dynamic> navigateToAccountManagementNotificationsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
  ]) async {
    return navigateTo<dynamic>(Routes.accountManagementNotificationsView,
        id: routerId, preventDuplicates: preventDuplicates, parameters: parameters, transition: transition);
  }

  Future<dynamic> navigateToAccountManagementTeamView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
  ]) async {
    return navigateTo<dynamic>(Routes.accountManagementTeamView,
        id: routerId, preventDuplicates: preventDuplicates, parameters: parameters, transition: transition);
  }

  Future<dynamic> navigateToEnterDepositView({
    _i25.Key? key,
    required _i26.Bin bin,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
  }) async {
    return navigateTo<dynamic>(Routes.enterDepositView,
        arguments: EnterDepositViewArguments(key: key, bin: bin),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToEnterWeightView({
    _i25.Key? key,
    required _i27.Caddy caddy,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
  }) async {
    return navigateTo<dynamic>(Routes.enterWeightView,
        arguments: EnterWeightViewArguments(key: key, caddy: caddy),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToForgotPasswordView({
    _i25.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
  }) async {
    return navigateTo<dynamic>(Routes.forgotPasswordView,
        arguments: ForgotPasswordViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
  ]) async {
    return navigateTo<dynamic>(Routes.homeView, id: routerId, preventDuplicates: preventDuplicates, parameters: parameters, transition: transition);
  }

  Future<dynamic> navigateToLocateBinView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
  ]) async {
    return navigateTo<dynamic>(Routes.locateBinView,
        id: routerId, preventDuplicates: preventDuplicates, parameters: parameters, transition: transition);
  }

  Future<dynamic> navigateToLoginView({
    _i25.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
  }) async {
    return navigateTo<dynamic>(Routes.loginView,
        arguments: LoginViewArguments(key: key), id: routerId, preventDuplicates: preventDuplicates, parameters: parameters, transition: transition);
  }

  Future<dynamic> navigateToProducerRegistrationView({
    _i25.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
  }) async {
    return navigateTo<dynamic>(Routes.producerRegistrationView,
        arguments: ProducerRegistrationViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToProducerSiteRegistrationView({
    _i25.Key? key,
    required _i28.Producer producer,
    required _i29.Address producerAddress,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
  }) async {
    return navigateTo<dynamic>(Routes.producerSiteRegistrationView,
        arguments: ProducerSiteRegistrationViewArguments(key: key, producer: producer, producerAddress: producerAddress),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToRegisterView({
    _i25.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
  }) async {
    return navigateTo<dynamic>(Routes.registerView,
        arguments: RegisterViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToRegisterBinView({
    _i25.Key? key,
    required _i26.Bin bin,
    _i30.ScanMode scanMode = _i30.ScanMode.auto,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
  }) async {
    return navigateTo<dynamic>(Routes.registerBinView,
        arguments: RegisterBinViewArguments(key: key, bin: bin, scanMode: scanMode),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToRegisterCaddyView({
    _i25.Key? key,
    required _i27.Caddy caddy,
    _i30.ScanMode scanMode = _i30.ScanMode.auto,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
  }) async {
    return navigateTo<dynamic>(Routes.registerCaddyView,
        arguments: RegisterCaddyViewArguments(key: key, caddy: caddy, scanMode: scanMode),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToReportsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
  ]) async {
    return navigateTo<dynamic>(Routes.reportsView,
        id: routerId, preventDuplicates: preventDuplicates, parameters: parameters, transition: transition);
  }

  Future<dynamic> navigateToScanView({
    _i25.Key? key,
    _i30.ScanMode scanMode = _i30.ScanMode.auto,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
  }) async {
    return navigateTo<dynamic>(Routes.scanView,
        arguments: ScanViewArguments(key: key, scanMode: scanMode),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToShareView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
  ]) async {
    return navigateTo<dynamic>(Routes.shareView, id: routerId, preventDuplicates: preventDuplicates, parameters: parameters, transition: transition);
  }

  Future<dynamic> navigateToTransferDetailsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transition,
  ]) async {
    return navigateTo<dynamic>(Routes.transferDetailsView,
        id: routerId, preventDuplicates: preventDuplicates, parameters: parameters, transition: transition);
  }
}
