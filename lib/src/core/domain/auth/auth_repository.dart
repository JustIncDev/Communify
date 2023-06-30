import '../../data/entities/user_data.dart';

abstract interface class IAuthRepository {
  UserData? getCurrentUser();

  Future<bool> isUserAuthenticated();

  Future<void> refreshToken(String refreshToken);
}
