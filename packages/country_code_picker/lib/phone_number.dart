class PhoneNumber {
  String countryCodeName;
  String countryISOCode;
  String countryCode;
  String number = 'qw';

  PhoneNumber({
    required this.countryCodeName,
    required this.countryISOCode,
    required this.countryCode,
    required this.number,
  });

  String get completeNumber {
    return countryCode + number;
  }
}
