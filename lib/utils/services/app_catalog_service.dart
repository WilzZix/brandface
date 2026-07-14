import 'dart:convert';

import 'package:brandface/data/models/profile/catalog/category_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/profile/catalog/language_model.dart';

abstract interface class IAppCatalogService {
  Future<void> saveSpokenLanguages(List<LanguageData> languages);

  List<LanguageData> getSpokenLanguages();

  Future<void> saveCategories(List<CategoryData> categories);

  List<CategoryData> getCategories();
}

final class AppCatalogService implements IAppCatalogService {
  final SharedPreferences _prefs;
  static const _languagesKey = 'cached_spoken_languages';
  static const _categoriesKey = 'cached_categories';

  AppCatalogService(this._prefs);

  @override
  Future<void> saveSpokenLanguages(List<LanguageData> languages) async {
    final String encoded = jsonEncode(
      languages.map((e) => e.toJson()).toList(),
    );
    await _prefs.setString(_languagesKey, encoded);
  }

  @override
  List<LanguageData> getSpokenLanguages() {
    final String? data = _prefs.getString(_languagesKey);
    if (data == null) return [];
    final List<dynamic> decoded = jsonDecode(data);
    return decoded.map((e) => LanguageData.fromJson(e)).toList();
  }

  @override
  List<CategoryData> getCategories() {
    final String? data = _prefs.getString(_categoriesKey);
    if (data == null) return [];
    final List<dynamic> decoded = jsonDecode(data);
    return decoded.map((e) => CategoryData.fromJson(e)).toList();
  }

  @override
  Future<void> saveCategories(List<CategoryData> categories) async {
    final String encoded = jsonEncode(
      categories.map((e) => e.toJson()).toList(),
    );
    await _prefs.setString(_categoriesKey, encoded);
  }
}
