TextValidator(value) {
  if (value == null || value.isEmpty) {
    return 'Some text required';
  } else if (value.toString().length < 4) {
    return 'More than 4 characters required';
  }
  return null;
}

UsernameValidator(value) {
  if (value == null || value.isEmpty) {
    return 'Some text required';
  } else if (value.toString().length < 5) {
    return 'More than 5 characters required';
  }
  return null;
}

EmailValidator(value) {
  if (value.isEmpty) {
    return 'Email is required';
  } else if (!isEmailValid(value)) {
    return 'Enter a valid email address';
  } else {
    return null;
  }
}

bool isEmailValid(String email) {
  // Basic email validation using regex
  // You can implement more complex validation if needed
  return RegExp(r'^[\w-\.]+@[a-zA-Z]+\.[a-zA-Z]{2,}$').hasMatch(email);
}
