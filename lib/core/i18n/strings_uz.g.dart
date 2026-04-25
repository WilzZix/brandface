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
	late final TranslationsCommonUz common = TranslationsCommonUz._(_root);
	late final TranslationsProfileUz profile = TranslationsProfileUz._(_root);
	late final TranslationsValidationUz validation = TranslationsValidationUz._(_root);
	late final TranslationsChooseUz choose = TranslationsChooseUz._(_root);
	late final TranslationsContactUz contact = TranslationsContactUz._(_root);
	late final TranslationsOptionalItemsUz optional_items = TranslationsOptionalItemsUz._(_root);
	late final TranslationsHomeUz home = TranslationsHomeUz._(_root);
	late final TranslationsBrandUz brand = TranslationsBrandUz._(_root);
	late final TranslationsOfferUz offer = TranslationsOfferUz._(_root);
	late final TranslationsReviewsUz reviews = TranslationsReviewsUz._(_root);
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

	/// uz: 'SMS confirmation'
	String get sms_confirmation => 'SMS confirmation';

	/// uz: 'We have sent SMS code to your phone number **$phoneEnd, please enter this code'
	String sms_sent_to({required Object phoneEnd}) => 'We have sent SMS code to your phone number **${phoneEnd}, please enter this code';

	/// uz: 'Send code again'
	String get send_code_again => 'Send code again';
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

	/// uz: 'Full name'
	String get full_name => 'Full name';

	/// uz: 'Brand name'
	String get brand_name => 'Brand name';

	/// uz: 'Upload profile picture'
	String get upload_profile_picture => 'Upload profile picture';

	/// uz: 'Choose file'
	String get choose_file => 'Choose file';

	/// uz: 'SVG, PNG, JPG or GIF (MAX. 800x400px).'
	String get file_format_hint => 'SVG, PNG, JPG or GIF (MAX. 800x400px).';

	/// uz: 'Spoken languages'
	String get spoken_languages => 'Spoken languages';

	/// uz: 'Date of birth'
	String get date_of_birth => 'Date of birth';

	/// uz: 'Gender'
	String get gender => 'Gender';

	/// uz: 'Male'
	String get male => 'Male';

	/// uz: 'Female'
	String get female => 'Female';

	/// uz: 'Contact details'
	String get contact_details => 'Contact details';

	/// uz: 'Profile information'
	String get profile_information => 'Profile information';

	/// uz: 'Brand segment fit'
	String get brand_segment_fit => 'Brand segment fit';

	/// uz: 'Geography'
	String get geography => 'Geography';

	/// uz: 'Selected geography'
	String get selected_geography => 'Selected geography';

	/// uz: 'Social media accounts'
	String get social_media_accounts => 'Social media accounts';

	/// uz: 'Paste link here'
	String get paste_link_here => 'Paste link here';

	/// uz: 'Men'
	String get men => 'Men';

	/// uz: 'Women'
	String get women => 'Women';

	/// uz: 'Age from'
	String get age_from => 'Age from';

	/// uz: 'Age to'
	String get age_to => 'Age to';

	/// uz: 'Years of camera experience'
	String get years_of_camera_experience => 'Years of camera experience';

	/// uz: 'Write years of experience'
	String get write_years_of_experience => 'Write years of experience';

	/// uz: 'Optional experience'
	String get optional_experience => 'Optional experience';

	/// uz: 'Partners'
	String get partners => 'Partners';

	/// uz: 'Exclusivity availability'
	String get exclusivity_availability => 'Exclusivity availability';

	/// uz: 'Write award info here'
	String get write_award_info => 'Write award info here';

	/// uz: 'Years of experience'
	String get years_of_experience => 'Years of experience';

	/// uz: 'Niches'
	String get niches => 'Niches';

	/// uz: 'Selected niches'
	String get selected_niches => 'Selected niches';

	/// uz: 'Services'
	String get services => 'Services';

	/// uz: 'Currency'
	String get currency => 'Currency';

	/// uz: 'Min'
	String get min => 'Min';

	/// uz: 'Max'
	String get max => 'Max';

	/// uz: 'Write your hourly rate'
	String get write_hourly_rate => 'Write your hourly rate';

	/// uz: 'Projectly payment starting price'
	String get projectly_payment_starting_price => 'Projectly payment starting price';

	/// uz: 'Write starting price'
	String get write_starting_price => 'Write starting price';

	/// uz: 'Payment types'
	String get payment_types => 'Payment types';

	/// uz: 'Categories'
	String get categories => 'Categories';

	/// uz: 'Selected categories'
	String get selected_categories => 'Selected categories';

	/// uz: 'Experience in referral/promo code campaigns?'
	String get experience_in_referral => 'Experience in referral/promo code campaigns?';

	/// uz: 'Describe your experience'
	String get describe_your_experience => 'Describe your experience';

	/// uz: 'Region'
	String get region => 'Region';

	/// uz: 'City'
	String get city => 'City';

	/// uz: 'Sphere'
	String get sphere => 'Sphere';

	/// uz: 'Available for long-term contract?'
	String get available_for_long_term_contract => 'Available for long-term contract?';

	/// uz: 'KPI-based model'
	String get kpi_based_model => 'KPI-based model';

	/// uz: 'Available for offline events'
	String get available_for_offline_events => 'Available for offline events';

	/// uz: 'Pricing options'
	String get pricing_options => 'Pricing options';

	/// uz: 'do not have account'
	String get do_not_have_account => 'do not have account';

	/// uz: 'No languages found'
	String get no_languages_found => 'No languages found';

	/// uz: 'Creating reels'
	String get service_creating_reels_placeholder => 'Creating reels';

	/// uz: 'Business'
	String get niche_business_placeholder => 'Business';
}

