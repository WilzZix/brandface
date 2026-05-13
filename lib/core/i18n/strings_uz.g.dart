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
class TranslationsUz with BaseTranslations<AppLocale, Translations> implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsUz({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
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
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsUz _root = this; // ignore: unused_field

	@override 
	TranslationsUz $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsUz(meta: meta ?? this.$meta);

	// Translations
	@override late final _TranslationsSplashUz splash = _TranslationsSplashUz._(_root);
	@override late final _TranslationsOnboardingUz onboarding = _TranslationsOnboardingUz._(_root);
	@override late final _TranslationsLoginUz login = _TranslationsLoginUz._(_root);
	@override late final _TranslationsRegistrationUz registration = _TranslationsRegistrationUz._(_root);
	@override late final _TranslationsCommonUz common = _TranslationsCommonUz._(_root);
	@override late final _TranslationsProfileUz profile = _TranslationsProfileUz._(_root);
	@override late final _TranslationsValidationUz validation = _TranslationsValidationUz._(_root);
	@override late final _TranslationsChooseUz choose = _TranslationsChooseUz._(_root);
	@override late final _TranslationsContactUz contact = _TranslationsContactUz._(_root);
	@override late final _TranslationsOptionalItemsUz optional_items = _TranslationsOptionalItemsUz._(_root);
	@override late final _TranslationsHomeUz home = _TranslationsHomeUz._(_root);
	@override late final _TranslationsBrandUz brand = _TranslationsBrandUz._(_root);
	@override late final _TranslationsOfferUz offer = _TranslationsOfferUz._(_root);
	@override late final _TranslationsReviewsUz reviews = _TranslationsReviewsUz._(_root);
	@override late final _TranslationsNotificationsUz notifications = _TranslationsNotificationsUz._(_root);
	@override late final _TranslationsBillingUz billing = _TranslationsBillingUz._(_root);
	@override late final _TranslationsErrorsUz errors = _TranslationsErrorsUz._(_root);
}

// Path: splash
class _TranslationsSplashUz implements TranslationsSplashEn {
	_TranslationsSplashUz._(this._root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String app_version({required Object version}) => 'Ilova versoyasi ${version}';
}

// Path: onboarding
class _TranslationsOnboardingUz implements TranslationsOnboardingEn {
	_TranslationsOnboardingUz._(this._root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get kContinue => 'Davom etish';
}

// Path: login
class _TranslationsLoginUz implements TranslationsLoginEn {
	_TranslationsLoginUz._(this._root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get phone_number => 'Telefon raqam';
	@override String get welcome_msg => 'Findbrandface-ga xush kelibsiz';
	@override String get term_of_use_first => 'Kirish tugmasini bosish orqali barcha ';
	@override String get term_of_use_second => 'foydalanish shartlariga rozilik bildiraman';
	@override String get login_methods => 'yoki ... orqali kirish';
	@override String get sms_confirmation => 'SMS tasdiqlash';
	@override String sms_sent_to({required Object phoneEnd}) => 'Telefon raqamingizga **${phoneEnd} SMS kod yuborildi, iltimos kodni kiriting';
	@override String get send_code_again => 'Kodni qayta yuborish';
	@override String get soon_title => 'Tez orada';
	@override String soon_message({required Object provider}) => '${provider} orqali kirish tez orada qo\'shiladi.';
	@override String get social_login_failed => 'Social orqali kirish amalga oshmadi';
	@override String get social_login_cancelled => 'Kirish bekor qilindi';
	@override String get linkedin_title => 'LinkedIn orqali kirish';
	@override String get telegram_title => 'Telegram orqali kirish';
}

// Path: registration
class _TranslationsRegistrationUz implements TranslationsRegistrationEn {
	_TranslationsRegistrationUz._(this._root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ro\'yxatdan o\'tish';
	@override String get influencer => 'Influencer';
	@override String get ambassador => 'Ambassador';
	@override String get brand => 'Brand';
	@override String get your_name => 'Ismingiz';
	@override String get your_surname => 'Familiyangiz';
	@override String get full_name => 'To\'liq ism';
	@override String get brand_name => 'Brand nomi';
	@override String get upload_profile_picture => 'Profil rasmini yuklash';
	@override String get choose_file => 'Fayl tanlash';
	@override String get file_format_hint => 'SVG, PNG, JPG yoki GIF (MAX. 800x400px).';
	@override String get spoken_languages => 'So\'zlashuv tillari';
	@override String get date_of_birth => 'Tug\'ilgan sana';
	@override String get gender => 'Jinsi';
	@override String get male => 'Erkak';
	@override String get female => 'Ayol';
	@override String get contact_details => 'Aloqa ma\'lumotlari';
	@override String get profile_information => 'Profil ma\'lumotlari';
	@override String get brand_segment_fit => 'Brend segmenti';
	@override String get geography => 'Geografiya';
	@override String get selected_geography => 'Tanlangan geografiya';
	@override String get social_media_accounts => 'Ijtimoiy tarmoq hisoblar';
	@override String get paste_link_here => 'Havolani joylashtiring';
	@override String get men => 'Erkaklar';
	@override String get women => 'Ayollar';
	@override String get age_from => 'Yoshdan';
	@override String get age_to => 'Yoshgacha';
	@override String get years_of_camera_experience => 'Kamera tajribasi (yillar)';
	@override String get write_years_of_experience => 'Tajriba yillarini kiriting';
	@override String get optional_experience => 'Qo\'shimcha tajriba';
	@override String get partners => 'Hamkorlar';
	@override String get exclusivity_availability => 'Eksklyuzivlik mavjudligi';
	@override String get write_award_info => 'Mukofot ma\'lumotlarini kiriting';
	@override String get years_of_experience => 'Tajriba yillari';
	@override String get niches => 'Nichlar';
	@override String get selected_niches => 'Tanlangan nichlar';
	@override String get services => 'Xizmatlar';
	@override String get currency => 'Valyuta';
	@override String get min => 'Min';
	@override String get max => 'Max';
	@override String get write_hourly_rate => 'Soatlik narxingizni kiriting';
	@override String get projectly_payment_starting_price => 'Loyiha bo\'yicha boshlang\'ich narx';
	@override String get write_starting_price => 'Boshlang\'ich narxni kiriting';
	@override String get payment_types => 'To\'lov turlari';
	@override String get categories => 'Kategoriyalar';
	@override String get selected_categories => 'Tanlangan kategoriyalar';
	@override String get experience_in_referral => 'Referral/promo kod kampaniyalarida tajribangiz bormi?';
	@override String get describe_your_experience => 'Tajribangizni tasvirlab bering';
	@override String get region => 'Viloyat';
	@override String get city => 'Shahar';
	@override String get sphere => 'Soha';
	@override String get available_for_long_term_contract => 'Uzoq muddatli shartnoma uchun mavjudmisiz?';
	@override String get kpi_based_model => 'KPI asosidagi model';
	@override String get available_for_offline_events => 'Oflayn tadbirlar uchun mavjudmisiz';
	@override String get pricing_options => 'Narxlash variantlari';
	@override String get do_not_have_account => 'hisobingiz yo\'qmi';
	@override String get no_languages_found => 'Tillar topilmadi';
	@override String get service_creating_reels_placeholder => 'Reels yaratish';
	@override String get niche_business_placeholder => 'Biznes';
}

// Path: common
class _TranslationsCommonUz implements TranslationsCommonEn {
	_TranslationsCommonUz._(this._root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get select => 'Tanlash';
	@override String get confirm => 'Tasdiqlash';
	@override String get cancel => 'Bekor qilish';
	@override String get apply => 'Qo\'llash';
	@override String get delete => 'O\'chirish';
	@override String get yes => 'Ha';
	@override String get no => 'Yo\'q';
	@override String get write_text_here => 'Matn yozing...';
	@override String get please_enter_text => 'Iltimos, matn kiriting';
	@override String get email => 'Email';
	@override String get set_as_main => 'Asosiy qilib belgilash';
	@override String get ok => 'OK';
	@override String get submit => 'Yuborish';
	@override String get loading => 'Yuklanmoqda...';
	@override String get deadline => 'Muddat';
	@override String get menu => 'Menyu';
	@override String get messages => 'Xabarlar';
	@override String get active_offers => 'Faol takliflar';
	@override String get recommended_for_you => 'Siz uchun tavsiya etiladi';
	@override String get offers_from_brands => 'Brendlardan takliflar';
	@override String get niche_type => 'Nicha turi';
	@override String get offer_title_placeholder => 'Taklif sarlavhasi';
	@override String get try_again => 'Qayta urinish';
	@override String get back => 'Orqaga';
	@override String get any => 'Har qanday';
	@override String get not_specified => 'Ko\'rsatilmagan';
	@override String get unknown => 'Noma\'lum';
	@override String get unknown_date => 'Sana noma\'lum';
	@override String get pull_refresh_or_retry => 'Yangilash uchun torting yoki qayta urining.';
	@override String get pull_refresh_check_soon => 'Yangilash uchun torting va tez orada tekshiring.';
	@override String get error_occurred => 'Xatolik yuz berdi';
	@override String get open => 'Ochiq';
	@override String get date_format_hint => 'KK.OO.YYYY';
	@override String get continue_label => 'Davom etish';
	@override String get general => 'Umumiy';
	@override String get requirements_label => 'Talablar';
	@override String get details_label => 'Tafsilotlar';
	@override String get select_country => 'Mamlakat tanlash';
	@override String get select_visibility => 'Ko\'rinishni tanlash';
	@override String get age_range => 'Yosh oralig\'i';
	@override String get public => 'Ochiq';
	@override String get private => 'Yopiq';
	@override String get duration_1_week => '1 hafta';
	@override String get duration_2_weeks => '2 hafta';
	@override String get duration_1_month => '1 oy';
	@override String get duration_2_months => '2 oy';
	@override String get duration_3_months => '3 oy';
	@override String get default_label => 'Asosiy';
	@override String get set_default => 'Asosiy qilish';
	@override String get no_contact_details => 'Aloqa ma\'lumotlari mavjud emas';
}

// Path: profile
class _TranslationsProfileUz implements TranslationsProfileEn {
	_TranslationsProfileUz._(this._root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get profile_page => 'Profil sahifasi';
	@override String get stats => 'Statistika';
	@override String get reviews => 'Sharhlar';
	@override String get calendar => 'Taqvim';
	@override String get portfolio => 'Portfolio';
	@override String get billing => 'To\'lovlar';
	@override String get make_profile_top => 'Profilni TOP ga chiqarish';
	@override String get app_language => 'Ilova tili';
	@override String get terms_and_conditions => 'Foydalanish shartlari';
	@override String get log_out => 'Chiqish';
	@override String get general_info => 'Umumiy ma\'lumot';
	@override String get audience_and_followers => 'Auditoriya va obunachilar';
	@override String get experience => 'Tajriba';
	@override String get awards => 'Mukofotlar';
	@override String get pricing_tariffs => 'Narxlar / Tariflar';
	@override String get payment_type => 'To\'lov turi';
	@override String get delete_account => 'Hisobni o\'chirish';
	@override String get delete_account_confirm => 'Hisobingizni o\'chirishga ishonchingiz komilmi? Bu amalni qaytarib bo\'lmaydi.';
	@override String age_range({required Object from, required Object to}) => 'Yosh ${from} - ${to}';
	@override String get confirm_delete => 'O\'chirishni tasdiqlang';
	@override String get total_followers => 'Jami obunachilar';
	@override String get engagement_rate => 'Faollik darajasi';
}

// Path: validation
class _TranslationsValidationUz implements TranslationsValidationEn {
	_TranslationsValidationUz._(this._root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get name_required => 'Iltimos, ism va familiyangizni kiriting';
	@override String get name_full_required => 'Iltimos, to\'liq ism va familiyangizni kiriting';
	@override String get name_letters_only => 'Ismda faqat harflar bo\'lishi kerak';
	@override String get name_too_short => 'Ism juda qisqa';
	@override String get fill_required_fields => 'Majburiy maydonlarni to\'ldiring';
	@override String get account_already_added => 'Hisob allaqachon qo\'shilgan';
}

// Path: choose
class _TranslationsChooseUz implements TranslationsChooseEn {
	_TranslationsChooseUz._(this._root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get select_niche => 'Niche tanlash';
	@override String get select_gender => 'Jins tanlash';
	@override String get select_geography => 'Geografiya tanlash';
	@override String get select_currency => 'Valyuta tanlash';
	@override String get select_partners => 'Hamkor tanlash';
	@override String get select_service => 'Xizmat tanlash';
	@override String get select_date_of_birth => 'Tug\'ilgan sanani tanlash';
	@override String get select_contact_detail => 'Aloqa ma\'lumotini tanlash';
	@override String get spoken_language => 'So\'zlashuv tili';
	@override String get select_region => 'Viloyat tanlash';
	@override String get select_city => 'Shahar tanlash';
	@override String get select_sphere => 'Soha tanlash';
	@override String get select_payment_type => 'To\'lov turini tanlash';
}

// Path: contact
class _TranslationsContactUz implements TranslationsContactEn {
	_TranslationsContactUz._(this._root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get phone => 'Telefon';
	@override String get telegram => 'Telegram';
	@override String get instagram => 'Instagram';
	@override String get telegram_user_name => 'Telegram foydalanuvchi nomi';
	@override String get instagram_account => 'Instagram hisobi';
	@override String get no_contact_details => 'Aloqa ma\'lumotlari mavjud emas';
}

// Path: optional_items
class _TranslationsOptionalItemsUz implements TranslationsOptionalItemsEn {
	_TranslationsOptionalItemsUz._(this._root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get tv_ad_experience => 'TV/Reklama tajribasi';
	@override String get press_mentions => 'Matbuot eslatmalari';
	@override String get agency_representation => 'Agentlik vakilligi';
	@override String get previous_brand_collaborations => 'Oldingi brend hamkorliklari';
	@override String get case_study_link => 'Keis havolasi yoki skrinshot';
	@override String get conversion_metrics => 'Konversiya ko\'rsatkichlari (mavjud bo\'lsa)';
	@override String get willing_to_work_kpi => 'KPI asosida ishlashga tayyorman';
	@override String get campaign_based_fee => 'Kampaniya asosidagi to\'lov';
	@override String get event_appearance_fee => 'Tadbirda qatnashish to\'lovi';
}

// Path: home
class _TranslationsHomeUz implements TranslationsHomeEn {
	_TranslationsHomeUz._(this._root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get offers_and_messages => 'Takliflar va xabarlar';
	@override String get recommendations_for_you => 'Siz uchun tavsiyalar';
	@override String get flexible_reward => 'Moslashuvchan';
	@override String get new_recommendation => 'Profilingizga mos yangi tavsiya.';
	@override String get error_load => 'Asosiy sahifa ma\'lumotlari yuklanmadi.';
	@override String get empty_recommendations => 'Mos natijalar tayyor bo\'lganda tavsiyalar bu yerda ko\'rinadi.';
	@override String get pending_approval_text => 'Profilingiz hali ko\'rib chiqilmoqda. Takliflar va tavsiyalar tasdiqlangandan keyin ko\'rinadi.';
	@override String get pending_approval_banner => 'Profilingiz tasdiqlanishini kutmoqda. Xabarlar va bildirishnomalar hozir mavjud, taklif vositalari moderatsiyadan so\'ng ochiladi.';
}

// Path: brand
class _TranslationsBrandUz implements TranslationsBrandEn {
	_TranslationsBrandUz._(this._root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Brend';
	@override String get offers_and_applications => 'Takliflar va arizalar';
	@override String get new_applications => 'Yangi arizalar';
	@override String get ai_matching => 'AI moslashtirish';
	@override String get top_label => 'TOP';
	@override String get no_active_campaigns_yet => 'Hali faol kampaniyalar yo\'q';
	@override String get collaboration_offers => 'Hamkorlik takliflari';
	@override String get brandfaces => 'Brandfaces';
	@override String get ambassadors => 'Ambassadorlar';
	@override String get influencers => 'Influencerlar';
	@override String get favourites => 'Sevimlilar';
	@override String get analytics => 'Analitika';
	@override String get influencer_tab => 'Influencer';
	@override String get ambassadors_tab => 'Ambassadorlar';
	@override String get brand_profile => 'Brend profili';
	@override String get website => 'Veb-sayt';
	@override String get actives => 'Faollar';
	@override String get archived => 'Arxivlangan';
	@override String get views => 'Ko\'rishlar';
	@override String get applications => 'Arizalar';
	@override String get search => 'Qidirish';
	@override String get new_offer => 'Yangi taklif';
	@override String get sort_by => 'Saralash';
	@override String get sort_by_ranking => 'Reytingga ko\'ra saralash';
	@override String get sort_by_newly_joined => 'Yangi qo\'shilganlarga ko\'ra saralash';
	@override String get sort_by_followers => 'Obunachilar soniga ko\'ra saralash';
	@override String get sort_by_experience => 'Tajribaga ko\'ra saralash';
	@override String get sort_by_views => 'Ko\'rishlar bo\'yicha saralash';
	@override String get sort_by_applications => 'Arizalar bo\'yicha saralash';
	@override String get filter => 'Filtr';
	@override String get rank_type => 'Daraja turi';
	@override String get vip_label => 'VIP';
	@override String ambassadors_found({required Object count}) => '${count} ambassador topildi';
	@override String get no_ambassadors_found => 'Ambassador topilmadi';
	@override String followers_count({required Object count}) => '${count} ta obunachi';
	@override String years_experience({required Object count}) => '${count} yil tajriba';
	@override String get collaboration_offer_details => 'Hamkorlik taklifi tafsilotlari';
	@override String get offer_failed_load => 'Taklif yuklanmadi.';
	@override String get offer_complete => 'Yakunlash';
}

// Path: offer
class _TranslationsOfferUz implements TranslationsOfferEn {
	_TranslationsOfferUz._(this._root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get offer_details => 'Taklif tafsilotlari';
	@override String get offer_title => 'Taklif sarlavhasi';
	@override String get description => 'Tavsif';
	@override String get status => 'Holati';
	@override String get requirements => 'Talablar';
	@override String get country => 'Davlat';
	@override String get city => 'Shahar';
	@override String get followers_max => 'Maksimal obunachilar';
	@override String get followers_min => 'Minimal obunachilar';
	@override String get languages => 'Tillar';
	@override String get engagement_rate => 'Faollik darajasi';
	@override String get content_type => 'Kontent turi';
	@override String get gender => 'Jinsi';
	@override String get collaboration_details => 'Hamkorlik tafsilotlari';
	@override String get duration => 'Davomiyligi';
	@override String get visibility => 'Ko\'rinishi';
	@override String get application_submitted => 'Ariza muvaffaqiyatli yuborildi.';
	@override String get error_could_not_open => 'Taklif ochilmadi.';
	@override String get error_no_id => 'Taklif ID ko\'rsatilmagan.';
	@override String get error_retry_message => 'Orqaga torting va taklifni qayta oching.';
	@override String get not_found => 'Taklif topilmadi.';
	@override String get no_detail_data => 'Bu taklif uchun ma\'lumot mavjud emas.';
	@override String get apply_title => 'Bu taklifga ariza berish';
	@override String get cover_letter_subtitle => 'Ixtiyoriy qo\'shimcha xat qo\'shing.';
	@override String get cover_letter_label => 'Qo\'shimcha xat';
	@override String get cover_letter_hint => 'Qisqa xabar yozing';
	@override String get submit_application => 'Arizani yuborish';
	@override String get continue_without_cover_letter => 'Qo\'shimcha xatsiz davom etish';
	@override String get general_info => 'Umumiy ma\'lumot';
	@override String get no_category => 'Kategoriya yo\'q';
	@override String get create_title => 'Yangi hamkorlik taklifi qo\'shish';
	@override String get title_hint => 'Taklif nomini yozing';
	@override String get applied => 'Yuborildi';
	@override String get submitting => 'Yuborilmoqda...';
	@override String get apply_now => 'Hozir ariza berish';
	@override String get no_deadline => 'Muddat yo\'q';
	@override String get open_deadline => 'Ochiq';
	@override String get reward => 'Mukofot';
	@override String get no_offers_available => 'Hozirda takliflar mavjud emas.';
	@override String no_offers_for_niche({required Object niche}) => '${niche} uchun takliflar topilmadi.';
	@override String get offers_error_load => 'Takliflar yuklanmadi.';
	@override String get open_collaboration => 'Influencerlar uchun ochiq hamkorlik taklifi';
	@override String get new_offer_success => 'Yangi hamkorlik taklifi\nmuvaffaqiyatli qo\'shildi';
	@override String get page_title => 'Brendlardan takliflar';
	@override String get all_niches => 'Barcha nichlar';
	@override String get no_recommendations => 'Hali tavsiyalar yo\'q.';
	@override String get recommendations_subtitle => 'Mos takliflar paydo bo\'lganda bu yerda ko\'rsatamiz.';
}

// Path: reviews
class _TranslationsReviewsUz implements TranslationsReviewsEn {
	_TranslationsReviewsUz._(this._root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get average => 'O\'rtacha';
	@override String get client_reviews => 'Mijoz sharhlari';
	@override String get title => 'Sharhlar';
	@override String get no_reviews => 'Hali sharhlar yo\'q.';
	@override String get no_review_text => 'Sharh matni yo\'q.';
	@override String get error_load => 'Sharhlar yuklanmadi.';
}

// Path: notifications
class _TranslationsNotificationsUz implements TranslationsNotificationsEn {
	_TranslationsNotificationsUz._(this._root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Bildirishnomalar';
	@override String get read_all => 'Barchasini o\'qish';
	@override String get no_notifications => 'Hali bildirishnomalar yo\'q.';
	@override String get error_load => 'Bildirishnomalar yuklanmadi.';
}

// Path: billing
class _TranslationsBillingUz implements TranslationsBillingEn {
	_TranslationsBillingUz._(this._root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get plan_tab => 'Tarif';
	@override String get my_cards_tab => 'Kartalarim';
	@override String get history_tab => 'To\'lovlar tarixi';
	@override String get current_plan => 'Joriy tarif';
	@override String get boost_profile => 'Profilni kuchaytirish';
	@override String get processing => 'Qayta ishlanmoqda...';
	@override String get cancel_subscription => 'Obunani bekor qilish';
	@override String get add_new_card => 'Yangi karta qo\'shish';
	@override String get issue_date => 'Sana';
	@override String get amount => 'Miqdor';
	@override String get start_date => 'Boshlanish sanasi';
	@override String get add_payment_card => 'To\'lov kartasi qo\'shish';
	@override String get set_as_default => 'Asosiy qilib belgilash';
	@override String get save_card => 'Kartani saqlash';
	@override String get fill_valid_card_details => 'Karta ma\'lumotlarini to\'ldiring.';
	@override String get last_four_digits => 'Oxirgi to\'rt raqam';
	@override String get expiry_month => 'Tugash oyi';
	@override String get expiry_year => 'Tugash yili';
	@override String get gateway_token => 'Gateway token';
	@override String get card_type => 'Karta turi';
	@override String get no_billing_history => 'To\'lovlar tarixi yo\'q.';
	@override String get error_load => 'To\'lov ma\'lumotlari yuklanmadi.';
	@override String get no_active_subscription => 'Faol obuna yo\'q';
	@override String get per_month => '/ oy';
	@override String get add_payment_card_first => 'Avval to\'lov kartasini qo\'shing.';
	@override String get contact_unlock => 'Kontakt ochish:';
	@override String get profile_offer_boost => 'Profil / Taklif kuchaytirish:';
	@override String get pay_as_you_go => 'Qo\'shimcha xizmatlar (shaffof)';
	@override String card_ending_in({required Object cardType, required Object lastFour}) => '${cardType} oxiri ${lastFour}';
	@override String card_expiry({required Object month, required Object year}) => 'Tugash ${month}/${year}';
	@override String transaction_label({required Object id}) => 'To\'lov #${id}';
	@override String get delete_card => 'O\'chirish';
	@override String get default_card => 'Asosiy';
	@override String get set_default_card => 'Asosiy qilish';
	@override String get no_plan => 'Tarif yo\'q';
	@override String get no_feature_details => 'Imkoniyatlar haqida ma\'lumot yo\'q';
	@override String days({required Object days}) => '${days} kun';
}

// Path: errors
class _TranslationsErrorsUz implements TranslationsErrorsEn {
	_TranslationsErrorsUz._(this._root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get network => 'Internet bilan bog\'lanishda muammo, aloqani tekshiring';
	@override String get parsing => 'Ma\'lumotlarni qayta ishlashda xatolik';
	@override String get unknown => 'Noma\'lum xatolik yuz berdi';
	@override String get session_expired => 'Sessiya tugadi';
	@override String get redirect_to_login => 'Qayta kirish uchun login sahifasiga yo\'naltirilasiz.';
	@override late final _TranslationsErrorsServerUz server = _TranslationsErrorsServerUz._(_root);
}

// Path: errors.server
class _TranslationsErrorsServerUz implements TranslationsErrorsServerEn {
	_TranslationsErrorsServerUz._(this._root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String defaultMsg({required Object code}) => 'Server xatoligi (${code})';
	@override String get badRequest => 'Noto\'g\'ri so\'rov';
	@override String get unauthorized => 'Seans muddati tugadi, qaytadan kiring';
	@override String get notFound => 'Ma\'lumot topilmadi';
	@override String get userExists => 'Bunday emailga ega foydalanuvchi allaqachon mavjud';
}

/// The flat map containing all translations for locale <uz>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsUz {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'splash.app_version' => ({required Object version}) => 'Ilova versoyasi ${version}',
			'onboarding.kContinue' => 'Davom etish',
			'login.phone_number' => 'Telefon raqam',
			'login.welcome_msg' => 'Findbrandface-ga xush kelibsiz',
			'login.term_of_use_first' => 'Kirish tugmasini bosish orqali barcha ',
			'login.term_of_use_second' => 'foydalanish shartlariga rozilik bildiraman',
			'login.login_methods' => 'yoki ... orqali kirish',
			'login.sms_confirmation' => 'SMS tasdiqlash',
			'login.sms_sent_to' => ({required Object phoneEnd}) => 'Telefon raqamingizga **${phoneEnd} SMS kod yuborildi, iltimos kodni kiriting',
			'login.send_code_again' => 'Kodni qayta yuborish',
			'login.soon_title' => 'Tez orada',
			'login.soon_message' => ({required Object provider}) => '${provider} orqali kirish tez orada qo\'shiladi.',
			'login.social_login_failed' => 'Social orqali kirish amalga oshmadi',
			'login.social_login_cancelled' => 'Kirish bekor qilindi',
			'login.linkedin_title' => 'LinkedIn orqali kirish',
			'login.telegram_title' => 'Telegram orqali kirish',
			'registration.title' => 'Ro\'yxatdan o\'tish',
			'registration.influencer' => 'Influencer',
			'registration.ambassador' => 'Ambassador',
			'registration.brand' => 'Brand',
			'registration.your_name' => 'Ismingiz',
			'registration.your_surname' => 'Familiyangiz',
			'registration.full_name' => 'To\'liq ism',
			'registration.brand_name' => 'Brand nomi',
			'registration.upload_profile_picture' => 'Profil rasmini yuklash',
			'registration.choose_file' => 'Fayl tanlash',
			'registration.file_format_hint' => 'SVG, PNG, JPG yoki GIF (MAX. 800x400px).',
			'registration.spoken_languages' => 'So\'zlashuv tillari',
			'registration.date_of_birth' => 'Tug\'ilgan sana',
			'registration.gender' => 'Jinsi',
			'registration.male' => 'Erkak',
			'registration.female' => 'Ayol',
			'registration.contact_details' => 'Aloqa ma\'lumotlari',
			'registration.profile_information' => 'Profil ma\'lumotlari',
			'registration.brand_segment_fit' => 'Brend segmenti',
			'registration.geography' => 'Geografiya',
			'registration.selected_geography' => 'Tanlangan geografiya',
			'registration.social_media_accounts' => 'Ijtimoiy tarmoq hisoblar',
			'registration.paste_link_here' => 'Havolani joylashtiring',
			'registration.men' => 'Erkaklar',
			'registration.women' => 'Ayollar',
			'registration.age_from' => 'Yoshdan',
			'registration.age_to' => 'Yoshgacha',
			'registration.years_of_camera_experience' => 'Kamera tajribasi (yillar)',
			'registration.write_years_of_experience' => 'Tajriba yillarini kiriting',
			'registration.optional_experience' => 'Qo\'shimcha tajriba',
			'registration.partners' => 'Hamkorlar',
			'registration.exclusivity_availability' => 'Eksklyuzivlik mavjudligi',
			'registration.write_award_info' => 'Mukofot ma\'lumotlarini kiriting',
			'registration.years_of_experience' => 'Tajriba yillari',
			'registration.niches' => 'Nichlar',
			'registration.selected_niches' => 'Tanlangan nichlar',
			'registration.services' => 'Xizmatlar',
			'registration.currency' => 'Valyuta',
			'registration.min' => 'Min',
			'registration.max' => 'Max',
			'registration.write_hourly_rate' => 'Soatlik narxingizni kiriting',
			'registration.projectly_payment_starting_price' => 'Loyiha bo\'yicha boshlang\'ich narx',
			'registration.write_starting_price' => 'Boshlang\'ich narxni kiriting',
			'registration.payment_types' => 'To\'lov turlari',
			'registration.categories' => 'Kategoriyalar',
			'registration.selected_categories' => 'Tanlangan kategoriyalar',
			'registration.experience_in_referral' => 'Referral/promo kod kampaniyalarida tajribangiz bormi?',
			'registration.describe_your_experience' => 'Tajribangizni tasvirlab bering',
			'registration.region' => 'Viloyat',
			'registration.city' => 'Shahar',
			'registration.sphere' => 'Soha',
			'registration.available_for_long_term_contract' => 'Uzoq muddatli shartnoma uchun mavjudmisiz?',
			'registration.kpi_based_model' => 'KPI asosidagi model',
			'registration.available_for_offline_events' => 'Oflayn tadbirlar uchun mavjudmisiz',
			'registration.pricing_options' => 'Narxlash variantlari',
			'registration.do_not_have_account' => 'hisobingiz yo\'qmi',
			'registration.no_languages_found' => 'Tillar topilmadi',
			'registration.service_creating_reels_placeholder' => 'Reels yaratish',
			'registration.niche_business_placeholder' => 'Biznes',
			'common.select' => 'Tanlash',
			'common.confirm' => 'Tasdiqlash',
			'common.cancel' => 'Bekor qilish',
			'common.apply' => 'Qo\'llash',
			'common.delete' => 'O\'chirish',
			'common.yes' => 'Ha',
			'common.no' => 'Yo\'q',
			'common.write_text_here' => 'Matn yozing...',
			'common.please_enter_text' => 'Iltimos, matn kiriting',
			'common.email' => 'Email',
			'common.set_as_main' => 'Asosiy qilib belgilash',
			'common.ok' => 'OK',
			'common.submit' => 'Yuborish',
			'common.loading' => 'Yuklanmoqda...',
			'common.deadline' => 'Muddat',
			'common.menu' => 'Menyu',
			'common.messages' => 'Xabarlar',
			'common.active_offers' => 'Faol takliflar',
			'common.recommended_for_you' => 'Siz uchun tavsiya etiladi',
			'common.offers_from_brands' => 'Brendlardan takliflar',
			'common.niche_type' => 'Nicha turi',
			'common.offer_title_placeholder' => 'Taklif sarlavhasi',
			'common.try_again' => 'Qayta urinish',
			'common.back' => 'Orqaga',
			'common.any' => 'Har qanday',
			'common.not_specified' => 'Ko\'rsatilmagan',
			'common.unknown' => 'Noma\'lum',
			'common.unknown_date' => 'Sana noma\'lum',
			'common.pull_refresh_or_retry' => 'Yangilash uchun torting yoki qayta urining.',
			'common.pull_refresh_check_soon' => 'Yangilash uchun torting va tez orada tekshiring.',
			'common.error_occurred' => 'Xatolik yuz berdi',
			'common.open' => 'Ochiq',
			'common.date_format_hint' => 'KK.OO.YYYY',
			'common.continue_label' => 'Davom etish',
			'common.general' => 'Umumiy',
			'common.requirements_label' => 'Talablar',
			'common.details_label' => 'Tafsilotlar',
			'common.select_country' => 'Mamlakat tanlash',
			'common.select_visibility' => 'Ko\'rinishni tanlash',
			'common.age_range' => 'Yosh oralig\'i',
			'common.public' => 'Ochiq',
			'common.private' => 'Yopiq',
			'common.duration_1_week' => '1 hafta',
			'common.duration_2_weeks' => '2 hafta',
			'common.duration_1_month' => '1 oy',
			'common.duration_2_months' => '2 oy',
			'common.duration_3_months' => '3 oy',
			'common.default_label' => 'Asosiy',
			'common.set_default' => 'Asosiy qilish',
			'common.no_contact_details' => 'Aloqa ma\'lumotlari mavjud emas',
			'profile.profile_page' => 'Profil sahifasi',
			'profile.stats' => 'Statistika',
			'profile.reviews' => 'Sharhlar',
			'profile.calendar' => 'Taqvim',
			'profile.portfolio' => 'Portfolio',
			'profile.billing' => 'To\'lovlar',
			'profile.make_profile_top' => 'Profilni TOP ga chiqarish',
			'profile.app_language' => 'Ilova tili',
			'profile.terms_and_conditions' => 'Foydalanish shartlari',
			'profile.log_out' => 'Chiqish',
			'profile.general_info' => 'Umumiy ma\'lumot',
			'profile.audience_and_followers' => 'Auditoriya va obunachilar',
			'profile.experience' => 'Tajriba',
			'profile.awards' => 'Mukofotlar',
			'profile.pricing_tariffs' => 'Narxlar / Tariflar',
			'profile.payment_type' => 'To\'lov turi',
			'profile.delete_account' => 'Hisobni o\'chirish',
			'profile.delete_account_confirm' => 'Hisobingizni o\'chirishga ishonchingiz komilmi? Bu amalni qaytarib bo\'lmaydi.',
			'profile.age_range' => ({required Object from, required Object to}) => 'Yosh ${from} - ${to}',
			'profile.confirm_delete' => 'O\'chirishni tasdiqlang',
			'profile.total_followers' => 'Jami obunachilar',
			'profile.engagement_rate' => 'Faollik darajasi',
			'validation.name_required' => 'Iltimos, ism va familiyangizni kiriting',
			'validation.name_full_required' => 'Iltimos, to\'liq ism va familiyangizni kiriting',
			'validation.name_letters_only' => 'Ismda faqat harflar bo\'lishi kerak',
			'validation.name_too_short' => 'Ism juda qisqa',
			'validation.fill_required_fields' => 'Majburiy maydonlarni to\'ldiring',
			'validation.account_already_added' => 'Hisob allaqachon qo\'shilgan',
			'choose.select_niche' => 'Niche tanlash',
			'choose.select_gender' => 'Jins tanlash',
			'choose.select_geography' => 'Geografiya tanlash',
			'choose.select_currency' => 'Valyuta tanlash',
			'choose.select_partners' => 'Hamkor tanlash',
			'choose.select_service' => 'Xizmat tanlash',
			'choose.select_date_of_birth' => 'Tug\'ilgan sanani tanlash',
			'choose.select_contact_detail' => 'Aloqa ma\'lumotini tanlash',
			'choose.spoken_language' => 'So\'zlashuv tili',
			'choose.select_region' => 'Viloyat tanlash',
			'choose.select_city' => 'Shahar tanlash',
			'choose.select_sphere' => 'Soha tanlash',
			'choose.select_payment_type' => 'To\'lov turini tanlash',
			'contact.phone' => 'Telefon',
			'contact.telegram' => 'Telegram',
			'contact.instagram' => 'Instagram',
			'contact.telegram_user_name' => 'Telegram foydalanuvchi nomi',
			'contact.instagram_account' => 'Instagram hisobi',
			'contact.no_contact_details' => 'Aloqa ma\'lumotlari mavjud emas',
			'optional_items.tv_ad_experience' => 'TV/Reklama tajribasi',
			'optional_items.press_mentions' => 'Matbuot eslatmalari',
			'optional_items.agency_representation' => 'Agentlik vakilligi',
			'optional_items.previous_brand_collaborations' => 'Oldingi brend hamkorliklari',
			'optional_items.case_study_link' => 'Keis havolasi yoki skrinshot',
			'optional_items.conversion_metrics' => 'Konversiya ko\'rsatkichlari (mavjud bo\'lsa)',
			'optional_items.willing_to_work_kpi' => 'KPI asosida ishlashga tayyorman',
			'optional_items.campaign_based_fee' => 'Kampaniya asosidagi to\'lov',
			'optional_items.event_appearance_fee' => 'Tadbirda qatnashish to\'lovi',
			'home.offers_and_messages' => 'Takliflar va xabarlar',
			'home.recommendations_for_you' => 'Siz uchun tavsiyalar',
			'home.flexible_reward' => 'Moslashuvchan',
			'home.new_recommendation' => 'Profilingizga mos yangi tavsiya.',
			'home.error_load' => 'Asosiy sahifa ma\'lumotlari yuklanmadi.',
			'home.empty_recommendations' => 'Mos natijalar tayyor bo\'lganda tavsiyalar bu yerda ko\'rinadi.',
			'home.pending_approval_text' => 'Profilingiz hali ko\'rib chiqilmoqda. Takliflar va tavsiyalar tasdiqlangandan keyin ko\'rinadi.',
			'home.pending_approval_banner' => 'Profilingiz tasdiqlanishini kutmoqda. Xabarlar va bildirishnomalar hozir mavjud, taklif vositalari moderatsiyadan so\'ng ochiladi.',
			'brand.title' => 'Brend',
			'brand.offers_and_applications' => 'Takliflar va arizalar',
			'brand.new_applications' => 'Yangi arizalar',
			'brand.ai_matching' => 'AI moslashtirish',
			'brand.top_label' => 'TOP',
			'brand.no_active_campaigns_yet' => 'Hali faol kampaniyalar yo\'q',
			'brand.collaboration_offers' => 'Hamkorlik takliflari',
			'brand.brandfaces' => 'Brandfaces',
			'brand.ambassadors' => 'Ambassadorlar',
			'brand.influencers' => 'Influencerlar',
			'brand.favourites' => 'Sevimlilar',
			'brand.analytics' => 'Analitika',
			'brand.influencer_tab' => 'Influencer',
			'brand.ambassadors_tab' => 'Ambassadorlar',
			'brand.brand_profile' => 'Brend profili',
			'brand.website' => 'Veb-sayt',
			'brand.actives' => 'Faollar',
			'brand.archived' => 'Arxivlangan',
			'brand.views' => 'Ko\'rishlar',
			'brand.applications' => 'Arizalar',
			'brand.search' => 'Qidirish',
			'brand.new_offer' => 'Yangi taklif',
			'brand.sort_by' => 'Saralash',
			'brand.sort_by_ranking' => 'Reytingga ko\'ra saralash',
			'brand.sort_by_newly_joined' => 'Yangi qo\'shilganlarga ko\'ra saralash',
			'brand.sort_by_followers' => 'Obunachilar soniga ko\'ra saralash',
			'brand.sort_by_experience' => 'Tajribaga ko\'ra saralash',
			'brand.sort_by_views' => 'Ko\'rishlar bo\'yicha saralash',
			'brand.sort_by_applications' => 'Arizalar bo\'yicha saralash',
			'brand.filter' => 'Filtr',
			'brand.rank_type' => 'Daraja turi',
			'brand.vip_label' => 'VIP',
			'brand.ambassadors_found' => ({required Object count}) => '${count} ambassador topildi',
			'brand.no_ambassadors_found' => 'Ambassador topilmadi',
			'brand.followers_count' => ({required Object count}) => '${count} ta obunachi',
			'brand.years_experience' => ({required Object count}) => '${count} yil tajriba',
			'brand.collaboration_offer_details' => 'Hamkorlik taklifi tafsilotlari',
			'brand.offer_failed_load' => 'Taklif yuklanmadi.',
			'brand.offer_complete' => 'Yakunlash',
			'offer.offer_details' => 'Taklif tafsilotlari',
			'offer.offer_title' => 'Taklif sarlavhasi',
			'offer.description' => 'Tavsif',
			'offer.status' => 'Holati',
			'offer.requirements' => 'Talablar',
			'offer.country' => 'Davlat',
			'offer.city' => 'Shahar',
			'offer.followers_max' => 'Maksimal obunachilar',
			'offer.followers_min' => 'Minimal obunachilar',
			'offer.languages' => 'Tillar',
			'offer.engagement_rate' => 'Faollik darajasi',
			'offer.content_type' => 'Kontent turi',
			'offer.gender' => 'Jinsi',
			'offer.collaboration_details' => 'Hamkorlik tafsilotlari',
			'offer.duration' => 'Davomiyligi',
			'offer.visibility' => 'Ko\'rinishi',
			'offer.application_submitted' => 'Ariza muvaffaqiyatli yuborildi.',
			'offer.error_could_not_open' => 'Taklif ochilmadi.',
			'offer.error_no_id' => 'Taklif ID ko\'rsatilmagan.',
			'offer.error_retry_message' => 'Orqaga torting va taklifni qayta oching.',
			'offer.not_found' => 'Taklif topilmadi.',
			'offer.no_detail_data' => 'Bu taklif uchun ma\'lumot mavjud emas.',
			'offer.apply_title' => 'Bu taklifga ariza berish',
			'offer.cover_letter_subtitle' => 'Ixtiyoriy qo\'shimcha xat qo\'shing.',
			'offer.cover_letter_label' => 'Qo\'shimcha xat',
			'offer.cover_letter_hint' => 'Qisqa xabar yozing',
			'offer.submit_application' => 'Arizani yuborish',
			'offer.continue_without_cover_letter' => 'Qo\'shimcha xatsiz davom etish',
			'offer.general_info' => 'Umumiy ma\'lumot',
			'offer.no_category' => 'Kategoriya yo\'q',
			'offer.create_title' => 'Yangi hamkorlik taklifi qo\'shish',
			'offer.title_hint' => 'Taklif nomini yozing',
			'offer.applied' => 'Yuborildi',
			'offer.submitting' => 'Yuborilmoqda...',
			'offer.apply_now' => 'Hozir ariza berish',
			'offer.no_deadline' => 'Muddat yo\'q',
			'offer.open_deadline' => 'Ochiq',
			'offer.reward' => 'Mukofot',
			'offer.no_offers_available' => 'Hozirda takliflar mavjud emas.',
			'offer.no_offers_for_niche' => ({required Object niche}) => '${niche} uchun takliflar topilmadi.',
			'offer.offers_error_load' => 'Takliflar yuklanmadi.',
			'offer.open_collaboration' => 'Influencerlar uchun ochiq hamkorlik taklifi',
			'offer.new_offer_success' => 'Yangi hamkorlik taklifi\nmuvaffaqiyatli qo\'shildi',
			'offer.page_title' => 'Brendlardan takliflar',
			'offer.all_niches' => 'Barcha nichlar',
			'offer.no_recommendations' => 'Hali tavsiyalar yo\'q.',
			'offer.recommendations_subtitle' => 'Mos takliflar paydo bo\'lganda bu yerda ko\'rsatamiz.',
			'reviews.average' => 'O\'rtacha',
			'reviews.client_reviews' => 'Mijoz sharhlari',
			'reviews.title' => 'Sharhlar',
			'reviews.no_reviews' => 'Hali sharhlar yo\'q.',
			'reviews.no_review_text' => 'Sharh matni yo\'q.',
			'reviews.error_load' => 'Sharhlar yuklanmadi.',
			'notifications.title' => 'Bildirishnomalar',
			'notifications.read_all' => 'Barchasini o\'qish',
			'notifications.no_notifications' => 'Hali bildirishnomalar yo\'q.',
			'notifications.error_load' => 'Bildirishnomalar yuklanmadi.',
			'billing.plan_tab' => 'Tarif',
			'billing.my_cards_tab' => 'Kartalarim',
			'billing.history_tab' => 'To\'lovlar tarixi',
			'billing.current_plan' => 'Joriy tarif',
			'billing.boost_profile' => 'Profilni kuchaytirish',
			'billing.processing' => 'Qayta ishlanmoqda...',
			'billing.cancel_subscription' => 'Obunani bekor qilish',
			'billing.add_new_card' => 'Yangi karta qo\'shish',
			'billing.issue_date' => 'Sana',
			'billing.amount' => 'Miqdor',
			'billing.start_date' => 'Boshlanish sanasi',
			'billing.add_payment_card' => 'To\'lov kartasi qo\'shish',
			'billing.set_as_default' => 'Asosiy qilib belgilash',
			'billing.save_card' => 'Kartani saqlash',
			'billing.fill_valid_card_details' => 'Karta ma\'lumotlarini to\'ldiring.',
			'billing.last_four_digits' => 'Oxirgi to\'rt raqam',
			'billing.expiry_month' => 'Tugash oyi',
			'billing.expiry_year' => 'Tugash yili',
			'billing.gateway_token' => 'Gateway token',
			'billing.card_type' => 'Karta turi',
			'billing.no_billing_history' => 'To\'lovlar tarixi yo\'q.',
			'billing.error_load' => 'To\'lov ma\'lumotlari yuklanmadi.',
			'billing.no_active_subscription' => 'Faol obuna yo\'q',
			'billing.per_month' => '/ oy',
			'billing.add_payment_card_first' => 'Avval to\'lov kartasini qo\'shing.',
			'billing.contact_unlock' => 'Kontakt ochish:',
			'billing.profile_offer_boost' => 'Profil / Taklif kuchaytirish:',
			'billing.pay_as_you_go' => 'Qo\'shimcha xizmatlar (shaffof)',
			'billing.card_ending_in' => ({required Object cardType, required Object lastFour}) => '${cardType} oxiri ${lastFour}',
			'billing.card_expiry' => ({required Object month, required Object year}) => 'Tugash ${month}/${year}',
			'billing.transaction_label' => ({required Object id}) => 'To\'lov #${id}',
			'billing.delete_card' => 'O\'chirish',
			'billing.default_card' => 'Asosiy',
			'billing.set_default_card' => 'Asosiy qilish',
			'billing.no_plan' => 'Tarif yo\'q',
			'billing.no_feature_details' => 'Imkoniyatlar haqida ma\'lumot yo\'q',
			'billing.days' => ({required Object days}) => '${days} kun',
			'errors.network' => 'Internet bilan bog\'lanishda muammo, aloqani tekshiring',
			'errors.parsing' => 'Ma\'lumotlarni qayta ishlashda xatolik',
			'errors.unknown' => 'Noma\'lum xatolik yuz berdi',
			'errors.session_expired' => 'Sessiya tugadi',
			'errors.redirect_to_login' => 'Qayta kirish uchun login sahifasiga yo\'naltirilasiz.',
			'errors.server.defaultMsg' => ({required Object code}) => 'Server xatoligi (${code})',
			'errors.server.badRequest' => 'Noto\'g\'ri so\'rov',
			'errors.server.unauthorized' => 'Seans muddati tugadi, qaytadan kiring',
			'errors.server.notFound' => 'Ma\'lumot topilmadi',
			'errors.server.userExists' => 'Bunday emailga ega foydalanuvchi allaqachon mavjud',
			_ => null,
		};
	}
}
