///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsUz = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.uz,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <uz>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	late final TranslationsSplashUz splash = TranslationsSplashUz._(_root);
	late final TranslationsOnboardingUz onboarding = TranslationsOnboardingUz._(_root);
	late final TranslationsLoginUz login = TranslationsLoginUz._(_root);
	late final TranslationsRegistrationUz registration = TranslationsRegistrationUz._(_root);
	late final TranslationsErrorsUz errors = TranslationsErrorsUz._(_root);
}

// Path: splash
class TranslationsSplashUz {
	TranslationsSplashUz._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// uz: 'App version $version'
	String app_version({required Object version}) => 'App version ${version}';
}

// Path: onboarding
class TranslationsOnboardingUz {
	TranslationsOnboardingUz._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// uz: 'Continue'
	String get kContinue => 'Continue';
}

// Path: login
class TranslationsLoginUz {
	TranslationsLoginUz._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// uz: 'Phone number'
	String get phone_number => 'Phone number';

	/// uz: 'Welcome to Findbrandface'
	String get welcome_msg => 'Welcome to Findbrandface';

	/// uz: 'By pressing Login i agree to all '
	String get term_of_use_first => 'By pressing Login i agree to all ';

	/// uz: 'terms of use'
	String get term_of_use_second => 'terms of use';

	/// uz: 'or login in with'
	String get login_methods => 'or login in with';
}

// Path: registration
class TranslationsRegistrationUz {
	TranslationsRegistrationUz._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// uz: 'Registration'
	String get title => 'Registration';

	/// uz: 'Influencer'
	String get influencer => 'Influencer';

	/// uz: 'Ambassador'
	String get ambassador => 'Ambassador';

	/// uz: 'Brand'
	String get brand => 'Brand';

	/// uz: 'Your name'
	String get your_name => 'Your name';

	/// uz: 'Your surname'
	String get your_surname => 'Your surname';
}

// Path: errors
class TranslationsErrorsUz {
	TranslationsErrorsUz._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// uz: 'Network connection problem, please check your internet'
	String get network => 'Network connection problem, please check your internet';

	/// uz: 'Data processing error'
	String get parsing => 'Data processing error';

	/// uz: 'An unknown error occurred'
	String get unknown => 'An unknown error occurred';

	late final TranslationsErrorsServerUz server = TranslationsErrorsServerUz._(_root);
}

// Path: errors.server
class TranslationsErrorsServerUz {
	TranslationsErrorsServerUz._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// uz: 'Server error ($code)'
	String defaultMsg({required Object code}) => 'Server error (${code})';

	/// uz: 'Bad request'
	String get badRequest => 'Bad request';

	/// uz: 'Session expired, please log in again'
	String get unauthorized => 'Session expired, please log in again';

	/// uz: 'Resource not found'
	String get notFound => 'Resource not found';

	/// uz: 'User with this email already exists'
	String get userExists => 'User with this email already exists';
}

/// The flat map containing all translations for locale <uz>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'splash.app_version' => ({required Object version}) => 'App version ${version}',
			'onboarding.kContinue' => 'Continue',
			'login.phone_number' => 'Phone number',
			'login.welcome_msg' => 'Welcome to Findbrandface',
			'login.term_of_use_first' => 'By pressing Login i agree to all ',
			'login.term_of_use_second' => 'terms of use',
			'login.login_methods' => 'or login in with',
			'registration.title' => 'Registration',
			'registration.influencer' => 'Influencer',
			'registration.ambassador' => 'Ambassador',
			'registration.brand' => 'Brand',
			'registration.your_name' => 'Your name',
			'registration.your_surname' => 'Your surname',
			'errors.network' => 'Network connection problem, please check your internet',
			'errors.parsing' => 'Data processing error',
			'errors.unknown' => 'An unknown error occurred',
			'errors.server.defaultMsg' => ({required Object code}) => 'Server error (${code})',
			'errors.server.badRequest' => 'Bad request',
			'errors.server.unauthorized' => 'Session expired, please log in again',
			'errors.server.notFound' => 'Resource not found',
			'errors.server.userExists' => 'User with this email already exists',
			_ => null,
		};
	}
}