// Path: common
class TranslationsCommonUz {
	TranslationsCommonUz._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// uz: 'Select'
	String get select => 'Select';

	/// uz: 'Confirm'
	String get confirm => 'Confirm';

	/// uz: 'Cancel'
	String get cancel => 'Cancel';

	/// uz: 'Apply'
	String get apply => 'Apply';

	/// uz: 'Delete'
	String get delete => 'Delete';

	/// uz: 'Yes'
	String get yes => 'Yes';

	/// uz: 'No'
	String get no => 'No';

	/// uz: 'Write text here...'
	String get write_text_here => 'Write text here...';

	/// uz: 'Please enter some text'
	String get please_enter_text => 'Please enter some text';

	/// uz: 'Email'
	String get email => 'Email';

	/// uz: 'Set as main'
	String get set_as_main => 'Set as main';

	/// uz: 'OK'
	String get ok => 'OK';

	/// uz: 'Submit'
	String get submit => 'Submit';

	/// uz: 'Loading...'
	String get loading => 'Loading...';

	/// uz: 'Deadline'
	String get deadline => 'Deadline';

	/// uz: 'Menu'
	String get menu => 'Menu';

	/// uz: 'Messages'
	String get messages => 'Messages';

	/// uz: 'Active offers'
	String get active_offers => 'Active offers';

	/// uz: 'Recommended for You'
	String get recommended_for_you => 'Recommended for You';

	/// uz: 'Offers from brands'
	String get offers_from_brands => 'Offers from brands';

	/// uz: 'Niche type'
	String get niche_type => 'Niche type';

	/// uz: 'Offer title here'
	String get offer_title_placeholder => 'Offer title here';
}

// Path: profile
class TranslationsProfileUz {
	TranslationsProfileUz._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// uz: 'Profile page'
	String get profile_page => 'Profile page';

	/// uz: 'Stats'
	String get stats => 'Stats';

	/// uz: 'Reviews'
	String get reviews => 'Reviews';

	/// uz: 'Calendar'
	String get calendar => 'Calendar';

	/// uz: 'Portfolio'
	String get portfolio => 'Portfolio';

	/// uz: 'Billing'
	String get billing => 'Billing';

	/// uz: 'Make the profile TOP'
	String get make_profile_top => 'Make the profile TOP';

	/// uz: 'App language'
	String get app_language => 'App language';

	/// uz: 'Terms and conditions'
	String get terms_and_conditions => 'Terms and conditions';

	/// uz: 'Log out'
	String get log_out => 'Log out';

	/// uz: 'General info'
	String get general_info => 'General info';

	/// uz: 'Audience and followers'
	String get audience_and_followers => 'Audience and followers';

	/// uz: 'Experience'
	String get experience => 'Experience';

