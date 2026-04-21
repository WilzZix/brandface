import 'package:intl/intl.dart';

extension DateTimeUtils on DateTime {
  /// DateTime obyektini 11.11.2000 ko'rinishiga o'giradi
  String toDotFormat() {
    return DateFormat('dd.MM.yyyy').format(this);
  }

  /// Agar vaqt ham kerak bo'lsa: 11.11.2000 14:30
  String toDotDateTimeFormat() {
    return DateFormat('dd.MM.yyyy HH:mm').format(this);
  }
}

extension StringCasingExtension on String {
  /// Birinchi harfni katta qiladi: "uzbek" -> "Uzbek"
  String toCapitalized() {
    if (isEmpty) return this;
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  /// Har bir so'zning birinchi harfini katta qiladi: "john doe" -> "John Doe"
  String toTitleCase() {
    if (isEmpty) return this;
    return split(' ').map((str) => str.toCapitalized()).join(' ');
  }
}
