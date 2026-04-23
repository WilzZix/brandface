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

extension PhoneFormatter on String {
  String toUzbekPhoneFormat() {
    // 1. Faqat raqamlarni qoldiramiz (bo'shliq va belgilarni olib tashlaymiz)
    String digits = replaceAll(RegExp(r'\D'), '');

    // 2. Agar raqam 998 bilan boshlansa va 12 ta raqam bo'lsa, shunchaki + qo'shamiz
    if (digits.length == 12 && digits.startsWith('998')) {
      return '+$digits';
    }

    // 3. Agar raqam 9 ta bo'lsa (masalan: 941234567), prefiks qo'shamiz
    if (digits.length == 9) {
      return '+998$digits';
    }

    // 4. Agar format kutilganidek bo'lmasa, boricha qaytaramiz yoki xohlagan formatga solamiz
    return this;
  }

  // Chiroyli ko'rinish uchun (Space bilan: +998 94 123 45 67)
  String toPrettyPhoneFormat() {
    String clean = toUzbekPhoneFormat().replaceAll('+', '');
    if (clean.length == 12) {
      return '+${clean.substring(0, 3)} ${clean.substring(3, 5)} ${clean.substring(5, 8)} ${clean.substring(8, 10)} ${clean.substring(10, 12)}';
    }
    return this;
  }
}
