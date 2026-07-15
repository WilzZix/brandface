///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
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
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	late final TranslationsSplashEn splash = TranslationsSplashEn._(_root);
	late final TranslationsOnboardingEn onboarding = TranslationsOnboardingEn._(_root);
	late final TranslationsLoginEn login = TranslationsLoginEn._(_root);
	late final TranslationsRegistrationEn registration = TranslationsRegistrationEn._(_root);
	late final TranslationsCommonEn common = TranslationsCommonEn._(_root);
	late final TranslationsProfileEn profile = TranslationsProfileEn._(_root);
	late final TranslationsValidationEn validation = TranslationsValidationEn._(_root);
	late final TranslationsChooseEn choose = TranslationsChooseEn._(_root);
	late final TranslationsContactEn contact = TranslationsContactEn._(_root);
	late final TranslationsOptionalItemsEn optional_items = TranslationsOptionalItemsEn._(_root);
	late final TranslationsHomeEn home = TranslationsHomeEn._(_root);
	late final TranslationsBrandEn brand = TranslationsBrandEn._(_root);
	late final TranslationsOfferEn offer = TranslationsOfferEn._(_root);
	late final TranslationsReviewsEn reviews = TranslationsReviewsEn._(_root);
	late final TranslationsNotificationsEn notifications = TranslationsNotificationsEn._(_root);
	late final TranslationsBillingEn billing = TranslationsBillingEn._(_root);
	late final TranslationsErrorsEn errors = TranslationsErrorsEn._(_root);
	late final TranslationsAnalyticsEn analytics = TranslationsAnalyticsEn._(_root);
	late final TranslationsBillingUiEn billing_ui = TranslationsBillingUiEn._(_root);
	late final TranslationsAmbassadorEn ambassador = TranslationsAmbassadorEn._(_root);
	late final TranslationsPortfolioUiEn portfolio_ui = TranslationsPortfolioUiEn._(_root);
	late final TranslationsCollabEn collab = TranslationsCollabEn._(_root);
	late final TranslationsMiscEn misc = TranslationsMiscEn._(_root);
}

// Path: splash
class TranslationsSplashEn {
	TranslationsSplashEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'App version $version'
	String app_version({required Object version}) => 'App version ${version}';
}

// Path: onboarding
class TranslationsOnboardingEn {
	TranslationsOnboardingEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Continue'
	String get kContinue => 'Continue';

	/// en: 'InflueraX — the modern influencer marketing platform connecting brands, influencers and ambassadors in one place.'
	String get description => 'InflueraX — the modern influencer marketing platform connecting brands, influencers and ambassadors in one place.';
}

// Path: login
class TranslationsLoginEn {
	TranslationsLoginEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Phone number'
	String get phone_number => 'Phone number';

	/// en: 'Welcome to InflueraX'
	String get welcome_msg => 'Welcome to InflueraX';

	/// en: 'By pressing Login i agree to all '
	String get term_of_use_first => 'By pressing Login i agree to all ';

	/// en: 'terms of use'
	String get term_of_use_second => 'terms of use';

	/// en: 'or continue with'
	String get login_methods => 'or continue with';

	/// en: 'SMS confirmation'
	String get sms_confirmation => 'SMS confirmation';

	/// en: 'We have sent SMS code to your phone number **$phoneEnd, please enter this code'
	String sms_sent_to({required Object phoneEnd}) => 'We have sent SMS code to your phone number **${phoneEnd}, please enter this code';

	/// en: 'Send code again'
	String get send_code_again => 'Send code again';

	/// en: 'Coming soon'
	String get soon_title => 'Coming soon';

	/// en: 'Login with $provider will be available soon.'
	String soon_message({required Object provider}) => 'Login with ${provider} will be available soon.';

	/// en: 'Social login failed'
	String get social_login_failed => 'Social login failed';

	/// en: 'Sign-in was cancelled'
	String get social_login_cancelled => 'Sign-in was cancelled';

	/// en: 'Sign in with LinkedIn'
	String get linkedin_title => 'Sign in with LinkedIn';

	/// en: 'Sign in with Telegram'
	String get telegram_title => 'Sign in with Telegram';
}

// Path: registration
class TranslationsRegistrationEn {
	TranslationsRegistrationEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Registration'
	String get title => 'Registration';

	/// en: 'Influencer'
	String get influencer => 'Influencer';

	/// en: 'Ambassador'
	String get ambassador => 'Ambassador';

	/// en: 'Brand'
	String get brand => 'Brand';

	/// en: 'Your name'
	String get your_name => 'Your name';

	/// en: 'Your surname'
	String get your_surname => 'Your surname';

	/// en: 'Full name'
	String get full_name => 'Full name';

	/// en: 'Brand name'
	String get brand_name => 'Brand name';

	/// en: 'Upload profile picture'
	String get upload_profile_picture => 'Upload profile picture';

	/// en: 'Choose file'
	String get choose_file => 'Choose file';

	/// en: 'SVG, PNG, JPG or GIF (MAX. 800x400px).'
	String get file_format_hint => 'SVG, PNG, JPG or GIF (MAX. 800x400px).';

	/// en: 'Spoken languages'
	String get spoken_languages => 'Spoken languages';

	/// en: 'Date of birth'
	String get date_of_birth => 'Date of birth';

	/// en: 'Gender'
	String get gender => 'Gender';

	/// en: 'Male'
	String get male => 'Male';

	/// en: 'Female'
	String get female => 'Female';

	/// en: 'Contact details'
	String get contact_details => 'Contact details';

	/// en: 'Profile information'
	String get profile_information => 'Profile information';

	/// en: 'Brand segment fit'
	String get brand_segment_fit => 'Brand segment fit';

	/// en: 'Geography'
	String get geography => 'Geography';

	/// en: 'Selected geography'
	String get selected_geography => 'Selected geography';

	/// en: 'Social media accounts'
	String get social_media_accounts => 'Social media accounts';

	/// en: 'Paste link here'
	String get paste_link_here => 'Paste link here';

	/// en: 'Men'
	String get men => 'Men';

	/// en: 'Women'
	String get women => 'Women';

	/// en: 'Age from'
	String get age_from => 'Age from';

	/// en: 'Age to'
	String get age_to => 'Age to';

	/// en: 'Years of camera experience'
	String get years_of_camera_experience => 'Years of camera experience';

	/// en: 'Write years of experience'
	String get write_years_of_experience => 'Write years of experience';

	/// en: 'Optional experience'
	String get optional_experience => 'Optional experience';

	/// en: 'Partners'
	String get partners => 'Partners';

	/// en: 'Exclusivity availability'
	String get exclusivity_availability => 'Exclusivity availability';

	/// en: 'Write award info here'
	String get write_award_info => 'Write award info here';

	/// en: 'Years of experience'
	String get years_of_experience => 'Years of experience';

	/// en: 'Niches'
	String get niches => 'Niches';

	/// en: 'Selected niches'
	String get selected_niches => 'Selected niches';

	/// en: 'Services'
	String get services => 'Services';

	/// en: 'Currency'
	String get currency => 'Currency';

	/// en: 'Min'
	String get min => 'Min';

	/// en: 'Max'
	String get max => 'Max';

	/// en: 'Write your hourly rate'
	String get write_hourly_rate => 'Write your hourly rate';

	/// en: 'Projectly payment starting price'
	String get projectly_payment_starting_price => 'Projectly payment starting price';

	/// en: 'Write starting price'
	String get write_starting_price => 'Write starting price';

	/// en: 'Payment types'
	String get payment_types => 'Payment types';

	/// en: 'Categories'
	String get categories => 'Categories';

	/// en: 'Selected categories'
	String get selected_categories => 'Selected categories';

	/// en: 'Experience in referral/promo code campaigns?'
	String get experience_in_referral => 'Experience in referral/promo code campaigns?';

	/// en: 'Describe your experience'
	String get describe_your_experience => 'Describe your experience';

	/// en: 'Region'
	String get region => 'Region';

	/// en: 'City'
	String get city => 'City';

	/// en: 'Sphere'
	String get sphere => 'Sphere';

	/// en: 'Available for long-term contract?'
	String get available_for_long_term_contract => 'Available for long-term contract?';

	/// en: 'KPI-based model'
	String get kpi_based_model => 'KPI-based model';

	/// en: 'Available for offline events'
	String get available_for_offline_events => 'Available for offline events';

	/// en: 'Pricing options'
	String get pricing_options => 'Pricing options';

	/// en: 'do not have account'
	String get do_not_have_account => 'do not have account';

	/// en: 'No languages found'
	String get no_languages_found => 'No languages found';

	/// en: 'Creating reels'
	String get service_creating_reels_placeholder => 'Creating reels';

	/// en: 'Business'
	String get niche_business_placeholder => 'Business';
}

// Path: common
class TranslationsCommonEn {
	TranslationsCommonEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Select'
	String get select => 'Select';

	/// en: 'Confirm'
	String get confirm => 'Confirm';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Apply'
	String get apply => 'Apply';

	/// en: 'Delete'
	String get delete => 'Delete';

	/// en: 'Yes'
	String get yes => 'Yes';

	/// en: 'No'
	String get no => 'No';

	/// en: 'Write text here...'
	String get write_text_here => 'Write text here...';

	/// en: 'Please enter some text'
	String get please_enter_text => 'Please enter some text';

	/// en: 'Email'
	String get email => 'Email';

	/// en: 'Set as main'
	String get set_as_main => 'Set as main';

	/// en: 'OK'
	String get ok => 'OK';

	/// en: 'Submit'
	String get submit => 'Submit';

	/// en: 'Loading...'
	String get loading => 'Loading...';

	/// en: 'Deadline'
	String get deadline => 'Deadline';

	/// en: 'Menu'
	String get menu => 'Menu';

