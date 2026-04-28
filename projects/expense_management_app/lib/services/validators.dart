String? emailValidator(value) {
  if (value!.isEmpty) {
    return 'Please Enter Email';
  }
  return null;
}

String? passwordValidator(value) {
  if (value!.isEmpty) {
    return 'Please Enter Password';
  }
  if (value.length < 6) {
    return 'Password must be at least 6 character long';
  }
  return null;
}
