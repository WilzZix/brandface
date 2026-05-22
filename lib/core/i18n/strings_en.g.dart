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

	/// en: 'or login in with'
	String get login_methods => 'or login in with';

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
			'login.phone_number' => 'Phone number',
			'login.welcome_msg' => 'Welcome to InflueraX',
			'login.term_of_use_first' => 'By pressing Login i agree to all ',
			'login.term_of_use_second' => 'terms of use',
			'login.login_methods' => 'or login in with',
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
			_ => null,
		};
	}
}
