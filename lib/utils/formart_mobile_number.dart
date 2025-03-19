String formatPhoneWithCountryCode(String phoneNumber) {
  // Trim any whitespace
  String trimmedNumber = phoneNumber.trim();

  // If the number starts with "0", remove it and add "+234"
  if (trimmedNumber.startsWith('0')) {
    return '+234${trimmedNumber.substring(1)}';
  }
  // If the number doesn't start with "+234", add it
  else if (!trimmedNumber.startsWith('+234')) {
    return '+234$trimmedNumber';
  }

  // If it already has "+234", return as is
  return trimmedNumber;
}