	/// uz: 'Awards'
	String get awards => 'Awards';

	/// uz: 'Pricing / Tariffs'
	String get pricing_tariffs => 'Pricing / Tariffs';

	/// uz: 'Payment type'
	String get payment_type => 'Payment type';

	/// uz: 'Delete account'
	String get delete_account => 'Delete account';

	/// uz: 'Are you sure you want to delete your account? This action cannot be undone.'
	String get delete_account_confirm => 'Are you sure you want to delete your account? This action cannot be undone.';

	/// uz: 'Age $from - $to'
	String age_range({required Object from, required Object to}) => 'Age ${from} - ${to}';

	/// uz: 'Confirm delete'
	String get confirm_delete => 'Confirm delete';

	/// uz: 'Total followers'
	String get total_followers => 'Total followers';

	/// uz: 'Engagement rate'
	String get engagement_rate => 'Engagement rate';
}

// Path: validation
class TranslationsValidationUz {
	TranslationsValidationUz._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// uz: 'Please enter your name and surname'
	String get name_required => 'Please enter your name and surname';

	/// uz: 'Please enter your full name and surname'
	String get name_full_required => 'Please enter your full name and surname';

	/// uz: 'Name must contain only letters'
	String get name_letters_only => 'Name must contain only letters';

	/// uz: 'Name is too short'
	String get name_too_short => 'Name is too short';

	/// uz: 'Fill required fields'
	String get fill_required_fields => 'Fill required fields';

	/// uz: 'Account already added'
	String get account_already_added => 'Account already added';
}

// Path: choose
class TranslationsChooseUz {
	TranslationsChooseUz._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// uz: 'Select niche'
	String get select_niche => 'Select niche';

	/// uz: 'Select gender'
	String get select_gender => 'Select gender';

	/// uz: 'Select geography'
	String get select_geography => 'Select geography';

	/// uz: 'Select currency'
	String get select_currency => 'Select currency';

	/// uz: 'Select partners'
	String get select_partners => 'Select partners';

	/// uz: 'Select service'
	String get select_service => 'Select service';

	/// uz: 'Select date of birth'
	String get select_date_of_birth => 'Select date of birth';

	/// uz: 'Select contact detail'
	String get select_contact_detail => 'Select contact detail';

	/// uz: 'Spoken language'
	String get spoken_language => 'Spoken language';

	/// uz: 'Select region'
	String get select_region => 'Select region';

	/// uz: 'Select city'
	String get select_city => 'Select city';

	/// uz: 'Select sphere'
	String get select_sphere => 'Select sphere';
}

// Path: contact
class TranslationsContactUz {
	TranslationsContactUz._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// uz: 'Phone'
	String get phone => 'Phone';

	/// uz: 'Telegram'
	String get telegram => 'Telegram';

	/// uz: 'Instagram'
	String get instagram => 'Instagram';

	/// uz: 'Telegram user name'
	String get telegram_user_name => 'Telegram user name';

	/// uz: 'Instagram account'
	String get instagram_account => 'Instagram account';
}

// Path: optional_items
class TranslationsOptionalItemsUz {
	TranslationsOptionalItemsUz._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// uz: 'TV/Ad Experience'
	String get tv_ad_experience => 'TV/Ad Experience';

	/// uz: 'Press Mentions'
	String get press_mentions => 'Press Mentions';

	/// uz: 'Agency Representation'
	String get agency_representation => 'Agency Representation';

	/// uz: 'Previous brand collaborations'
	String get previous_brand_collaborations => 'Previous brand collaborations';

	/// uz: 'Case study link or screenshot'
	String get case_study_link => 'Case study link or screenshot';

	/// uz: 'Conversion metrics (if available)'
	String get conversion_metrics => 'Conversion metrics (if available)';

	/// uz: 'Willing to work on KPI-based model'
	String get willing_to_work_kpi => 'Willing to work on KPI-based model';

	/// uz: 'Campaign-based fee'
	String get campaign_based_fee => 'Campaign-based fee';

	/// uz: 'Event appearance fee'
	String get event_appearance_fee => 'Event appearance fee';
}

// Path: home
class TranslationsHomeUz {
	TranslationsHomeUz._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// uz: 'Offers and messages'
	String get offers_and_messages => 'Offers and messages';

