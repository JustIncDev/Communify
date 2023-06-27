// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Hi`
  String get hi {
    return Intl.message(
      'Hi',
      name: 'hi',
      desc: '',
      args: [],
    );
  }

  /// `Communities powered by`
  String get communities {
    return Intl.message(
      'Communities powered by',
      name: 'communities',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continue_title {
    return Intl.message(
      'Continue',
      name: 'continue_title',
      desc: '',
      args: [],
    );
  }

  /// `or`
  String get or {
    return Intl.message(
      'or',
      name: 'or',
      desc: '',
      args: [],
    );
  }

  /// `External Wallet`
  String get external_wallet {
    return Intl.message(
      'External Wallet',
      name: 'external_wallet',
      desc: '',
      args: [],
    );
  }

  /// `Select your wallet`
  String get select_wallet {
    return Intl.message(
      'Select your wallet',
      name: 'select_wallet',
      desc: '',
      args: [],
    );
  }

  /// `MetaMask`
  String get metamask {
    return Intl.message(
      'MetaMask',
      name: 'metamask',
      desc: '',
      args: [],
    );
  }

  /// `WalletConnect`
  String get wallet_connect {
    return Intl.message(
      'WalletConnect',
      name: 'wallet_connect',
      desc: '',
      args: [],
    );
  }

  /// `Choose one`
  String get choose_one {
    return Intl.message(
      'Choose one',
      name: 'choose_one',
      desc: '',
      args: [],
    );
  }

  /// `Start a `
  String get start_a {
    return Intl.message(
      'Start a ',
      name: 'start_a',
      desc: '',
      args: [],
    );
  }

  /// `Communify`
  String get communify {
    return Intl.message(
      'Communify',
      name: 'communify',
      desc: '',
      args: [],
    );
  }

  /// ` group`
  String get group {
    return Intl.message(
      ' group',
      name: 'group',
      desc: '',
      args: [],
    );
  }

  /// `Join a`
  String get join_a {
    return Intl.message(
      'Join a',
      name: 'join_a',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get already_have_account {
    return Intl.message(
      'Already have an account?',
      name: 'already_have_account',
      desc: '',
      args: [],
    );
  }

  /// `First name`
  String get first_name {
    return Intl.message(
      'First name',
      name: 'first_name',
      desc: '',
      args: [],
    );
  }

  /// `Last name`
  String get last_name {
    return Intl.message(
      'Last name',
      name: 'last_name',
      desc: '',
      args: [],
    );
  }

  /// `Jane`
  String get first_name_hint {
    return Intl.message(
      'Jane',
      name: 'first_name_hint',
      desc: '',
      args: [],
    );
  }

  /// `Doe`
  String get last_name_hint {
    return Intl.message(
      'Doe',
      name: 'last_name_hint',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message(
      'Username',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `@username`
  String get username_hint {
    return Intl.message(
      '@username',
      name: 'username_hint',
      desc: '',
      args: [],
    );
  }

  /// `Date of birth`
  String get date_of_birth {
    return Intl.message(
      'Date of birth',
      name: 'date_of_birth',
      desc: '',
      args: [],
    );
  }

  /// `MM/DD/YYYY`
  String get date_of_birth_hint {
    return Intl.message(
      'MM/DD/YYYY',
      name: 'date_of_birth_hint',
      desc: '',
      args: [],
    );
  }

  /// `By selecting Agree and continue below,`
  String get first_agreement_row {
    return Intl.message(
      'By selecting Agree and continue below,',
      name: 'first_agreement_row',
      desc: '',
      args: [],
    );
  }

  /// `I agree to`
  String get i_agree_to {
    return Intl.message(
      'I agree to',
      name: 'i_agree_to',
      desc: '',
      args: [],
    );
  }

  /// `Terms of Services`
  String get terms_of_services {
    return Intl.message(
      'Terms of Services',
      name: 'terms_of_services',
      desc: '',
      args: [],
    );
  }

  /// `and`
  String get and {
    return Intl.message(
      'and',
      name: 'and',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacy_policy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacy_policy',
      desc: '',
      args: [],
    );
  }

  /// `Create your profile`
  String get create_your_profile {
    return Intl.message(
      'Create your profile',
      name: 'create_your_profile',
      desc: '',
      args: [],
    );
  }

  /// `Agree & continue`
  String get agree_and_continue {
    return Intl.message(
      'Agree & continue',
      name: 'agree_and_continue',
      desc: '',
      args: [],
    );
  }

  /// `Tell us about your group?`
  String get tell_us_about_your_group {
    return Intl.message(
      'Tell us about your group?',
      name: 'tell_us_about_your_group',
      desc: '',
      args: [],
    );
  }

  /// `Entrepreneur / Business`
  String get entrepreneur {
    return Intl.message(
      'Entrepreneur / Business',
      name: 'entrepreneur',
      desc: '',
      args: [],
    );
  }

  /// `Non-profit orginasation`
  String get non_profit {
    return Intl.message(
      'Non-profit orginasation',
      name: 'non_profit',
      desc: '',
      args: [],
    );
  }

  /// `Teacher / Coach`
  String get teacher {
    return Intl.message(
      'Teacher / Coach',
      name: 'teacher',
      desc: '',
      args: [],
    );
  }

  /// `Filmmaker / Videographer`
  String get filmmaker {
    return Intl.message(
      'Filmmaker / Videographer',
      name: 'filmmaker',
      desc: '',
      args: [],
    );
  }

  /// `Content Creator`
  String get content_creator {
    return Intl.message(
      'Content Creator',
      name: 'content_creator',
      desc: '',
      args: [],
    );
  }

  /// `Podcaster`
  String get podcaster {
    return Intl.message(
      'Podcaster',
      name: 'podcaster',
      desc: '',
      args: [],
    );
  }

  /// `NFT / DAO / Blockchain`
  String get nft_dao_blockchain {
    return Intl.message(
      'NFT / DAO / Blockchain',
      name: 'nft_dao_blockchain',
      desc: '',
      args: [],
    );
  }

  /// `Blogger`
  String get blogger {
    return Intl.message(
      'Blogger',
      name: 'blogger',
      desc: '',
      args: [],
    );
  }

  /// `Events / Festival`
  String get events {
    return Intl.message(
      'Events / Festival',
      name: 'events',
      desc: '',
      args: [],
    );
  }

  /// `Influencer`
  String get influencer {
    return Intl.message(
      'Influencer',
      name: 'influencer',
      desc: '',
      args: [],
    );
  }

  /// `Musician / Record Label`
  String get musician {
    return Intl.message(
      'Musician / Record Label',
      name: 'musician',
      desc: '',
      args: [],
    );
  }

  /// `Gaming / eSports`
  String get gaming {
    return Intl.message(
      'Gaming / eSports',
      name: 'gaming',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get other {
    return Intl.message(
      'Other',
      name: 'other',
      desc: '',
      args: [],
    );
  }

  /// `Describe`
  String get describe {
    return Intl.message(
      'Describe',
      name: 'describe',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message(
      'Skip',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Choose a name for your group`
  String get choose_name_group {
    return Intl.message(
      'Choose a name for your group',
      name: 'choose_name_group',
      desc: '',
      args: [],
    );
  }

  /// `Your Network`
  String get your_network {
    return Intl.message(
      'Your Network',
      name: 'your_network',
      desc: '',
      args: [],
    );
  }

  /// `You can always change it later!`
  String get you_can_always_change {
    return Intl.message(
      'You can always change it later!',
      name: 'you_can_always_change',
      desc: '',
      args: [],
    );
  }

  /// `Activate push notifications`
  String get activate_push_notifications {
    return Intl.message(
      'Activate push notifications',
      name: 'activate_push_notifications',
      desc: '',
      args: [],
    );
  }

  /// `Decide later`
  String get decide_later {
    return Intl.message(
      'Decide later',
      name: 'decide_later',
      desc: '',
      args: [],
    );
  }

  /// `You’re all set!`
  String get you_all_set {
    return Intl.message(
      'You’re all set!',
      name: 'you_all_set',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to`
  String get welcome_to {
    return Intl.message(
      'Welcome to',
      name: 'welcome_to',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
