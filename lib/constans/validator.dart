class Validator {
  // Funksioni që kontrollon validitetin e emrit të plotë
  static validateFullName(String value) {
    if (value.isEmpty) {
      return "Full Name field is required"; // Kthe mesazhin e gabimit nëse fusha është e zbrazët
    }
    return null; // Kthe null nëse nuk ka gabime
  }

  // Funksioni që kontrollon validitetin e adresës së email-it
  static validateEmail(String value) {
    if (value.isEmpty) {
      return "Email field is required"; // Kthe mesazhin e gabimit nëse fusha është e zbrazët
    } else if (!_isEmailValid(value)) {
      return "Invalid email format"; // Kthe mesazhin e gabimit nëse formati i email-it është i pavlefshëm
    }
    return null; // Kthe null nëse nuk ka gabime
  }

  // Funksioni që kontrollon validitetin e numrit të telefonit celular
  static validateMobileNumber(String value) {
    if (value.isEmpty) {
      return "Mobile Number field is required"; // Kthe mesazhin e gabimit nëse fusha është e zbrazët
    } else if (!_isMobileNumberValid(value)) {
      return "Invalid mobile number format"; // Kthe mesazhin e gabimit nëse formati i numrit të telefonit është i pavlefshëm
    }
    return null; // Kthe null nëse nuk ka gabime
  }

  // Funksioni që kontrollon validitetin e fjalëkalimit
  static validatePassword(String value) {
    if (value.isEmpty) {
      return "Password field is required"; // Kthe mesazhin e gabimit nëse fusha është e zbrazët
    } else if (value.length < 9) {
      return "Password should be at least 9 characters long"; // Kthe mesazhin e gabimit nëse fjalëkalimi është shumë i shkurtër
    }
    return null; // Kthe null nëse nuk ka gabime
  }

  // Funksioni privat që kontrollon validitetin e adresës së email-it
  static bool _isEmailValid(String email) {
    const emailRegex =
        r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$';
    return RegExp(emailRegex).hasMatch(
        email); // Kthe true nëse email-i është i vlefshëm, në të kundërtën kthe false
  }

  // Funksioni privat që kontrollon validitetin e numrit të telefonit celular
  static bool _isMobileNumberValid(String mobileNumber) {
    return int.tryParse(mobileNumber) != null &&
        mobileNumber.length >=
            9; // Kthe true nëse numri i telefonit është i vlefshëm, në të kundërtën kthe false
  }
}