	/// en: 'Messages'
	String get messages => 'Messages';

	/// en: 'Active offers'
	String get active_offers => 'Active offers';

	/// en: 'Recommended for You'
	String get recommended_for_you => 'Recommended for You';

	/// en: 'Offers from brands'
	String get offers_from_brands => 'Offers from brands';

	/// en: 'Niche type'
	String get niche_type => 'Niche type';

	/// en: 'Offer title here'
	String get offer_title_placeholder => 'Offer title here';

	/// en: 'Try again'
	String get try_again => 'Try again';

	/// en: 'Back'
	String get back => 'Back';

	/// en: 'Any'
	String get any => 'Any';

	/// en: 'Not specified'
	String get not_specified => 'Not specified';

	/// en: 'Unknown'
	String get unknown => 'Unknown';

	/// en: 'Unknown date'
	String get unknown_date => 'Unknown date';

	/// en: 'Pull to refresh or try again.'
	String get pull_refresh_or_retry => 'Pull to refresh or try again.';

	/// en: 'Pull to refresh and check again soon.'
	String get pull_refresh_check_soon => 'Pull to refresh and check again soon.';

	/// en: 'An error occurred'
	String get error_occurred => 'An error occurred';

	/// en: 'Open'
	String get open => 'Open';

	/// en: 'DD.MM.YYYY'
	String get date_format_hint => 'DD.MM.YYYY';

	/// en: 'Continue'
	String get continue_label => 'Continue';

	/// en: 'General'
	String get general => 'General';

	/// en: 'Requirements'
	String get requirements_label => 'Requirements';

	/// en: 'Details'
	String get details_label => 'Details';

	/// en: 'Select country'
	String get select_country => 'Select country';

	/// en: 'Select visibility'
	String get select_visibility => 'Select visibility';

	/// en: 'Age range'
	String get age_range => 'Age range';

	/// en: 'Public'
	String get public => 'Public';

	/// en: 'Private'
	String get private => 'Private';

	/// en: '1 week'
	String get duration_1_week => '1 week';

	/// en: '2 weeks'
	String get duration_2_weeks => '2 weeks';

	/// en: '1 month'
	String get duration_1_month => '1 month';

	/// en: '2 months'
	String get duration_2_months => '2 months';

	/// en: '3 months'
	String get duration_3_months => '3 months';

	/// en: 'Default'
	String get default_label => 'Default';

	/// en: 'Set default'
	String get set_default => 'Set default';

	/// en: 'No contact details'
	String get no_contact_details => 'No contact details';
}

// Path: profile
class TranslationsProfileEn {
	TranslationsProfileEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Profile page'
	String get profile_page => 'Profile page';

	/// en: 'Stats'
	String get stats => 'Stats';

	/// en: 'Reviews'
	String get reviews => 'Reviews';

	/// en: 'Calendar'
	String get calendar => 'Calendar';

	/// en: 'Portfolio'
	String get portfolio => 'Portfolio';

	/// en: 'Billing'
	String get billing => 'Billing';

	/// en: 'Make the profile TOP'
	String get make_profile_top => 'Make the profile TOP';

	/// en: 'App language'
	String get app_language => 'App language';

	/// en: 'Terms and conditions'
	String get terms_and_conditions => 'Terms and conditions';

	/// en: 'Log out'
	String get log_out => 'Log out';

	/// en: 'General info'
	String get general_info => 'General info';

	/// en: 'Audience and followers'
	String get audience_and_followers => 'Audience and followers';

	/// en: 'Experience'
	String get experience => 'Experience';

	/// en: 'Awards'
	String get awards => 'Awards';

	/// en: 'Pricing / Tariffs'
	String get pricing_tariffs => 'Pricing / Tariffs';

	/// en: 'Payment type'
	String get payment_type => 'Payment type';

	/// en: 'Delete account'
	String get delete_account => 'Delete account';

	/// en: 'Are you sure you want to delete your account? This action cannot be undone.'
	String get delete_account_confirm => 'Are you sure you want to delete your account? This action cannot be undone.';

	/// en: 'Age $from - $to'
	String age_range({required Object from, required Object to}) => 'Age ${from} - ${to}';

	/// en: 'Confirm delete'
	String get confirm_delete => 'Confirm delete';

	/// en: 'Type your name $name to confirm account deletion.'
	String delete_account_type_name({required Object name}) => 'Type your name ${name} to confirm account deletion.';

	/// en: 'Enter your name'
	String get delete_account_type_name_hint => 'Enter your name';

	/// en: 'Name does not match.'
	String get delete_account_name_mismatch => 'Name does not match.';

	/// en: 'Total followers'
	String get total_followers => 'Total followers';

	/// en: 'Engagement rate'
	String get engagement_rate => 'Engagement rate';
}

// Path: validation
class TranslationsValidationEn {
	TranslationsValidationEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Please enter your name and surname'
	String get name_required => 'Please enter your name and surname';

	/// en: 'Please enter your full name and surname'
	String get name_full_required => 'Please enter your full name and surname';

	/// en: 'Name must contain only letters'
	String get name_letters_only => 'Name must contain only letters';

	/// en: 'Name is too short'
	String get name_too_short => 'Name is too short';

	/// en: 'Fill required fields'
	String get fill_required_fields => 'Fill required fields';

	/// en: 'Account already added'
	String get account_already_added => 'Account already added';

	/// en: 'Please enter your phone number'
	String get phone_required => 'Please enter your phone number';

	/// en: 'Please enter a valid phone number'
	String get phone_invalid => 'Please enter a valid phone number';
}

// Path: choose
class TranslationsChooseEn {
	TranslationsChooseEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Select niche'
	String get select_niche => 'Select niche';

	/// en: 'Select gender'
	String get select_gender => 'Select gender';

	/// en: 'Select geography'
	String get select_geography => 'Select geography';

	/// en: 'Select currency'
	String get select_currency => 'Select currency';

	/// en: 'Select partners'
	String get select_partners => 'Select partners';

	/// en: 'Select service'
	String get select_service => 'Select service';

	/// en: 'Select date of birth'
	String get select_date_of_birth => 'Select date of birth';

	/// en: 'Select contact detail'
	String get select_contact_detail => 'Select contact detail';

	/// en: 'Spoken language'
	String get spoken_language => 'Spoken language';

	/// en: 'Select region'
	String get select_region => 'Select region';

	/// en: 'Select city'
	String get select_city => 'Select city';

	/// en: 'Select sphere'
	String get select_sphere => 'Select sphere';

	/// en: 'Select payment type'
	String get select_payment_type => 'Select payment type';
}

// Path: contact
class TranslationsContactEn {
	TranslationsContactEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Phone'
	String get phone => 'Phone';

	/// en: 'Telegram'
	String get telegram => 'Telegram';

	/// en: 'Instagram'
	String get instagram => 'Instagram';

	/// en: 'Telegram user name'
	String get telegram_user_name => 'Telegram user name';

	/// en: 'Instagram account'
	String get instagram_account => 'Instagram account';

	/// en: 'No contact details'
	String get no_contact_details => 'No contact details';
}

// Path: optional_items
class TranslationsOptionalItemsEn {
	TranslationsOptionalItemsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'TV/Ad Experience'
	String get tv_ad_experience => 'TV/Ad Experience';

	/// en: 'Press Mentions'
	String get press_mentions => 'Press Mentions';

	/// en: 'Agency Representation'
	String get agency_representation => 'Agency Representation';

	/// en: 'Previous brand collaborations'
	String get previous_brand_collaborations => 'Previous brand collaborations';

	/// en: 'Case study link or screenshot'
	String get case_study_link => 'Case study link or screenshot';

	/// en: 'Conversion metrics (if available)'
	String get conversion_metrics => 'Conversion metrics (if available)';

	/// en: 'Willing to work on KPI-based model'
	String get willing_to_work_kpi => 'Willing to work on KPI-based model';

	/// en: 'Campaign-based fee'
	String get campaign_based_fee => 'Campaign-based fee';

	/// en: 'Event appearance fee'
	String get event_appearance_fee => 'Event appearance fee';
}

// Path: home
class TranslationsHomeEn {
	TranslationsHomeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Offers and messages'
	String get offers_and_messages => 'Offers and messages';

	/// en: 'Recommendations for you'
	String get recommendations_for_you => 'Recommendations for you';

	/// en: 'Flexible'
	String get flexible_reward => 'Flexible';

	/// en: 'New recommendation tailored to your profile.'
	String get new_recommendation => 'New recommendation tailored to your profile.';

	/// en: 'Home page data could not be loaded.'
	String get error_load => 'Home page data could not be loaded.';

	/// en: 'Recommendations will appear here once matching results are ready.'
	String get empty_recommendations => 'Recommendations will appear here once matching results are ready.';

	/// en: 'Your profile is still under review. Offers and recommendations will appear after approval.'
	String get pending_approval_text => 'Your profile is still under review. Offers and recommendations will appear after approval.';

	/// en: 'Your profile is pending approval. Messages and notifications are available now, and offer tools will unlock after moderation.'
	String get pending_approval_banner => 'Your profile is pending approval. Messages and notifications are available now, and offer tools will unlock after moderation.';
}

// Path: brand
class TranslationsBrandEn {
	TranslationsBrandEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Brand'
	String get title => 'Brand';

	/// en: 'Offers and applications'
	String get offers_and_applications => 'Offers and applications';

	/// en: 'New applications'
	String get new_applications => 'New applications';

	/// en: 'AI Matching'
	String get ai_matching => 'AI Matching';

	/// en: 'TOP'
	String get top_label => 'TOP';

	/// en: 'No active campaigns yet'
	String get no_active_campaigns_yet => 'No active campaigns yet';