	/// uz: 'Recommendations for you'
	String get recommendations_for_you => 'Recommendations for you';
}

// Path: brand
class TranslationsBrandUz {
	TranslationsBrandUz._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// uz: 'Brand'
	String get title => 'Brand';

	/// uz: 'Offers and applications'
	String get offers_and_applications => 'Offers and applications';

	/// uz: 'New applications'
	String get new_applications => 'New applications';

	/// uz: 'AI Matching'
	String get ai_matching => 'AI Matching';

	/// uz: 'TOP'
	String get top_label => 'TOP';

	/// uz: 'No active campaigns yet'
	String get no_active_campaigns_yet => 'No active campaigns yet';

	/// uz: 'Collaboration Offers'
	String get collaboration_offers => 'Collaboration Offers';

	/// uz: 'Brandfaces'
	String get brandfaces => 'Brandfaces';

	/// uz: 'Ambassadors'
	String get ambassadors => 'Ambassadors';

	/// uz: 'Influencers'
	String get influencers => 'Influencers';

	/// uz: 'Favourites'
	String get favourites => 'Favourites';

	/// uz: 'Analytics'
	String get analytics => 'Analytics';

	/// uz: 'Influencer'
	String get influencer_tab => 'Influencer';

	/// uz: 'Ambassadors'
	String get ambassadors_tab => 'Ambassadors';
}

// Path: offer
class TranslationsOfferUz {
	TranslationsOfferUz._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// uz: 'Offer details'
	String get offer_details => 'Offer details';

	/// uz: 'Offer title'
	String get offer_title => 'Offer title';

	/// uz: 'Description'
	String get description => 'Description';

	/// uz: 'Status'
	String get status => 'Status';

	/// uz: 'Requirements'
	String get requirements => 'Requirements';

	/// uz: 'Country'
	String get country => 'Country';

	/// uz: 'City'
	String get city => 'City';

	/// uz: 'Followers max'
	String get followers_max => 'Followers max';

	/// uz: 'Followers min'
	String get followers_min => 'Followers min';

	/// uz: 'Languages'
	String get languages => 'Languages';

	/// uz: 'Engagement rate'
	String get engagement_rate => 'Engagement rate';

	/// uz: 'Content type'
	String get content_type => 'Content type';

	/// uz: 'Gender'
	String get gender => 'Gender';

	/// uz: 'Collaboration Details'
	String get collaboration_details => 'Collaboration Details';

	/// uz: 'Duration'
	String get duration => 'Duration';

	/// uz: 'Visibility'
	String get visibility => 'Visibility';
}

// Path: reviews
class TranslationsReviewsUz {
	TranslationsReviewsUz._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// uz: 'Average'
	String get average => 'Average';

	/// uz: 'Client reviews'
	String get client_reviews => 'Client reviews';
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

	/// uz: 'Session expired'
	String get session_expired => 'Session expired';

