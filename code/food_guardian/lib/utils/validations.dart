const String emailRegex = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
final validCharacters = RegExp(r'^[a-zA-Z ]+$');

String? validateEmail(String? value){
  if (value == null || value.trim().isEmpty) {
    return 'Please enter some text';
  } else if (!RegExp(emailRegex).hasMatch(value)) {
    return 'Please enter a valid email';
  }
  return null;
}

String? validateName(String? value){
  if (value == null || value.trim().isEmpty) {
    return 'Please enter some text';
  }
  return null;
}

String? validatePassword(String? value){
  if (value == null || value.trim().isEmpty) {
    return 'Please enter some text';
  } else if (value.length < 10) {
    return 'Please enter a password that exceeds 9 characters';
  }
  return null;
}