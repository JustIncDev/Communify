String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter an email';
  }

  // This regular expression checks if the email follows the general structure of an email address
  // It requires one or more characters before the '@', followed by one or more characters, a dot, and two or more characters
  if (!RegExp(r'^.+@[A-Za-z]+\.[A-Za-z]{2,}$').hasMatch(value)) {
    return 'Please enter a valid email address';
  }

  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a password';
  }

  // The password should have at least one uppercase letter
  if (!RegExp(r'(?=.*[A-Z])').hasMatch(value)) {
    return 'Password must contain at least one uppercase letter';
  }

  // The password should have at least one lowercase letter
  if (!RegExp(r'(?=.*[a-z])').hasMatch(value)) {
    return 'Password must contain at least one lowercase letter';
  }

  // The password should have at least one digit
  if (!RegExp(r'(?=.*\d)').hasMatch(value)) {
    return 'Password must contain at least one digit';
  }

  // The password should have at least one special character
  if (!RegExp(r'(?=.*[!@#$%^&*(),.?":{}|<>])').hasMatch(value)) {
    return 'Password must contain at least one special character';
  }

  // The password should have at least 8 characters
  if (value.length < 8) {
    return 'Password must be at least 8 characters long';
  }

  return null;
}