	/// en: 'Collaboration Offers'
	String get collaboration_offers => 'Collaboration Offers';

	/// en: 'Brandfaces'
	String get brandfaces => 'Brandfaces';

	/// en: 'Ambassadors'
	String get ambassadors => 'Ambassadors';

	/// en: 'Influencers'
	String get influencers => 'Influencers';

	/// en: 'Favourites'
	String get favourites => 'Favourites';

	/// en: 'Analytics'
	String get analytics => 'Analytics';

	/// en: 'Influencer'
	String get influencer_tab => 'Influencer';

	/// en: 'Ambassadors'
	String get ambassadors_tab => 'Ambassadors';

	/// en: 'Brand profile'
	String get brand_profile => 'Brand profile';

	/// en: 'Website'
	String get website => 'Website';

	/// en: 'Actives'
	String get actives => 'Actives';

	/// en: 'Archived'
	String get archived => 'Archived';

	/// en: 'Views'
	String get views => 'Views';

	/// en: 'Applications'
	String get applications => 'Applications';

	/// en: 'Search'
	String get search => 'Search';

	/// en: 'New offer'
	String get new_offer => 'New offer';

	/// en: 'Sort by'
	String get sort_by => 'Sort by';

	/// en: 'Sort by ranking'
	String get sort_by_ranking => 'Sort by ranking';

	/// en: 'Sort by newly joined'
	String get sort_by_newly_joined => 'Sort by newly joined';

	/// en: 'Sort by number of followers'
	String get sort_by_followers => 'Sort by number of followers';

	/// en: 'Sort by experience'
	String get sort_by_experience => 'Sort by experience';

	/// en: 'Sort by views'
	String get sort_by_views => 'Sort by views';

	/// en: 'Sort by applications'
	String get sort_by_applications => 'Sort by applications';

	/// en: 'Filter'
	String get filter => 'Filter';

	/// en: 'Rank type'
	String get rank_type => 'Rank type';

	/// en: 'VIP'
	String get vip_label => 'VIP';

	/// en: '$count ambassadors found'
	String ambassadors_found({required Object count}) => '${count} ambassadors found';

	/// en: 'No ambassadors found'
	String get no_ambassadors_found => 'No ambassadors found';

	/// en: '$count followers'
	String followers_count({required Object count}) => '${count} followers';

	/// en: '$count years exp.'
	String years_experience({required Object count}) => '${count} years exp.';

	/// en: 'Collaboration offer details'
	String get collaboration_offer_details => 'Collaboration offer details';

	/// en: 'Failed to load offer.'
	String get offer_failed_load => 'Failed to load offer.';

	/// en: 'Complete'
	String get offer_complete => 'Complete';
}

// Path: offer
class TranslationsOfferEn {
	TranslationsOfferEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Offer details'
	String get offer_details => 'Offer details';

	/// en: 'Offer title'
	String get offer_title => 'Offer title';

	/// en: 'Description'
	String get description => 'Description';

	/// en: 'Status'
	String get status => 'Status';

	/// en: 'Requirements'
	String get requirements => 'Requirements';

	/// en: 'Country'
	String get country => 'Country';

	/// en: 'City'
	String get city => 'City';

	/// en: 'Followers max'
	String get followers_max => 'Followers max';

	/// en: 'Followers min'
	String get followers_min => 'Followers min';

	/// en: 'Languages'
	String get languages => 'Languages';

	/// en: 'Engagement rate'
	String get engagement_rate => 'Engagement rate';

	/// en: 'Content type'
	String get content_type => 'Content type';

	/// en: 'Gender'
	String get gender => 'Gender';

	/// en: 'Collaboration Details'
	String get collaboration_details => 'Collaboration Details';

	/// en: 'Duration'
	String get duration => 'Duration';

	/// en: 'Visibility'
	String get visibility => 'Visibility';

	/// en: 'Application submitted successfully.'
	String get application_submitted => 'Application submitted successfully.';

	/// en: 'Offer could not be opened.'
	String get error_could_not_open => 'Offer could not be opened.';

	/// en: 'Offer ID was not provided.'
	String get error_no_id => 'Offer ID was not provided.';

	/// en: 'Pull back and try opening the offer again.'
	String get error_retry_message => 'Pull back and try opening the offer again.';

	/// en: 'Offer not found.'
	String get not_found => 'Offer not found.';

	/// en: 'No detail data is available for this offer.'
	String get no_detail_data => 'No detail data is available for this offer.';

	/// en: 'Apply to this offer'
	String get apply_title => 'Apply to this offer';

	/// en: 'Add an optional cover letter for your application.'
	String get cover_letter_subtitle => 'Add an optional cover letter for your application.';

	/// en: 'Cover letter'
	String get cover_letter_label => 'Cover letter';

	/// en: 'Write a short message here'
	String get cover_letter_hint => 'Write a short message here';

	/// en: 'Submit application'
	String get submit_application => 'Submit application';

	/// en: 'Continue without cover letter'
	String get continue_without_cover_letter => 'Continue without cover letter';

	/// en: 'General info'
	String get general_info => 'General info';

	/// en: 'No category'
	String get no_category => 'No category';

	/// en: 'Add new collaboration offer'
	String get create_title => 'Add new collaboration offer';

	/// en: 'Write offer title'
	String get title_hint => 'Write offer title';

	/// en: 'Applied'
	String get applied => 'Applied';

	/// en: 'Submitting...'
	String get submitting => 'Submitting...';

	/// en: 'Apply now'
	String get apply_now => 'Apply now';

	/// en: 'No deadline'
	String get no_deadline => 'No deadline';

	/// en: 'Open'
	String get open_deadline => 'Open';

	/// en: 'Reward'
	String get reward => 'Reward';

	/// en: 'No offers are available right now.'
	String get no_offers_available => 'No offers are available right now.';

	/// en: 'No offers found for $niche.'
	String no_offers_for_niche({required Object niche}) => 'No offers found for ${niche}.';

	/// en: 'Offers could not be loaded.'
	String get offers_error_load => 'Offers could not be loaded.';

	/// en: 'Open collaboration offer'
	String get open_collaboration => 'Open collaboration offer';

	/// en: 'New collaboration offer successfully added'
	String get new_offer_success => 'New collaboration offer\nsuccessfully added';

	/// en: 'Offers from brands'
	String get page_title => 'Offers from brands';

	/// en: 'All niches'
	String get all_niches => 'All niches';

	/// en: 'No recommendations yet.'
	String get no_recommendations => 'No recommendations yet.';

	/// en: 'We will show matching offers here as soon as they are available.'
	String get recommendations_subtitle => 'We will show matching offers here as soon as they are available.';
}

// Path: reviews
class TranslationsReviewsEn {
	TranslationsReviewsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Average'
	String get average => 'Average';

	/// en: 'Client reviews'
	String get client_reviews => 'Client reviews';

	/// en: 'Reviews'
	String get title => 'Reviews';

	/// en: 'No reviews yet.'
	String get no_reviews => 'No reviews yet.';

	/// en: 'No review text provided.'
	String get no_review_text => 'No review text provided.';

	/// en: 'Reviews could not be loaded.'
	String get error_load => 'Reviews could not be loaded.';
}

// Path: notifications
class TranslationsNotificationsEn {
	TranslationsNotificationsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Notifications'
	String get title => 'Notifications';

	/// en: 'Read all'
	String get read_all => 'Read all';

	/// en: 'You have no notifications yet.'
	String get no_notifications => 'You have no notifications yet.';

	/// en: 'Notifications could not be loaded.'
	String get error_load => 'Notifications could not be loaded.';
}

// Path: billing
class TranslationsBillingEn {
	TranslationsBillingEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Plan'
	String get plan_tab => 'Plan';

	/// en: 'My cards'
	String get my_cards_tab => 'My cards';

	/// en: 'Billing history'
	String get history_tab => 'Billing history';

	/// en: 'Current plan'
	String get current_plan => 'Current plan';

	/// en: 'Boost profile'
	String get boost_profile => 'Boost profile';

	/// en: 'Processing...'
	String get processing => 'Processing...';

	/// en: 'Cancel subscription'
	String get cancel_subscription => 'Cancel subscription';

	/// en: 'Add new card'
	String get add_new_card => 'Add new card';

	/// en: 'Issue date'
	String get issue_date => 'Issue date';

	/// en: 'Amount'
	String get amount => 'Amount';

	/// en: 'Start date'
	String get start_date => 'Start date';

	/// en: 'Add payment card'
	String get add_payment_card => 'Add payment card';

	/// en: 'Set as default'
	String get set_as_default => 'Set as default';

	/// en: 'Save card'
	String get save_card => 'Save card';

	/// en: 'Fill in valid card details.'
	String get fill_valid_card_details => 'Fill in valid card details.';

	/// en: 'Last four digits'
	String get last_four_digits => 'Last four digits';

	/// en: 'Expiry month'
	String get expiry_month => 'Expiry month';

	/// en: 'Expiry year'
	String get expiry_year => 'Expiry year';

	/// en: 'Gateway token'
	String get gateway_token => 'Gateway token';

	/// en: 'Card type'
	String get card_type => 'Card type';

	/// en: 'No billing history yet.'
	String get no_billing_history => 'No billing history yet.';

	/// en: 'Billing data could not be loaded.'
	String get error_load => 'Billing data could not be loaded.';

	/// en: 'No active subscription'
	String get no_active_subscription => 'No active subscription';

	/// en: '/ month'
	String get per_month => '/ month';

	/// en: 'Add a payment card first.'
	String get add_payment_card_first => 'Add a payment card first.';

	/// en: 'Contact unlock:'
	String get contact_unlock => 'Contact unlock:';

	/// en: 'Profile / Offer boost:'
	String get profile_offer_boost => 'Profile / Offer boost:';

