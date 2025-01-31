import 'package:app_management_system/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzdata;

void showSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
      action: SnackBarAction(
        label: 'Close',
        textColor: Theme.of(context).colorScheme.inversePrimary,
        onPressed: ScaffoldMessenger.of(context).hideCurrentSnackBar,
      ),
    ),
  );
}

bool isEmptyUUID(String text) {
  return text.isEmpty || text == '00000000-0000-0000-0000-000000000000';
}

/// probably delete later
String toTitleCase(String? text) {
  if (text == null || text.isEmpty) {
    return '';
  }

  return text
      .toLowerCase()
      .split(' ')
      .map((word) =>
          word.isEmpty ? '' : word[0].toUpperCase() + word.substring(1))
      .join(' ');
}

String formatRupiah(dynamic amount) {
  // print("nilai amount rupiah $amount");
  // print("nilai amount kebaca ${amount.runtimeType}");
  if (amount != null && amount != 'null') {
    if (amount is String) {
      amount = int.tryParse(amount);
    }
    return 'Rp ${amount.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  }
  return "Rp 0";
}

String formatNominal(dynamic amount) {
  // print("nilai amount rupiah $amount");
  // print("nilai amount kebaca ${amount.runtimeType}");
  if (amount != null && amount != 'null') {
    if (amount is String) {
      amount = int.tryParse(amount);
    }
    return '${amount.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  }
  return "0";
}

String formatPercentage(dynamic value) {
  return "${(value! * 100).round()} %";
}

String formatDateTime(String? initDate) {
  // String input = "2024-02-20T11:00:00";
  if (initDate != null) {
    DateTime dateTime = DateTime.parse(initDate);
    String formattedDate = DateFormat('dd-MM-yyyy HH:mm').format(dateTime);
    return formattedDate;
  }
  return "";
}

Color colorPicker(String? status) {
  switch (status) {
    case 'Loading':
      return AppColors.kErrorColor;
    case 'Picked':
      return AppColors.kWarningColor;
    case 'Finished':
      return AppColors.kSuccessColor;
    default:
      return AppColors.kErrorColor;
  }
}

List<String> getTextAfterPipe(String text) {
  // Split the string by the pipe character
  List<String> parts = text.split('|');

  print("$text");

  // Check if the split operation found any '|' and thus split into at least two parts
  if (parts.length > 1) {
    return [
      parts[0].split('/').map((str) => toTitleCase(str)).join('/'),
      parts[1]
    ]; // Return both parts
  } else {
    return [
      text,
      'UTC'
    ]; // Return the original text and an empty string if no '|' was found
  }
}

// Timezone Offset
String convertTimeZone(DateTime utcTime, String timetext) {
  // Initialize timezone data
  tzdata.initializeTimeZones();

  // Get the timezone abbreviation based on the offset
  var timezoneAbbr = getTextAfterPipe(timetext);

  // Convert the UTC time to the local time based on offset
  // var location = tz.getLocation(timezoneAbbr[0]);
  var location = tz.getLocation(timezoneAbbr[0]);
  var convertedTime = tz.TZDateTime.from(utcTime, location);

  // Format the datetime object to the specified format with timezone abbreviation
  var formatter = DateFormat("dd/MM/yyyy HH:mm");
  var formattedTime =
      "${formatter.format(convertedTime.toLocal())} ${timezoneAbbr.isEmpty ? '' : timezoneAbbr[1]}";

  return formattedTime;
}
// End Timezone Offset



// Timezone Offset
(String, String) formatTimezone(DateTime utcTime, String timetext) {
  // Initialize timezone data
  tzdata.initializeTimeZones();

  // Get the timezone abbreviation based on the offset
  var timezoneAbbr = getTextAfterPipe(timetext);

  // Convert the UTC time to the local time based on offset
  // var location = tz.getLocation(timezoneAbbr[0]);
  var location = tz.getLocation(timezoneAbbr[0]);
  var convertedTime = tz.TZDateTime.from(utcTime, location);

  // Format the datetime object to the specified format with timezone abbreviation
  var formatterDate = DateFormat("dd/MM/yyyy");
  var formatterTime = DateFormat("HH:mm");
  var local = convertedTime.toLocal();

  return (formatterDate.format(local), '${formatterTime.format(local)} ${timezoneAbbr.isEmpty ? '' : timezoneAbbr[1]}');
}
// End Timezone Offset

/// Parse a value onto double, otherwise returns 0.0
double toDoubleSafe(dynamic value) {
  return double.tryParse(value.toString()) ?? 0.0;
}

class TypeCaster {
  static bool intoBool(dynamic value) {
    return bool.tryParse(value.toString()) ?? false;
  }

  static String intoString(dynamic value) {
    return value != null ? value.toString() : '';
  }

  static int intoInt(dynamic value) {
    return int.tryParse(value.toString()) ?? 0;
  }

  static double intoDouble(dynamic value) {
    return double.tryParse(value.toString()) ?? 0.0;
  }

  static DateTime intoDateTime(dynamic value) {
    return DateTime.parse(value);
  }

  static DateTime fromISOToDateTime(dynamic value) {
    return DateFormat('yyyy-MM-ddTHH:mm:ssZ').parse(value);
  }
}
