class Validators {
  static String? required(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  static String? minLength(String? value, int length) {
    if (value != null && value.length < length) {
      return 'Must be at least $length characters';
    }
    return null;
  }
}