	/// en: 'Pay-as-you-go add-ons (transparent)'
	String get pay_as_you_go => 'Pay-as-you-go add-ons (transparent)';

	/// en: '$cardType ending in $lastFour'
	String card_ending_in({required Object cardType, required Object lastFour}) => '${cardType} ending in ${lastFour}';

	/// en: 'Expiry $month/$year'
	String card_expiry({required Object month, required Object year}) => 'Expiry ${month}/${year}';

	/// en: 'Transaction #$id'
	String transaction_label({required Object id}) => 'Transaction #${id}';

	/// en: 'Delete'
	String get delete_card => 'Delete';

	/// en: 'Default'
	String get default_card => 'Default';

	/// en: 'Set default'
	String get set_default_card => 'Set default';

	/// en: 'No plan'
	String get no_plan => 'No plan';

	/// en: 'No feature details available'
	String get no_feature_details => 'No feature details available';

	/// en: '$days days'
	String days({required Object days}) => '${days} days';
}

// Path: errors
class TranslationsErrorsEn {
	TranslationsErrorsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Network connection problem, please check your internet'
	String get network => 'Network connection problem, please check your internet';

	/// en: 'Data processing error'
	String get parsing => 'Data processing error';

	/// en: 'An unknown error occurred'
	String get unknown => 'An unknown error occurred';

	/// en: 'Session expired'
	String get session_expired => 'Session expired';

	/// en: 'You will be redirected to the login page to sign in again.'
	String get redirect_to_login => 'You will be redirected to the login page to sign in again.';

	late final TranslationsErrorsServerEn server = TranslationsErrorsServerEn._(_root);
}

// Path: analytics
class TranslationsAnalyticsEn {
	TranslationsAnalyticsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Brand Activity Summary'
	String get brand_activity_summary => 'Brand Activity Summary';

	/// en: 'Search Insights'
	String get search_insights => 'Search Insights';

	/// en: 'Most Searched Ambassadors'
	String get most_searched_ambassadors => 'Most Searched Ambassadors';

	/// en: 'Offer Performance'
	String get offer_performance => 'Offer Performance';

	/// en: 'AI Matching Insights'
	String get ai_matching_insights => 'AI Matching Insights';

	/// en: 'Top Recommended Ambassadors'
	String get top_recommended_ambassadors => 'Top Recommended Ambassadors';

	/// en: 'Audience Insights'
	String get audience_insights => 'Audience Insights';

	/// en: 'Total Searches'
	String get total_searches => 'Total Searches';

	/// en: 'Total Offers'
	String get total_offers => 'Total Offers';

	/// en: 'Invitations Sent'
	String get invitations_sent => 'Invitations Sent';

	/// en: 'Ambassador Apps'
	String get ambassador_apps => 'Ambassador Apps';

	/// en: 'Influencer Apps'
	String get influencer_apps => 'Influencer Apps';

	/// en: '$count searches performed'
	String searches_performed({required Object count}) => '${count} searches performed';

	/// en: 'Top filters used'
	String get top_filters_used => 'Top filters used';

	/// en: 'Last 7 Days'
	String get last_7_days => 'Last 7 Days';

	/// en: 'Top Niches'
	String get top_niches => 'Top Niches';

	/// en: 'Top Regions'
	String get top_regions => 'Top Regions';

	/// en: 'Viewed Offer'
	String get viewed_offer => 'Viewed Offer';

	/// en: 'Opened Details'
	String get opened_details => 'Opened Details';

	/// en: 'Applicants'
	String get applicants => 'Applicants';

	/// en: 'Approved'
	String get approved => 'Approved';

	/// en: 'Niche Fit'
	String get niche_fit => 'Niche Fit';

	/// en: 'Audience Fit'
	String get audience_fit => 'Audience Fit';

	/// en: 'Platform Fit'
	String get platform_fit => 'Platform Fit';

	/// en: '$followers followers • $region'
	String followers_region({required Object followers, required Object region}) => '${followers} followers  •  ${region}';

	/// en: 'Top age group: '
	String get top_age_group => 'Top age group: ';

	/// en: 'Gender Distribution'
	String get gender_distribution => 'Gender Distribution';

	/// en: 'Top Countries'
	String get top_countries => 'Top Countries';

	/// en: 'Female $percent%'
	String female_percent({required Object percent}) => 'Female ${percent}%';

	/// en: 'Male $percent%'
	String male_percent({required Object percent}) => 'Male ${percent}%';

	/// en: 'Analytics data could not be loaded.'
	String get analytics_load_failed => 'Analytics data could not be loaded.';

	/// en: 'Average rating'
	String get average_rating => 'Average rating';

	/// en: 'Total reviews'
	String get total_reviews => 'Total reviews';

	/// en: 'Selected period'
	String get selected_period => 'Selected period';

	/// en: 'Profile views'
	String get profile_views => 'Profile views';

	/// en: 'Period'
	String get period => 'Period';

	/// en: 'Profile views in the last 30 days'
	String get profile_views_last_30_days => 'Profile views in the last 30 days';

	/// en: 'Total profile views'
	String get total_profile_views => 'Total profile views';

	/// en: '30 days'
	String get days_30 => '30 days';

	/// en: 'All time'
	String get all_time => 'All time';

	/// en: 'Applications by status'
	String get applications_by_status => 'Applications by status';

	/// en: 'No applications yet.'
	String get no_applications => 'No applications yet.';

	/// en: 'My campaigns'
	String get my_campaigns => 'My campaigns';

	/// en: 'Active campaigns'
	String get active_campaigns => 'Active campaigns';

	/// en: 'Influencers hired'
	String get influencers_hired => 'Influencers hired';

	/// en: 'Recent activity'
	String get recent_activity => 'Recent activity';

	/// en: 'Campaign title here'
	String get campaign_title_placeholder => 'Campaign title here';

	/// en: 'Campaigns'
	String get campaigns => 'Campaigns';

	/// en: 'Find influencers'
	String get find_influencers => 'Find influencers';

	/// en: 'Influencer #$id'
	String influencer_number({required Object id}) => 'Influencer #${id}';

	/// en: '$rate% ER'
	String engagement_rate_short({required Object rate}) => '${rate}% ER';

	/// en: 'Verified'
	String get status_verified => 'Verified';

	/// en: 'Rejected'
	String get status_rejected => 'Rejected';

	/// en: 'Blocked'
	String get status_blocked => 'Blocked';

	/// en: 'Pending'
	String get status_pending => 'Pending';
}

// Path: billing_ui
class TranslationsBillingUiEn {
	TranslationsBillingUiEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Error loading plan'
	String get error_loading_plan => 'Error loading plan';

	/// en: 'Minimal'
	String get minimal => 'Minimal';

	/// en: 'Deactivate plan?'
	String get deactivate_plan_question => 'Deactivate plan?';

	/// en: 'Your subscription will be cancelled. You can reactivate at any time.'
	String get deactivate_plan_message => 'Your subscription will be cancelled. You can reactivate at any time.';

	/// en: 'Deactivate'
	String get deactivate => 'Deactivate';

	/// en: 'PREMIUM'
	String get premium => 'PREMIUM';

	/// en: 'Deactivated'
	String get deactivated => 'Deactivated';

	/// en: 'Renewal date'
	String get renewal_date => 'Renewal date';

	/// en: 'No card added'
	String get no_card_added => 'No card added';

	/// en: 'Auto-renewal'
	String get auto_renewal => 'Auto-renewal';

	/// en: 'Card'
	String get card => 'Card';

	/// en: 'Coupon code'
	String get coupon_code => 'Coupon code';

	/// en: 'Activate'
	String get activate => 'Activate';

	/// en: 'Payment method'
	String get payment_method => 'Payment method';

	/// en: 'Extra invites / applies:'
	String get extra_invites_applies => 'Extra invites / applies:';

	/// en: 'from \$5'
	String get extra_invites_price => 'from \$5';

	/// en: 'Browse offers & ambassadors (limited)'
	String get feature_browse_offers => 'Browse offers & ambassadors (limited)';

	/// en: 'Create 1 Offer / month'
	String get feature_create_offer => 'Create 1 Offer / month';

	/// en: 'Up to 3 Invites / month'
	String get feature_invites => 'Up to 3 Invites / month';

	/// en: 'AI recommendations: Top 5 matches'
	String get feature_ai_recommendations => 'AI recommendations: Top 5 matches';

	/// en: 'Shortlist up to 10 profiles'
	String get feature_shortlist => 'Shortlist up to 10 profiles';

	/// en: 'Basic analytics (views, invites)'
	String get feature_basic_analytics => 'Basic analytics (views, invites)';

	/// en: 'Max offers / month: $count'
	String max_offers_per_month({required Object count}) => 'Max offers / month: ${count}';

	/// en: 'Max finds / month: $count'
	String max_finds_per_month({required Object count}) => 'Max finds / month: ${count}';

	/// en: 'AI matches count: $count'
	String ai_matches_count({required Object count}) => 'AI matches count: ${count}';

	/// en: 'Max shortlist: $count'
	String max_shortlist({required Object count}) => 'Max shortlist: ${count}';

	/// en: 'Full contact access'
	String get full_contact_access => 'Full contact access';

	/// en: 'Advanced analytics'
	String get advanced_analytics => 'Advanced analytics';

	/// en: 'Priority support'
	String get priority_support => 'Priority support';

	/// en: 'Add new payment method'
	String get add_new_payment_method => 'Add new payment method';

	/// en: 'Card holder'
	String get card_holder => 'Card holder';

	/// en: 'Write card holder name'
	String get write_card_holder_name => 'Write card holder name';

	/// en: 'Required'
	String get required => 'Required';

	/// en: 'Card number'
	String get card_number => 'Card number';

	/// en: 'Write card number'
	String get write_card_number => 'Write card number';

