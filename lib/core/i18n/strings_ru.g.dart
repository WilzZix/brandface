///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsRu with BaseTranslations<AppLocale, Translations> implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsRu({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.ru,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <ru>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsRu _root = this; // ignore: unused_field

	@override 
	TranslationsRu $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsRu(meta: meta ?? this.$meta);

	// Translations
	@override late final _TranslationsSplashRu splash = _TranslationsSplashRu._(_root);
	@override late final _TranslationsOnboardingRu onboarding = _TranslationsOnboardingRu._(_root);
	@override late final _TranslationsLoginRu login = _TranslationsLoginRu._(_root);
	@override late final _TranslationsRegistrationRu registration = _TranslationsRegistrationRu._(_root);
}

// Path: splash
class _TranslationsSplashRu implements TranslationsSplashUz {
	_TranslationsSplashRu._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String app_version({required Object version}) => 'Версия приложения ${version}';
}

// Path: onboarding
class _TranslationsOnboardingRu implements TranslationsOnboardingUz {
	_TranslationsOnboardingRu._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get kContinue => 'Продолжить';
}

// Path: login
class _TranslationsLoginRu implements TranslationsLoginUz {
	_TranslationsLoginRu._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get phone_number => 'Номер телефона';
	@override String get welcome_msg => 'Добро пожаловать в Findbrandface';
	@override String get term_of_use_first => 'Нажимая «Войти», я принимаю все ';
	@override String get term_of_use_second => 'условия использования';
	@override String get login_methods => 'или войти через';
}

// Path: registration
class _TranslationsRegistrationRu implements TranslationsRegistrationUz {
	_TranslationsRegistrationRu._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Регистрация';
	@override String get influencer => 'Инфлюенсер';
	@override String get ambassador => 'Амбассадор';
	@override String get brand => 'Бренд';
	@override String get your_name => 'Ваше имя';
	@override String get your_surname => 'Ваша фамилия';
}

/// The flat map containing all translations for locale <ru>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsRu {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'splash.app_version' => ({required Object version}) => 'Версия приложения ${version}',
			'onboarding.kContinue' => 'Продолжить',
			'login.phone_number' => 'Номер телефона',
			'login.welcome_msg' => 'Добро пожаловать в Findbrandface',
			'login.term_of_use_first' => 'Нажимая «Войти», я принимаю все ',
			'login.term_of_use_second' => 'условия использования',
			'login.login_methods' => 'или войти через',
			'registration.title' => 'Регистрация',
			'registration.influencer' => 'Инфлюенсер',
			'registration.ambassador' => 'Амбассадор',
			'registration.brand' => 'Бренд',
			'registration.your_name' => 'Ваше имя',
			'registration.your_surname' => 'Ваша фамилия',
			_ => null,
		};
	}
}
