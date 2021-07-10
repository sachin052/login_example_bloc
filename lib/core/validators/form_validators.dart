import 'dart:async';

final validateEmail =
    StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
  if (email.isValidEmail) {
    sink.add(email);
  } else {
    sink.addError('Please enter a valid email');
  }
});

final validatePassword = StreamTransformer<String, String>.fromHandlers(handleData: (string, sink) {
  try {
    if (string.length < 8) {
      sink.addError("Req min 8 chars");
    }  else {
      print("FOURTH");
      sink.add(string);
    }
  } catch (e) {

  }
});

extension StringExtensions on String? {
  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.-_]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (this == null && this?.isEmpty==true)
      return false;
    else
      return emailRegExp.hasMatch(this??"");
  }

}