	/// en: 'Enter a valid 16-digit card number'
	String get enter_valid_16_digit_card => 'Enter a valid 16-digit card number';

	/// en: 'Expire date'
	String get expire_date => 'Expire date';

	/// en: 'MM/YY'
	String get mm_yy => 'MM/YY';

	/// en: 'Invalid month'
	String get invalid_month => 'Invalid month';

	/// en: 'CCV'
	String get ccv => 'CCV';

	/// en: 'Invalid'
	String get invalid => 'Invalid';

	/// en: 'Could not send the SMS code'
	String get could_not_send_sms_code => 'Could not send the SMS code';

	/// en: 'Enter valid card number'
	String get enter_valid_card_number => 'Enter valid card number';

	/// en: 'Edit card'
	String get edit_card => 'Edit card';

	/// en: 'No cards added yet'
	String get no_cards_added_yet => 'No cards added yet';

	/// en: 'Card added'
	String get card_added => 'Card added';

	/// en: 'Enter the SMS code sent to your card's phone number'
	String get enter_sms_code_card_phone => 'Enter the SMS code sent to your card\'s phone number';

	/// en: 'We sent an SMS code to $phone, please enter it below'
	String sms_code_sent_to({required Object phone}) => 'We sent an SMS code to ${phone},\nplease enter it below';

	/// en: 'Payment'
	String get payment => 'Payment';
}

// Path: ambassador
class TranslationsAmbassadorEn {
	TranslationsAmbassadorEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Ambassador details'
	String get ambassador_details => 'Ambassador details';

	/// en: 'Information'
	String get information => 'Information';

	/// en: 'No information provided.'
	String get no_information_provided => 'No information provided.';

	/// en: 'Niche'
	String get niche => 'Niche';

	/// en: 'Available dates'
	String get available_dates => 'Available dates';

	/// en: ', age $from – $to'
	String age_range_suffix({required Object from, required Object to}) => ', age ${from} – ${to}';

	/// en: 'Engagement level'
	String get engagement_level => 'Engagement level';

	/// en: 'Total number of followers'
	String get total_number_of_followers => 'Total number of followers';

	/// en: '$years years'
	String years_value({required Object years}) => '${years} years';

	/// en: 'List of partners'
	String get list_of_partners => 'List of partners';

	/// en: 'No comment'
	String get no_comment => 'No comment';

	/// en: 'No portfolio items.'
	String get no_portfolio_items => 'No portfolio items.';

	/// en: 'No pricing information available.'
	String get no_pricing_info => 'No pricing information available.';

	/// en: 'Hourly (UZS)'
	String get hourly_uzs => 'Hourly (UZS)';

	/// en: 'Hourly (USD)'
	String get hourly_usd => 'Hourly (USD)';

	/// en: 'Project by'
	String get project_by => 'Project by';

	/// en: 'Monthly exclusivity fee'
	String get monthly_exclusivity_fee => 'Monthly exclusivity fee';

	/// en: 'Monthly content capacity'
	String get monthly_content_capacity => 'Monthly content capacity';

	/// en: '$count posts'
	String content_capacity_posts({required Object count}) => '${count} posts';

	/// en: 'Added to favourites'
	String get added_to_favourites => 'Added to favourites';

	/// en: 'Add to favourites'
	String get add_to_favourites => 'Add to favourites';

	/// en: 'Send enquiry'
	String get send_enquiry => 'Send enquiry';

	/// en: 'Portfolio details'
	String get portfolio_details => 'Portfolio details';

	/// en: 'No description'
	String get no_description => 'No description';

	/// en: 'Links'
	String get links => 'Links';

	/// en: 'No links added.'
	String get no_links_added => 'No links added.';

	/// en: 'Portfolio images'
	String get portfolio_images => 'Portfolio images';

	/// en: 'No images added.'
	String get no_images_added => 'No images added.';

	/// en: 'Language'
	String get language => 'Language';

	/// en: 'Age'
	String get age => 'Age';

	/// en: 'Auditory'
	String get auditory => 'Auditory';

	/// en: 'Available date'
	String get available_date => 'Available date';

	/// en: 'Price range (per hour)'
	String get price_range_per_hour => 'Price range (per hour)';

	/// en: 'From'
	String get from => 'From';

	/// en: 'To'
	String get to => 'To';

	/// en: 'No favourites yet.'
	String get no_favourites_yet => 'No favourites yet.';

	/// en: '$count found'
	String items_found({required Object count}) => '${count} found';
}

// Path: portfolio_ui
class TranslationsPortfolioUiEn {
	TranslationsPortfolioUiEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Fill profile information'
	String get fill_profile_information => 'Fill profile information';

	/// en: 'Upload thumbnail picture'
	String get upload_thumbnail_picture => 'Upload thumbnail picture';

	/// en: 'Choose files'
	String get choose_files => 'Choose files';

	/// en: 'Portfolio name'
	String get portfolio_name => 'Portfolio name';

	/// en: 'Portfolio name here'
	String get portfolio_name_hint => 'Portfolio name here';

	/// en: 'Add links'
	String get add_links => 'Add links';

	/// en: 'Save and continue later'
	String get save_and_continue_later => 'Save and continue later';

	/// en: 'The file picker is not connected yet. Saving details still works.'
	String get upload_not_available => 'The file picker is not connected yet. Saving details still works.';

	/// en: 'General info (1/6)'
	String get general_info_step => 'General info (1/6)';

	/// en: 'Portfolio details could not be loaded.'
	String get details_load_failed => 'Portfolio details could not be loaded.';

	/// en: 'Portfolio details'
	String get portfolio_details_title => 'Portfolio details';

	/// en: 'Information'
	String get information => 'Information';

	/// en: 'No description'
	String get no_description => 'No description';

	/// en: 'Links'
	String get links => 'Links';

	/// en: 'No links added.'
	String get no_links_added => 'No links added.';

	/// en: 'Portfolio images'
	String get portfolio_images => 'Portfolio images';

	/// en: 'No images added.'
	String get no_images_added => 'No images added.';

	/// en: 'Portfolio could not be loaded.'
	String get list_load_failed => 'Portfolio could not be loaded.';

	/// en: 'No portfolio found'
	String get no_portfolio_found => 'No portfolio found';

	/// en: 'TOP is active'
	String get top_is_active => 'TOP is active';

	/// en: 'TOP is not activated'
	String get top_not_activated => 'TOP is not activated';

	/// en: 'Select payment method'
	String get select_payment_method => 'Select payment method';

	/// en: 'Activate'
	String get activate => 'Activate';

	/// en: 'VIP is active'
	String get vip_is_active => 'VIP is active';

	/// en: 'VIP is not activated'
	String get vip_not_activated => 'VIP is not activated';

	/// en: 'Invoice #$id'
	String invoice_number({required Object id}) => 'Invoice #${id}';

	/// en: 'Billing transaction'
	String get billing_transaction => 'Billing transaction';

	/// en: 'Receipt'
	String get receipt => 'Receipt';

	/// en: 'Download'
	String get download => 'Download';

	/// en: 'Select a TOP package first.'
	String get select_top_package_first => 'Select a TOP package first.';

	/// en: 'Select a payment method first.'
	String get select_payment_method_first => 'Select a payment method first.';

	/// en: 'Select a VIP plan first.'
	String get select_vip_plan_first => 'Select a VIP plan first.';

	/// en: '$days days / $amount'
	String boost_package_label({required Object days, required Object amount}) => '${days} days / ${amount}';

	/// en: 'Expiration date'
	String get expiration_date => 'Expiration date';

	/// en: 'TOP profile data could not be loaded.'
	String get top_profile_load_failed => 'TOP profile data could not be loaded.';
}

// Path: collab
class TranslationsCollabEn {
	TranslationsCollabEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Required'
	String get required => 'Required';

	/// en: 'Send enquiry'
	String get send_enquiry => 'Send enquiry';

	/// en: 'Enquiry sent'
	String get enquiry_sent => 'Enquiry sent';

	/// en: 'Contact name'
	String get contact_name => 'Contact name';

	/// en: 'Write Contact name'
	String get write_contact_name => 'Write Contact name';

	/// en: 'Company name'
	String get company_name => 'Company name';

	/// en: 'Write Company name'
	String get write_company_name => 'Write Company name';

	/// en: 'Contact number'
	String get contact_number => 'Contact number';

	/// en: 'Write Contact number'
	String get write_contact_number => 'Write Contact number';

	/// en: 'Message'
	String get message => 'Message';

	/// en: 'Write message here'
	String get write_message_here => 'Write message here';

	/// en: 'Sending...'
	String get sending => 'Sending...';

	/// en: 'No active offers found.'
	String get no_active_offers_found => 'No active offers found.';

	/// en: '$count found'
	String results_found({required Object count}) => '${count} found';

	/// en: 'No matches yet for "$offerTitle"'
	String no_matches_yet({required Object offerTitle}) => 'No matches yet for "${offerTitle}"';

	/// en: 'Run AI matching to find the best influencers.'
	String get run_ai_matching_subtitle => 'Run AI matching to find the best influencers.';

	/// en: 'Run AI Matching'
	String get run_ai_matching => 'Run AI Matching';

	/// en: 'Influencer #$id'
	String influencer_number({required Object id}) => 'Influencer #${id}';

	/// en: 'Messages could not be loaded.'
	String get messages_error_load => 'Messages could not be loaded.';

	/// en: 'No messages found'
	String get no_messages_found => 'No messages found';

	/// en: '$count Messages found'
	String messages_found({required Object count}) => '${count} Messages found';

	/// en: 'No phone'
	String get no_phone => 'No phone';

	/// en: 'No messages yet in this conversation.'
	String get no_messages_yet => 'No messages yet in this conversation.';

