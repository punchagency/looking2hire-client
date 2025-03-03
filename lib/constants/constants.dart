RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
String Function(Match) mathFunc = (Match match) => '${match[1]},';
// String currency = "₦";
String currency = "N";
String appLogoURL =
    "https://firebasestorage.googleapis.com/v0/b/konnectridesdb.appspot.com/o/logo.png?alt=media&token=ee010b22-c1aa-47bb-b0b6-ea3808ffe021";
