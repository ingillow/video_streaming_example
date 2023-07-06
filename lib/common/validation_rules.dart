
class Validator{
  final _emailRules = RegExp(
      r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$');
  final _passwordRules = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');


  String validateEmail(String email){
    if(email.isEmpty){
      return 'Email can not be empty';
    }else if(!_emailRules.hasMatch(email)){
      return 'Use correct email';
    }
    return 'Something went wrong';
  }

  String validatePassword(String password){
    if(password.isEmpty){
      return 'Password can not be empty';
    }else if(!_passwordRules.hasMatch(password)){
      return 'Use correct password';
    }
    return 'Something went wrong';
  }

}

