enum ServerError {
  userAlreadyExists,
  invalidCredentials,
  savingError,
  unknownError;
}

ServerError getTypeFromMessage(String message) => switch (message) {
      'User already registered' => ServerError.userAlreadyExists,
      'Invalid login credentials' => ServerError.invalidCredentials,
      'Database error saving new user' => ServerError.savingError,
      _ => ServerError.unknownError,
    };
