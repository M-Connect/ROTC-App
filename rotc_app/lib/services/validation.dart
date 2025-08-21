import 'package:form_field_validator/form_field_validator.dart';

class Validation {
  static firstNameValidation() {
    return MultiValidator([
      RequiredValidator(errorText: 'First name is required'),
      MinLengthValidator(2, errorText: 'First name must be at least 2 characters long'),
      MaxLengthValidator(30, errorText: 'First name must be less than 30 characters long'),
    ]);
  }

  static lastNameValidation() {
    return MultiValidator([
      RequiredValidator(errorText: 'Last name is required'),
      MinLengthValidator(2, errorText: 'Last name must be at least 2 characters long'),
      MaxLengthValidator(30, errorText: 'Last name must be less than 30 characters long'),
    ]);
  }
}
