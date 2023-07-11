import 'package:intl/intl.dart';

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

String? validateName({String? name, bool harmfulWord = false}) {
  if (name == null || name.isEmpty) {
    return 'Please enter a name';
  }

  // Check if the name contains harmful words
  if (harmfulWord) {
    return 'Name contains inappropriate words';
  }

  // Check if the name is too short
  if (name.length < 2) {
    return 'Name is too short';
  }

  // Check for invalid characters
  // Only allows letters, spaces, and hyphens
  if (!RegExp(r'^[a-zA-Z\- ]+$').hasMatch(name)) {
    return 'Name can only contain letters, spaces, and hyphens';
  }

  return null;
}

String? validateUsername({String? username, bool harmfulWord = false}) {
  if (username == null || username.isEmpty) {
    return 'Please enter a username';
  }

  // Check if the username contains harmful words
  if (harmfulWord) {
    return 'Name contains inappropriate words';
  }

  // Check if the username is too short
  if (username.length < 3) {
    return 'Username is too short';
  }

  // Check for invalid characters
  // Only allows letters, numbers, underscores, and hyphens
  if (!RegExp(r'^[a-zA-Z0-9_\-]+$').hasMatch(username)) {
    return 'Username can only contain letters, numbers, underscores, and hyphens';
  }

  return null;
}

String? validateDateOfBirth(String? dateOfBirth) {
  if (dateOfBirth == null || dateOfBirth.isEmpty) {
    return 'Please enter your date of birth';
  }

  // Check if the dateOfBirth is in valid date format (mm/dd/yy)
  DateTime? parsedDate;
  try {
    parsedDate = DateFormat('MM/dd/yy').parseStrict(dateOfBirth);
  } on Object catch (e) {
    return 'Invalid date format. Please use MM/DD/YYYY';
  }

  // Check if the user is at least 13 years old
  final thirteenYearsAgo =
      DateTime.now().subtract(const Duration(days: 13 * 365));
  if (parsedDate.isAfter(thirteenYearsAgo)) {
    return 'You must be at least 13 years old';
  }

  return null;
}

String? validateGroupName({String? groupName, bool harmfulWord = false}) {
  if (groupName == null || groupName.isEmpty) {
    return 'Please enter a group name';
  }

  // Check if the group name contains harmful words
  if (harmfulWord) {
    return 'Group name contains inappropriate words';
  }

  // Check if the group name is too short
  if (groupName.length < 3) {
    return 'Group name is too short';
  }

  // Check for invalid characters
  // Only allows letters, numbers, spaces, underscores, and hyphens
  if (!RegExp(r'^[a-zA-Z0-9_\- ]+$').hasMatch(groupName)) {
    return 'Group name can only contain letters, numbers, spaces, underscores, and hyphens';
  }

  return null;
}