	/// uz: 'You will be redirected to the login page to sign in again.'
	String get redirect_to_login => 'You will be redirected to the login page to sign in again.';

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
			'login.sms_confirmation' => 'SMS confirmation',
			'login.sms_sent_to' => ({required Object phoneEnd}) => 'We have sent SMS code to your phone number **${phoneEnd}, please enter this code',
			'login.send_code_again' => 'Send code again',
			'registration.title' => 'Registration',
			'registration.influencer' => 'Influencer',
			'registration.ambassador' => 'Ambassador',
			'registration.brand' => 'Brand',
			'registration.your_name' => 'Your name',
			'registration.your_surname' => 'Your surname',
			'registration.full_name' => 'Full name',
			'registration.brand_name' => 'Brand name',
			'registration.upload_profile_picture' => 'Upload profile picture',
			'registration.choose_file' => 'Choose file',
			'registration.file_format_hint' => 'SVG, PNG, JPG or GIF (MAX. 800x400px).',
			'registration.spoken_languages' => 'Spoken languages',
			'registration.date_of_birth' => 'Date of birth',
			'registration.gender' => 'Gender',
			'registration.male' => 'Male',
			'registration.female' => 'Female',
			'registration.contact_details' => 'Contact details',
			'registration.profile_information' => 'Profile information',
			'registration.brand_segment_fit' => 'Brand segment fit',
			'registration.geography' => 'Geography',
			'registration.selected_geography' => 'Selected geography',
			'registration.social_media_accounts' => 'Social media accounts',
			'registration.paste_link_here' => 'Paste link here',
			'registration.men' => 'Men',
			'registration.women' => 'Women',
			'registration.age_from' => 'Age from',
			'registration.age_to' => 'Age to',
			'registration.years_of_camera_experience' => 'Years of camera experience',
			'registration.write_years_of_experience' => 'Write years of experience',
			'registration.optional_experience' => 'Optional experience',
			'registration.partners' => 'Partners',
			'registration.exclusivity_availability' => 'Exclusivity availability',
			'registration.write_award_info' => 'Write award info here',
			'registration.years_of_experience' => 'Years of experience',
			'registration.niches' => 'Niches',
			'registration.selected_niches' => 'Selected niches',
			'registration.services' => 'Services',
			'registration.currency' => 'Currency',
			'registration.min' => 'Min',
			'registration.max' => 'Max',
			'registration.write_hourly_rate' => 'Write your hourly rate',
			'registration.projectly_payment_starting_price' => 'Projectly payment starting price',
			'registration.write_starting_price' => 'Write starting price',
			'registration.payment_types' => 'Payment types',
			'registration.categories' => 'Categories',
			'registration.selected_categories' => 'Selected categories',
			'registration.experience_in_referral' => 'Experience in referral/promo code campaigns?',
			'registration.describe_your_experience' => 'Describe your experience',
			'registration.region' => 'Region',
			'registration.city' => 'City',
			'registration.sphere' => 'Sphere',
			'registration.available_for_long_term_contract' => 'Available for long-term contract?',
			'registration.kpi_based_model' => 'KPI-based model',
			'registration.available_for_offline_events' => 'Available for offline events',
			'registration.pricing_options' => 'Pricing options',
			'registration.do_not_have_account' => 'do not have account',
			'registration.no_languages_found' => 'No languages found',
			'registration.service_creating_reels_placeholder' => 'Creating reels',
			'registration.niche_business_placeholder' => 'Business',
			'common.select' => 'Select',
			'common.confirm' => 'Confirm',
			'common.cancel' => 'Cancel',
			'common.apply' => 'Apply',
			'common.delete' => 'Delete',
			'common.yes' => 'Yes',
			'common.no' => 'No',
			'common.write_text_here' => 'Write text here...',
			'common.please_enter_text' => 'Please enter some text',
			'common.email' => 'Email',
			'common.set_as_main' => 'Set as main',
			'common.ok' => 'OK',
			'common.submit' => 'Submit',
			'common.loading' => 'Loading...',
			'common.deadline' => 'Deadline',
			'common.menu' => 'Menu',
			'common.messages' => 'Messages',
			'common.active_offers' => 'Active offers',
			'common.recommended_for_you' => 'Recommended for You',
			'common.offers_from_brands' => 'Offers from brands',
			'common.niche_type' => 'Niche type',
			'common.offer_title_placeholder' => 'Offer title here',
			'profile.profile_page' => 'Profile page',
			'profile.stats' => 'Stats',
			'profile.reviews' => 'Reviews',
			'profile.calendar' => 'Calendar',
			'profile.portfolio' => 'Portfolio',
			'profile.billing' => 'Billing',
			'profile.make_profile_top' => 'Make the profile TOP',
			'profile.app_language' => 'App language',
			'profile.terms_and_conditions' => 'Terms and conditions',
			'profile.log_out' => 'Log out',
			'profile.general_info' => 'General info',
			'profile.audience_and_followers' => 'Audience and followers',
			'profile.experience' => 'Experience',
			'profile.awards' => 'Awards',
			'profile.pricing_tariffs' => 'Pricing / Tariffs',
			'profile.payment_type' => 'Payment type',
			'profile.delete_account' => 'Delete account',
			'profile.delete_account_confirm' => 'Are you sure you want to delete your account? This action cannot be undone.',
			'profile.age_range' => ({required Object from, required Object to}) => 'Age ${from} - ${to}',
			'profile.confirm_delete' => 'Confirm delete',
			'profile.total_followers' => 'Total followers',
			'profile.engagement_rate' => 'Engagement rate',
			'validation.name_required' => 'Please enter your name and surname',
			'validation.name_full_required' => 'Please enter your full name and surname',
			'validation.name_letters_only' => 'Name must contain only letters',
			'validation.name_too_short' => 'Name is too short',
			'validation.fill_required_fields' => 'Fill required fields',
			'validation.account_already_added' => 'Account already added',
			'choose.select_niche' => 'Select niche',
			'choose.select_gender' => 'Select gender',
			'choose.select_geography' => 'Select geography',
			'choose.select_currency' => 'Select currency',
			'choose.select_partners' => 'Select partners',
			'choose.select_service' => 'Select service',
			'choose.select_date_of_birth' => 'Select date of birth',
			'choose.select_contact_detail' => 'Select contact detail',
			'choose.spoken_language' => 'Spoken language',
			'choose.select_region' => 'Select region',
			'choose.select_city' => 'Select city',
			'choose.select_sphere' => 'Select sphere',
			'contact.phone' => 'Phone',
			'contact.telegram' => 'Telegram',
			'contact.instagram' => 'Instagram',
			'contact.telegram_user_name' => 'Telegram user name',
			'contact.instagram_account' => 'Instagram account',
			'optional_items.tv_ad_experience' => 'TV/Ad Experience',
			'optional_items.press_mentions' => 'Press Mentions',
			'optional_items.agency_representation' => 'Agency Representation',
			'optional_items.previous_brand_collaborations' => 'Previous brand collaborations',
			'optional_items.case_study_link' => 'Case study link or screenshot',
			'optional_items.conversion_metrics' => 'Conversion metrics (if available)',
			'optional_items.willing_to_work_kpi' => 'Willing to work on KPI-based model',
			'optional_items.campaign_based_fee' => 'Campaign-based fee',
			'optional_items.event_appearance_fee' => 'Event appearance fee',
			'home.offers_and_messages' => 'Offers and messages',
			'home.recommendations_for_you' => 'Recommendations for you',
			'brand.title' => 'Brand',
			'brand.offers_and_applications' => 'Offers and applications',
			'brand.new_applications' => 'New applications',
			'brand.ai_matching' => 'AI Matching',
			'brand.top_label' => 'TOP',
			'brand.no_active_campaigns_yet' => 'No active campaigns yet',
			'brand.collaboration_offers' => 'Collaboration Offers',
			'brand.brandfaces' => 'Brandfaces',
			'brand.ambassadors' => 'Ambassadors',
			'brand.influencers' => 'Influencers',
			'brand.favourites' => 'Favourites',
			'brand.analytics' => 'Analytics',
			'brand.influencer_tab' => 'Influencer',
			'brand.ambassadors_tab' => 'Ambassadors',
			'offer.offer_details' => 'Offer details',
			'offer.offer_title' => 'Offer title',
			'offer.description' => 'Description',
			'offer.status' => 'Status',
			'offer.requirements' => 'Requirements',
			'offer.country' => 'Country',
			'offer.city' => 'City',
			'offer.followers_max' => 'Followers max',
			'offer.followers_min' => 'Followers min',
			'offer.languages' => 'Languages',
			'offer.engagement_rate' => 'Engagement rate',
			'offer.content_type' => 'Content type',
			'offer.gender' => 'Gender',
			'offer.collaboration_details' => 'Collaboration Details',
			'offer.duration' => 'Duration',
			'offer.visibility' => 'Visibility',
			'reviews.average' => 'Average',
			'reviews.client_reviews' => 'Client reviews',
			'errors.network' => 'Network connection problem, please check your internet',
			'errors.parsing' => 'Data processing error',
			'errors.unknown' => 'An unknown error occurred',
			'errors.session_expired' => 'Session expired',
			'errors.redirect_to_login' => 'You will be redirected to the login page to sign in again.',
			'errors.server.defaultMsg' => ({required Object code}) => 'Server error (${code})',
			'errors.server.badRequest' => 'Bad request',
			'errors.server.unauthorized' => 'Session expired, please log in again',
			'errors.server.notFound' => 'Resource not found',
			'errors.server.userExists' => 'User with this email already exists',
			_ => null,
		};
	}
}