	/// en: 'Participant'
	String get participant => 'Participant';

	/// en: 'Brand contact'
	String get brand_contact => 'Brand contact';

	/// en: 'Influencer contact'
	String get influencer_contact => 'Influencer contact';

	/// en: '$role contact'
	String role_contact({required Object role}) => '${role} contact';

	/// en: 'Offer #$id'
	String offer_number({required Object id}) => 'Offer #${id}';

	/// en: 'Brand conversation'
	String get brand_conversation => 'Brand conversation';

	/// en: 'Influencer conversation'
	String get influencer_conversation => 'Influencer conversation';

	/// en: 'Conversation #$id'
	String conversation_number({required Object id}) => 'Conversation #${id}';

	/// en: 'Conversation'
	String get conversation => 'Conversation';

	/// en: 'Save'
	String get save => 'Save';

	/// en: 'Available dates ($count)'
	String available_dates({required Object count}) => 'Available dates (${count})';

	/// en: 'Calendar updated'
	String get calendar_updated => 'Calendar updated';

	/// en: 'January'
	String get month_january => 'January';

	/// en: 'February'
	String get month_february => 'February';

	/// en: 'March'
	String get month_march => 'March';

	/// en: 'April'
	String get month_april => 'April';

	/// en: 'May'
	String get month_may => 'May';

	/// en: 'June'
	String get month_june => 'June';

	/// en: 'July'
	String get month_july => 'July';

	/// en: 'August'
	String get month_august => 'August';

	/// en: 'September'
	String get month_september => 'September';

	/// en: 'October'
	String get month_october => 'October';

	/// en: 'November'
	String get month_november => 'November';

	/// en: 'December'
	String get month_december => 'December';
}

// Path: misc
class TranslationsMiscEn {
	TranslationsMiscEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Notification details'
	String get notification_details_title => 'Notification details';

	/// en: 'No additional details.'
	String get notification_no_additional_details => 'No additional details.';

	/// en: '$rate% engagement rate'
	String engagement_rate_value({required Object rate}) => '${rate}% engagement rate';

	/// en: 'Luxury'
	String get segment_luxury => 'Luxury';

	/// en: 'Premium'
	String get segment_premium => 'Premium';

	/// en: 'Mass market'
	String get segment_mass_market => 'Mass market';

	/// en: 'Budget'
	String get segment_budget => 'Budget';

	/// en: 'Niche'
	String get niche => 'Niche';

	/// en: 'My Pricing/Tariffs'
	String get my_pricing_tariffs => 'My Pricing/Tariffs';

	/// en: 'Contract'
	String get contract => 'Contract';

	/// en: 'Camera experience'
	String get camera_experience => 'Camera experience';

	/// en: 'Save and continue later'
	String get save_and_continue_later => 'Save and continue later';

	/// en: 'Fill profile information'
	String get fill_profile_information => 'Fill profile information';

	/// en: 'Image upload failed'
	String get image_upload_failed => 'Image upload failed';

	/// en: 'Uzbekistani som'
	String get currency_uzs => 'Uzbekistani som';

	/// en: 'US Dollar'
	String get currency_usd => 'US Dollar';

	/// en: 'You can edit this section only after your profile is approved.'
	String get profile_section_readonly => 'You can edit this section only after your profile is approved.';

	/// en: '$followers followers, $rate% engagement rate'
	String followers_and_engagement({required Object followers, required Object rate}) => '${followers} followers, ${rate}% engagement rate';

	/// en: 'Terms of use'
	String get terms_of_use_title => 'Terms of use';
}

// Path: errors.server
class TranslationsErrorsServerEn {
	TranslationsErrorsServerEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Server error ($code)'
	String defaultMsg({required Object code}) => 'Server error (${code})';

	/// en: 'Bad request'
	String get badRequest => 'Bad request';

	/// en: 'Session expired, please log in again'
	String get unauthorized => 'Session expired, please log in again';

	/// en: 'Resource not found'
	String get notFound => 'Resource not found';

