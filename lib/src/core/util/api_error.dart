enum ServerError {
  userAlreadyExists,
  invalidCredentials,
  unknownError;
}

ServerError getTypeFromMessage(String message) => switch (message) {
      'User already registered' => ServerError.userAlreadyExists,
      'Invalid login credentials' => ServerError.invalidCredentials,
      _ => ServerError.unknownError,
    };
