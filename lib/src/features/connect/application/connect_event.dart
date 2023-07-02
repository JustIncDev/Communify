part of 'connect_bloc.dart';

enum SocialProviders {
  apple,
  google,
  twitter,
  discord,
  metamask,
}

sealed class ConnectEvent extends Equatable {}

final class ConnectEmailEvent extends ConnectEvent {
  final String email;
  final String password;

  ConnectEmailEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

final class ConnectSocialNetworkEvent extends ConnectEvent {
  final SocialProviders socialMediaType;

  ConnectSocialNetworkEvent(this.socialMediaType);

  @override
  List<Object?> get props => [];
}