	/// en: 'User with this email already exists'
	String get userExists => 'User with this email already exists';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'splash.app_version' => ({required Object version}) => 'App version ${version}',
			'onboarding.kContinue' => 'Continue',
			'onboarding.description' => 'InflueraX — the modern influencer marketing platform connecting brands, influencers and ambassadors in one place.',
			'login.phone_number' => 'Phone number',
			'login.welcome_msg' => 'Welcome to InflueraX',
			'login.term_of_use_first' => 'By pressing Login i agree to all ',
			'login.term_of_use_second' => 'terms of use',
			'login.login_methods' => 'or continue with',
			'login.sms_confirmation' => 'SMS confirmation',
			'login.sms_sent_to' => ({required Object phoneEnd}) => 'We have sent SMS code to your phone number **${phoneEnd}, please enter this code',
			'login.send_code_again' => 'Send code again',
			'login.soon_title' => 'Coming soon',
			'login.soon_message' => ({required Object provider}) => 'Login with ${provider} will be available soon.',
			'login.social_login_failed' => 'Social login failed',
			'login.social_login_cancelled' => 'Sign-in was cancelled',
			'login.linkedin_title' => 'Sign in with LinkedIn',
			'login.telegram_title' => 'Sign in with Telegram',
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
			'common.try_again' => 'Try again',
			'common.back' => 'Back',
			'common.any' => 'Any',
			'common.not_specified' => 'Not specified',
			'common.unknown' => 'Unknown',
			'common.unknown_date' => 'Unknown date',
			'common.pull_refresh_or_retry' => 'Pull to refresh or try again.',
			'common.pull_refresh_check_soon' => 'Pull to refresh and check again soon.',
			'common.error_occurred' => 'An error occurred',
			'common.open' => 'Open',
			'common.date_format_hint' => 'DD.MM.YYYY',
			'common.continue_label' => 'Continue',
			'common.general' => 'General',
			'common.requirements_label' => 'Requirements',
			'common.details_label' => 'Details',
			'common.select_country' => 'Select country',
			'common.select_visibility' => 'Select visibility',
			'common.age_range' => 'Age range',
			'common.public' => 'Public',
			'common.private' => 'Private',
			'common.duration_1_week' => '1 week',
			'common.duration_2_weeks' => '2 weeks',
			'common.duration_1_month' => '1 month',
			'common.duration_2_months' => '2 months',
			'common.duration_3_months' => '3 months',
			'common.default_label' => 'Default',
			'common.set_default' => 'Set default',
			'common.no_contact_details' => 'No contact details',
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
			'profile.delete_account_type_name' => ({required Object name}) => 'Type your name ${name} to confirm account deletion.',
			'profile.delete_account_type_name_hint' => 'Enter your name',
			'profile.delete_account_name_mismatch' => 'Name does not match.',
			'profile.total_followers' => 'Total followers',
			'profile.engagement_rate' => 'Engagement rate',
			'validation.name_required' => 'Please enter your name and surname',
			'validation.name_full_required' => 'Please enter your full name and surname',
			'validation.name_letters_only' => 'Name must contain only letters',
			'validation.name_too_short' => 'Name is too short',
			'validation.fill_required_fields' => 'Fill required fields',
			'validation.account_already_added' => 'Account already added',
			'validation.phone_required' => 'Please enter your phone number',
			'validation.phone_invalid' => 'Please enter a valid phone number',
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
			'choose.select_payment_type' => 'Select payment type',
			'contact.phone' => 'Phone',
			'contact.telegram' => 'Telegram',
			'contact.instagram' => 'Instagram',
			'contact.telegram_user_name' => 'Telegram user name',
			'contact.instagram_account' => 'Instagram account',
			'contact.no_contact_details' => 'No contact details',
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
			'home.flexible_reward' => 'Flexible',
			'home.new_recommendation' => 'New recommendation tailored to your profile.',
			'home.error_load' => 'Home page data could not be loaded.',
			'home.empty_recommendations' => 'Recommendations will appear here once matching results are ready.',
			'home.pending_approval_text' => 'Your profile is still under review. Offers and recommendations will appear after approval.',
			'home.pending_approval_banner' => 'Your profile is pending approval. Messages and notifications are available now, and offer tools will unlock after moderation.',
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
			'brand.brand_profile' => 'Brand profile',
			'brand.website' => 'Website',
			'brand.actives' => 'Actives',
			'brand.archived' => 'Archived',
			'brand.views' => 'Views',
			'brand.applications' => 'Applications',
			'brand.search' => 'Search',
			'brand.new_offer' => 'New offer',
			'brand.sort_by' => 'Sort by',
			'brand.sort_by_ranking' => 'Sort by ranking',
			'brand.sort_by_newly_joined' => 'Sort by newly joined',
			'brand.sort_by_followers' => 'Sort by number of followers',
			'brand.sort_by_experience' => 'Sort by experience',
			'brand.sort_by_views' => 'Sort by views',
			'brand.sort_by_applications' => 'Sort by applications',
			'brand.filter' => 'Filter',
			'brand.rank_type' => 'Rank type',
			'brand.vip_label' => 'VIP',
			'brand.ambassadors_found' => ({required Object count}) => '${count} ambassadors found',
			'brand.no_ambassadors_found' => 'No ambassadors found',
			'brand.followers_count' => ({required Object count}) => '${count} followers',
			'brand.years_experience' => ({required Object count}) => '${count} years exp.',
			'brand.collaboration_offer_details' => 'Collaboration offer details',
			'brand.offer_failed_load' => 'Failed to load offer.',
			'brand.offer_complete' => 'Complete',
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
			'offer.application_submitted' => 'Application submitted successfully.',
			'offer.error_could_not_open' => 'Offer could not be opened.',
			'offer.error_no_id' => 'Offer ID was not provided.',
			'offer.error_retry_message' => 'Pull back and try opening the offer again.',
			'offer.not_found' => 'Offer not found.',
			'offer.no_detail_data' => 'No detail data is available for this offer.',
			'offer.apply_title' => 'Apply to this offer',
			'offer.cover_letter_subtitle' => 'Add an optional cover letter for your application.',
			'offer.cover_letter_label' => 'Cover letter',
			'offer.cover_letter_hint' => 'Write a short message here',
			'offer.submit_application' => 'Submit application',
			'offer.continue_without_cover_letter' => 'Continue without cover letter',
			'offer.general_info' => 'General info',
			'offer.no_category' => 'No category',
			'offer.create_title' => 'Add new collaboration offer',
			'offer.title_hint' => 'Write offer title',
			'offer.applied' => 'Applied',
			'offer.submitting' => 'Submitting...',
			'offer.apply_now' => 'Apply now',
			'offer.no_deadline' => 'No deadline',
			'offer.open_deadline' => 'Open',
			'offer.reward' => 'Reward',
			'offer.no_offers_available' => 'No offers are available right now.',
			'offer.no_offers_for_niche' => ({required Object niche}) => 'No offers found for ${niche}.',
			'offer.offers_error_load' => 'Offers could not be loaded.',
			'offer.open_collaboration' => 'Open collaboration offer',
			'offer.new_offer_success' => 'New collaboration offer\nsuccessfully added',
			'offer.page_title' => 'Offers from brands',
			'offer.all_niches' => 'All niches',
			'offer.no_recommendations' => 'No recommendations yet.',
			'offer.recommendations_subtitle' => 'We will show matching offers here as soon as they are available.',
			'reviews.average' => 'Average',
			'reviews.client_reviews' => 'Client reviews',
			'reviews.title' => 'Reviews',
			'reviews.no_reviews' => 'No reviews yet.',
			'reviews.no_review_text' => 'No review text provided.',
			'reviews.error_load' => 'Reviews could not be loaded.',
			'notifications.title' => 'Notifications',
			'notifications.read_all' => 'Read all',
			'notifications.no_notifications' => 'You have no notifications yet.',
			'notifications.error_load' => 'Notifications could not be loaded.',
			'billing.plan_tab' => 'Plan',
			'billing.my_cards_tab' => 'My cards',
			'billing.history_tab' => 'Billing history',
			'billing.current_plan' => 'Current plan',
			'billing.boost_profile' => 'Boost profile',
			'billing.processing' => 'Processing...',
			'billing.cancel_subscription' => 'Cancel subscription',
			'billing.add_new_card' => 'Add new card',
			'billing.issue_date' => 'Issue date',
			'billing.amount' => 'Amount',
			'billing.start_date' => 'Start date',
			'billing.add_payment_card' => 'Add payment card',
			'billing.set_as_default' => 'Set as default',
			'billing.save_card' => 'Save card',
			'billing.fill_valid_card_details' => 'Fill in valid card details.',
			'billing.last_four_digits' => 'Last four digits',
			'billing.expiry_month' => 'Expiry month',
			'billing.expiry_year' => 'Expiry year',
			'billing.gateway_token' => 'Gateway token',
			'billing.card_type' => 'Card type',
			'billing.no_billing_history' => 'No billing history yet.',
			'billing.error_load' => 'Billing data could not be loaded.',
			'billing.no_active_subscription' => 'No active subscription',
			'billing.per_month' => '/ month',
			'billing.add_payment_card_first' => 'Add a payment card first.',
			'billing.contact_unlock' => 'Contact unlock:',
			'billing.profile_offer_boost' => 'Profile / Offer boost:',
			'billing.pay_as_you_go' => 'Pay-as-you-go add-ons (transparent)',
			'billing.card_ending_in' => ({required Object cardType, required Object lastFour}) => '${cardType} ending in ${lastFour}',
			'billing.card_expiry' => ({required Object month, required Object year}) => 'Expiry ${month}/${year}',
			'billing.transaction_label' => ({required Object id}) => 'Transaction #${id}',
			'billing.delete_card' => 'Delete',
			'billing.default_card' => 'Default',
			'billing.set_default_card' => 'Set default',
			'billing.no_plan' => 'No plan',
			'billing.no_feature_details' => 'No feature details available',
			'billing.days' => ({required Object days}) => '${days} days',
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
			'analytics.brand_activity_summary' => 'Brand Activity Summary',
			'analytics.search_insights' => 'Search Insights',
			'analytics.most_searched_ambassadors' => 'Most Searched Ambassadors',
			'analytics.offer_performance' => 'Offer Performance',
			'analytics.ai_matching_insights' => 'AI Matching Insights',
			'analytics.top_recommended_ambassadors' => 'Top Recommended Ambassadors',
			'analytics.audience_insights' => 'Audience Insights',
			'analytics.total_searches' => 'Total Searches',
			'analytics.total_offers' => 'Total Offers',
			'analytics.invitations_sent' => 'Invitations Sent',
			'analytics.ambassador_apps' => 'Ambassador Apps',
			'analytics.influencer_apps' => 'Influencer Apps',
			'analytics.searches_performed' => ({required Object count}) => '${count} searches performed',
			'analytics.top_filters_used' => 'Top filters used',
			'analytics.last_7_days' => 'Last 7 Days',
			'analytics.top_niches' => 'Top Niches',
			'analytics.top_regions' => 'Top Regions',
			'analytics.viewed_offer' => 'Viewed Offer',
			'analytics.opened_details' => 'Opened Details',
			'analytics.applicants' => 'Applicants',
			'analytics.approved' => 'Approved',
			'analytics.niche_fit' => 'Niche Fit',
			'analytics.audience_fit' => 'Audience Fit',
			'analytics.platform_fit' => 'Platform Fit',
			'analytics.followers_region' => ({required Object followers, required Object region}) => '${followers} followers  •  ${region}',
			'analytics.top_age_group' => 'Top age group: ',
			'analytics.gender_distribution' => 'Gender Distribution',
			'analytics.top_countries' => 'Top Countries',
			'analytics.female_percent' => ({required Object percent}) => 'Female ${percent}%',
			'analytics.male_percent' => ({required Object percent}) => 'Male ${percent}%',
			'analytics.analytics_load_failed' => 'Analytics data could not be loaded.',
			'analytics.average_rating' => 'Average rating',
			'analytics.total_reviews' => 'Total reviews',
			'analytics.selected_period' => 'Selected period',
			'analytics.profile_views' => 'Profile views',
			'analytics.period' => 'Period',
			'analytics.profile_views_last_30_days' => 'Profile views in the last 30 days',
			'analytics.total_profile_views' => 'Total profile views',
			'analytics.days_30' => '30 days',
			'analytics.all_time' => 'All time',
			'analytics.applications_by_status' => 'Applications by status',
			'analytics.no_applications' => 'No applications yet.',
			'analytics.my_campaigns' => 'My campaigns',
			'analytics.active_campaigns' => 'Active campaigns',
			'analytics.influencers_hired' => 'Influencers hired',
			'analytics.recent_activity' => 'Recent activity',
			'analytics.campaign_title_placeholder' => 'Campaign title here',
			'analytics.campaigns' => 'Campaigns',
			'analytics.find_influencers' => 'Find influencers',
			'analytics.influencer_number' => ({required Object id}) => 'Influencer #${id}',
			'analytics.engagement_rate_short' => ({required Object rate}) => '${rate}% ER',
			'analytics.status_verified' => 'Verified',
			'analytics.status_rejected' => 'Rejected',
			'analytics.status_blocked' => 'Blocked',
			'analytics.status_pending' => 'Pending',
			'billing_ui.error_loading_plan' => 'Error loading plan',
			'billing_ui.minimal' => 'Minimal',
			'billing_ui.deactivate_plan_question' => 'Deactivate plan?',
			'billing_ui.deactivate_plan_message' => 'Your subscription will be cancelled. You can reactivate at any time.',
			'billing_ui.deactivate' => 'Deactivate',
			'billing_ui.premium' => 'PREMIUM',
			'billing_ui.deactivated' => 'Deactivated',
			'billing_ui.renewal_date' => 'Renewal date',
			'billing_ui.no_card_added' => 'No card added',
			'billing_ui.auto_renewal' => 'Auto-renewal',
			'billing_ui.card' => 'Card',
			'billing_ui.coupon_code' => 'Coupon code',
			'billing_ui.activate' => 'Activate',
			'billing_ui.payment_method' => 'Payment method',
			'billing_ui.extra_invites_applies' => 'Extra invites / applies:',
			'billing_ui.extra_invites_price' => 'from \$5',
			'billing_ui.feature_browse_offers' => 'Browse offers & ambassadors (limited)',
			'billing_ui.feature_create_offer' => 'Create 1 Offer / month',
			'billing_ui.feature_invites' => 'Up to 3 Invites / month',
			'billing_ui.feature_ai_recommendations' => 'AI recommendations: Top 5 matches',
			'billing_ui.feature_shortlist' => 'Shortlist up to 10 profiles',
			'billing_ui.feature_basic_analytics' => 'Basic analytics (views, invites)',
			'billing_ui.max_offers_per_month' => ({required Object count}) => 'Max offers / month: ${count}',
			'billing_ui.max_finds_per_month' => ({required Object count}) => 'Max finds / month: ${count}',
			'billing_ui.ai_matches_count' => ({required Object count}) => 'AI matches count: ${count}',
			'billing_ui.max_shortlist' => ({required Object count}) => 'Max shortlist: ${count}',
			'billing_ui.full_contact_access' => 'Full contact access',
			'billing_ui.advanced_analytics' => 'Advanced analytics',
			'billing_ui.priority_support' => 'Priority support',
			'billing_ui.add_new_payment_method' => 'Add new payment method',
			'billing_ui.card_holder' => 'Card holder',
			'billing_ui.write_card_holder_name' => 'Write card holder name',
			'billing_ui.required' => 'Required',
			'billing_ui.card_number' => 'Card number',
			'billing_ui.write_card_number' => 'Write card number',
			'billing_ui.enter_valid_16_digit_card' => 'Enter a valid 16-digit card number',
			'billing_ui.expire_date' => 'Expire date',
			'billing_ui.mm_yy' => 'MM/YY',
			'billing_ui.invalid_month' => 'Invalid month',
			'billing_ui.ccv' => 'CCV',
			'billing_ui.invalid' => 'Invalid',
			'billing_ui.could_not_send_sms_code' => 'Could not send the SMS code',
			'billing_ui.enter_valid_card_number' => 'Enter valid card number',
			'billing_ui.edit_card' => 'Edit card',
			'billing_ui.no_cards_added_yet' => 'No cards added yet',
			'billing_ui.card_added' => 'Card added',
			'billing_ui.enter_sms_code_card_phone' => 'Enter the SMS code sent to your card\'s phone number',
			'billing_ui.sms_code_sent_to' => ({required Object phone}) => 'We sent an SMS code to ${phone},\nplease enter it below',
			'billing_ui.payment' => 'Payment',
			'ambassador.ambassador_details' => 'Ambassador details',
			'ambassador.information' => 'Information',
			'ambassador.no_information_provided' => 'No information provided.',
			'ambassador.niche' => 'Niche',
			'ambassador.available_dates' => 'Available dates',
			'ambassador.age_range_suffix' => ({required Object from, required Object to}) => ', age ${from} – ${to}',
			'ambassador.engagement_level' => 'Engagement level',
			'ambassador.total_number_of_followers' => 'Total number of followers',
			'ambassador.years_value' => ({required Object years}) => '${years} years',
			'ambassador.list_of_partners' => 'List of partners',
			'ambassador.no_comment' => 'No comment',
			'ambassador.no_portfolio_items' => 'No portfolio items.',
			'ambassador.no_pricing_info' => 'No pricing information available.',
			'ambassador.hourly_uzs' => 'Hourly (UZS)',
			'ambassador.hourly_usd' => 'Hourly (USD)',
			'ambassador.project_by' => 'Project by',
			'ambassador.monthly_exclusivity_fee' => 'Monthly exclusivity fee',
			'ambassador.monthly_content_capacity' => 'Monthly content capacity',
			'ambassador.content_capacity_posts' => ({required Object count}) => '${count} posts',
			'ambassador.added_to_favourites' => 'Added to favourites',
			'ambassador.add_to_favourites' => 'Add to favourites',
			'ambassador.send_enquiry' => 'Send enquiry',
			'ambassador.portfolio_details' => 'Portfolio details',
			'ambassador.no_description' => 'No description',
			'ambassador.links' => 'Links',
			'ambassador.no_links_added' => 'No links added.',
			'ambassador.portfolio_images' => 'Portfolio images',
			'ambassador.no_images_added' => 'No images added.',
			'ambassador.language' => 'Language',
			'ambassador.age' => 'Age',
			'ambassador.auditory' => 'Auditory',
			'ambassador.available_date' => 'Available date',
			'ambassador.price_range_per_hour' => 'Price range (per hour)',
			'ambassador.from' => 'From',
			'ambassador.to' => 'To',
			'ambassador.no_favourites_yet' => 'No favourites yet.',
			'ambassador.items_found' => ({required Object count}) => '${count} found',
			'portfolio_ui.fill_profile_information' => 'Fill profile information',
			'portfolio_ui.upload_thumbnail_picture' => 'Upload thumbnail picture',
			'portfolio_ui.choose_files' => 'Choose files',
			'portfolio_ui.portfolio_name' => 'Portfolio name',
			'portfolio_ui.portfolio_name_hint' => 'Portfolio name here',
			'portfolio_ui.add_links' => 'Add links',
			'portfolio_ui.save_and_continue_later' => 'Save and continue later',
			'portfolio_ui.upload_not_available' => 'The file picker is not connected yet. Saving details still works.',
			'portfolio_ui.general_info_step' => 'General info (1/6)',
			'portfolio_ui.details_load_failed' => 'Portfolio details could not be loaded.',
			'portfolio_ui.portfolio_details_title' => 'Portfolio details',
			'portfolio_ui.information' => 'Information',
			'portfolio_ui.no_description' => 'No description',
			'portfolio_ui.links' => 'Links',
			'portfolio_ui.no_links_added' => 'No links added.',
			'portfolio_ui.portfolio_images' => 'Portfolio images',
			'portfolio_ui.no_images_added' => 'No images added.',
			'portfolio_ui.list_load_failed' => 'Portfolio could not be loaded.',
			'portfolio_ui.no_portfolio_found' => 'No portfolio found',
			'portfolio_ui.top_is_active' => 'TOP is active',
			'portfolio_ui.top_not_activated' => 'TOP is not activated',
			'portfolio_ui.select_payment_method' => 'Select payment method',
			'portfolio_ui.activate' => 'Activate',
			'portfolio_ui.vip_is_active' => 'VIP is active',
			'portfolio_ui.vip_not_activated' => 'VIP is not activated',
			'portfolio_ui.invoice_number' => ({required Object id}) => 'Invoice #${id}',
			'portfolio_ui.billing_transaction' => 'Billing transaction',
			'portfolio_ui.receipt' => 'Receipt',
			'portfolio_ui.download' => 'Download',
			'portfolio_ui.select_top_package_first' => 'Select a TOP package first.',
			'portfolio_ui.select_payment_method_first' => 'Select a payment method first.',
			'portfolio_ui.select_vip_plan_first' => 'Select a VIP plan first.',
			'portfolio_ui.boost_package_label' => ({required Object days, required Object amount}) => '${days} days / ${amount}',
			_ => null,
		} ?? switch (path) {
			'portfolio_ui.expiration_date' => 'Expiration date',
			'portfolio_ui.top_profile_load_failed' => 'TOP profile data could not be loaded.',
			'collab.required' => 'Required',
			'collab.send_enquiry' => 'Send enquiry',
			'collab.enquiry_sent' => 'Enquiry sent',
			'collab.contact_name' => 'Contact name',
			'collab.write_contact_name' => 'Write Contact name',
			'collab.company_name' => 'Company name',
			'collab.write_company_name' => 'Write Company name',
			'collab.contact_number' => 'Contact number',
			'collab.write_contact_number' => 'Write Contact number',
			'collab.message' => 'Message',
			'collab.write_message_here' => 'Write message here',
			'collab.sending' => 'Sending...',
			'collab.no_active_offers_found' => 'No active offers found.',
			'collab.results_found' => ({required Object count}) => '${count} found',
			'collab.no_matches_yet' => ({required Object offerTitle}) => 'No matches yet for "${offerTitle}"',
			'collab.run_ai_matching_subtitle' => 'Run AI matching to find the best influencers.',
			'collab.run_ai_matching' => 'Run AI Matching',
			'collab.influencer_number' => ({required Object id}) => 'Influencer #${id}',
			'collab.messages_error_load' => 'Messages could not be loaded.',
			'collab.no_messages_found' => 'No messages found',
			'collab.messages_found' => ({required Object count}) => '${count} Messages found',
			'collab.no_phone' => 'No phone',
			'collab.no_messages_yet' => 'No messages yet in this conversation.',
			'collab.participant' => 'Participant',
			'collab.brand_contact' => 'Brand contact',
			'collab.influencer_contact' => 'Influencer contact',
			'collab.role_contact' => ({required Object role}) => '${role} contact',
			'collab.offer_number' => ({required Object id}) => 'Offer #${id}',
			'collab.brand_conversation' => 'Brand conversation',
			'collab.influencer_conversation' => 'Influencer conversation',
			'collab.conversation_number' => ({required Object id}) => 'Conversation #${id}',
			'collab.conversation' => 'Conversation',
			'collab.save' => 'Save',
			'collab.available_dates' => ({required Object count}) => 'Available dates (${count})',
			'collab.calendar_updated' => 'Calendar updated',
			'collab.month_january' => 'January',
			'collab.month_february' => 'February',
			'collab.month_march' => 'March',
			'collab.month_april' => 'April',
			'collab.month_may' => 'May',
			'collab.month_june' => 'June',
			'collab.month_july' => 'July',
			'collab.month_august' => 'August',
			'collab.month_september' => 'September',
			'collab.month_october' => 'October',
			'collab.month_november' => 'November',
			'collab.month_december' => 'December',
			'misc.notification_details_title' => 'Notification details',
			'misc.notification_no_additional_details' => 'No additional details.',
			'misc.engagement_rate_value' => ({required Object rate}) => '${rate}% engagement rate',
			'misc.segment_luxury' => 'Luxury',
			'misc.segment_premium' => 'Premium',
			'misc.segment_mass_market' => 'Mass market',
			'misc.segment_budget' => 'Budget',
			'misc.niche' => 'Niche',
			'misc.my_pricing_tariffs' => 'My Pricing/Tariffs',
			'misc.contract' => 'Contract',
			'misc.camera_experience' => 'Camera experience',
			'misc.save_and_continue_later' => 'Save and continue later',
			'misc.fill_profile_information' => 'Fill profile information',
			'misc.image_upload_failed' => 'Image upload failed',
			'misc.currency_uzs' => 'Uzbekistani som',
			'misc.currency_usd' => 'US Dollar',
			'misc.profile_section_readonly' => 'You can edit this section only after your profile is approved.',
			'misc.followers_and_engagement' => ({required Object followers, required Object rate}) => '${followers} followers, ${rate}% engagement rate',
			'misc.terms_of_use_title' => 'Terms of use',
			_ => null,
		};
	}
}
