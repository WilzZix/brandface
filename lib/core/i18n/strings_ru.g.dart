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
	@override late final _TranslationsCommonRu common = _TranslationsCommonRu._(_root);
	@override late final _TranslationsProfileRu profile = _TranslationsProfileRu._(_root);
	@override late final _TranslationsValidationRu validation = _TranslationsValidationRu._(_root);
	@override late final _TranslationsChooseRu choose = _TranslationsChooseRu._(_root);
	@override late final _TranslationsContactRu contact = _TranslationsContactRu._(_root);
	@override late final _TranslationsOptionalItemsRu optional_items = _TranslationsOptionalItemsRu._(_root);
	@override late final _TranslationsHomeRu home = _TranslationsHomeRu._(_root);
	@override late final _TranslationsBrandRu brand = _TranslationsBrandRu._(_root);
	@override late final _TranslationsOfferRu offer = _TranslationsOfferRu._(_root);
	@override late final _TranslationsReviewsRu reviews = _TranslationsReviewsRu._(_root);
	@override late final _TranslationsNotificationsRu notifications = _TranslationsNotificationsRu._(_root);
	@override late final _TranslationsBillingRu billing = _TranslationsBillingRu._(_root);
	@override late final _TranslationsErrorsRu errors = _TranslationsErrorsRu._(_root);
}

// Path: splash
class _TranslationsSplashRu implements TranslationsSplashEn {
	_TranslationsSplashRu._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String app_version({required Object version}) => 'Версия приложения ${version}';
}

// Path: onboarding
class _TranslationsOnboardingRu implements TranslationsOnboardingEn {
	_TranslationsOnboardingRu._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get kContinue => 'Продолжить';
}

// Path: login
class _TranslationsLoginRu implements TranslationsLoginEn {
	_TranslationsLoginRu._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get phone_number => 'Номер телефона';
	@override String get welcome_msg => 'Добро пожаловать в Findbrandface';
	@override String get term_of_use_first => 'Нажимая «Войти», я принимаю все ';
	@override String get term_of_use_second => 'условия использования';
	@override String get login_methods => 'или войти через';
	@override String get sms_confirmation => 'SMS подтверждение';
	@override String sms_sent_to({required Object phoneEnd}) => 'На ваш номер телефона **${phoneEnd} отправлен SMS код, пожалуйста введите его';
	@override String get send_code_again => 'Отправить код снова';
	@override String get soon_title => 'Скоро';
	@override String soon_message({required Object provider}) => 'Вход через ${provider} скоро будет доступен.';
	@override String get social_login_failed => 'Не удалось войти через соцсеть';
	@override String get social_login_cancelled => 'Вход отменён';
	@override String get linkedin_title => 'Вход через LinkedIn';
	@override String get telegram_title => 'Вход через Telegram';
}

// Path: registration
class _TranslationsRegistrationRu implements TranslationsRegistrationEn {
	_TranslationsRegistrationRu._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Регистрация';
	@override String get influencer => 'Инфлюенсер';
	@override String get ambassador => 'Амбассадор';
	@override String get brand => 'Бренд';
	@override String get your_name => 'Ваше имя';
	@override String get your_surname => 'Ваша фамилия';
	@override String get full_name => 'Полное имя';
	@override String get brand_name => 'Название бренда';
	@override String get upload_profile_picture => 'Загрузить фото профиля';
	@override String get choose_file => 'Выбрать файл';
	@override String get file_format_hint => 'SVG, PNG, JPG или GIF (MAX. 800x400px).';
	@override String get spoken_languages => 'Разговорные языки';
	@override String get date_of_birth => 'Дата рождения';
	@override String get gender => 'Пол';
	@override String get male => 'Мужской';
	@override String get female => 'Женский';
	@override String get contact_details => 'Контактные данные';
	@override String get profile_information => 'Информация о профиле';
	@override String get brand_segment_fit => 'Сегмент бренда';
	@override String get geography => 'География';
	@override String get selected_geography => 'Выбранная география';
	@override String get social_media_accounts => 'Аккаунты в соцсетях';
	@override String get paste_link_here => 'Вставьте ссылку';
	@override String get men => 'Мужчины';
	@override String get women => 'Женщины';
	@override String get age_from => 'Возраст от';
	@override String get age_to => 'Возраст до';
	@override String get years_of_camera_experience => 'Опыт работы с камерой (лет)';
	@override String get write_years_of_experience => 'Введите годы опыта';
	@override String get optional_experience => 'Дополнительный опыт';
	@override String get partners => 'Партнёры';
	@override String get exclusivity_availability => 'Наличие эксклюзивности';
	@override String get write_award_info => 'Введите информацию о наградах';
	@override String get years_of_experience => 'Лет опыта';
	@override String get niches => 'Ниши';
	@override String get selected_niches => 'Выбранные ниши';
	@override String get services => 'Услуги';
	@override String get currency => 'Валюта';
	@override String get min => 'Мин';
	@override String get max => 'Макс';
	@override String get write_hourly_rate => 'Укажите почасовую ставку';
	@override String get projectly_payment_starting_price => 'Начальная цена за проект';
	@override String get write_starting_price => 'Введите начальную цену';
	@override String get payment_types => 'Типы оплаты';
	@override String get categories => 'Категории';
	@override String get selected_categories => 'Выбранные категории';
	@override String get experience_in_referral => 'Есть ли опыт в реферальных/промо кампаниях?';
	@override String get describe_your_experience => 'Опишите ваш опыт';
	@override String get region => 'Регион';
	@override String get city => 'Город';
	@override String get sphere => 'Сфера';
	@override String get available_for_long_term_contract => 'Доступны для долгосрочного контракта?';
	@override String get kpi_based_model => 'Модель на основе KPI';
	@override String get available_for_offline_events => 'Доступны для офлайн мероприятий';
	@override String get pricing_options => 'Варианты ценообразования';
	@override String get do_not_have_account => 'нет аккаунта';
	@override String get no_languages_found => 'Языки не найдены';
	@override String get service_creating_reels_placeholder => 'Создание Reels';
	@override String get niche_business_placeholder => 'Бизнес';
}

// Path: common
class _TranslationsCommonRu implements TranslationsCommonEn {
	_TranslationsCommonRu._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get select => 'Выбрать';
	@override String get confirm => 'Подтвердить';
	@override String get cancel => 'Отмена';
	@override String get apply => 'Применить';
	@override String get delete => 'Удалить';
	@override String get yes => 'Да';
	@override String get no => 'Нет';
	@override String get write_text_here => 'Напишите текст...';
	@override String get please_enter_text => 'Пожалуйста, введите текст';
	@override String get email => 'Email';
	@override String get set_as_main => 'Сделать основным';
	@override String get ok => 'OK';
	@override String get submit => 'Отправить';
	@override String get loading => 'Загрузка...';
	@override String get deadline => 'Срок';
	@override String get menu => 'Меню';
	@override String get messages => 'Сообщения';
	@override String get active_offers => 'Активные предложения';
	@override String get recommended_for_you => 'Рекомендуется для вас';
	@override String get offers_from_brands => 'Предложения от брендов';
	@override String get niche_type => 'Тип ниши';
	@override String get offer_title_placeholder => 'Заголовок предложения';
	@override String get try_again => 'Попробовать снова';
	@override String get back => 'Назад';
	@override String get any => 'Любой';
	@override String get not_specified => 'Не указано';
	@override String get unknown => 'Неизвестно';
	@override String get unknown_date => 'Дата неизвестна';
	@override String get pull_refresh_or_retry => 'Потяните для обновления или попробуйте снова.';
	@override String get pull_refresh_check_soon => 'Потяните для обновления и проверьте позже.';
	@override String get error_occurred => 'Произошла ошибка';
	@override String get open => 'Открыто';
	@override String get date_format_hint => 'ДД.ММ.ГГГГ';
	@override String get continue_label => 'Продолжить';
	@override String get general => 'Общее';
	@override String get requirements_label => 'Требования';
	@override String get details_label => 'Детали';
	@override String get select_country => 'Выбрать страну';
	@override String get select_visibility => 'Выбрать видимость';
	@override String get age_range => 'Возрастной диапазон';
	@override String get public => 'Публичный';
	@override String get private => 'Приватный';
	@override String get duration_1_week => '1 неделя';
	@override String get duration_2_weeks => '2 недели';
	@override String get duration_1_month => '1 месяц';
	@override String get duration_2_months => '2 месяца';
	@override String get duration_3_months => '3 месяца';
	@override String get default_label => 'По умолчанию';
	@override String get set_default => 'По умолчанию';
	@override String get no_contact_details => 'Контактные данные отсутствуют';
}

// Path: profile
class _TranslationsProfileRu implements TranslationsProfileEn {
	_TranslationsProfileRu._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get profile_page => 'Страница профиля';
	@override String get stats => 'Статистика';
	@override String get reviews => 'Отзывы';
	@override String get calendar => 'Календарь';
	@override String get portfolio => 'Портфолио';
	@override String get billing => 'Биллинг';
	@override String get make_profile_top => 'Сделать профиль TOP';
	@override String get app_language => 'Язык приложения';
	@override String get terms_and_conditions => 'Условия использования';
	@override String get log_out => 'Выйти';
	@override String get general_info => 'Общая информация';
	@override String get audience_and_followers => 'Аудитория и подписчики';
	@override String get experience => 'Опыт';
	@override String get awards => 'Награды';
	@override String get pricing_tariffs => 'Ценообразование / Тарифы';
	@override String get payment_type => 'Тип оплаты';
	@override String get delete_account => 'Удалить аккаунт';
	@override String get delete_account_confirm => 'Вы уверены, что хотите удалить аккаунт? Это действие нельзя отменить.';
	@override String age_range({required Object from, required Object to}) => 'Возраст ${from} - ${to}';
	@override String get confirm_delete => 'Подтвердить удаление';
	@override String get total_followers => 'Всего подписчиков';
	@override String get engagement_rate => 'Уровень вовлечённости';
}

// Path: validation
class _TranslationsValidationRu implements TranslationsValidationEn {
	_TranslationsValidationRu._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name_required => 'Пожалуйста, введите имя и фамилию';
	@override String get name_full_required => 'Пожалуйста, введите полное имя и фамилию';
	@override String get name_letters_only => 'Имя должно содержать только буквы';
	@override String get name_too_short => 'Имя слишком короткое';
	@override String get fill_required_fields => 'Заполните обязательные поля';
	@override String get account_already_added => 'Аккаунт уже добавлен';
}

// Path: choose
class _TranslationsChooseRu implements TranslationsChooseEn {
	_TranslationsChooseRu._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get select_niche => 'Выбрать нишу';
	@override String get select_gender => 'Выбрать пол';
	@override String get select_geography => 'Выбрать географию';
	@override String get select_currency => 'Выбрать валюту';
	@override String get select_partners => 'Выбрать партнёров';
	@override String get select_service => 'Выбрать услугу';
	@override String get select_date_of_birth => 'Выбрать дату рождения';
	@override String get select_contact_detail => 'Выбрать контакт';
	@override String get spoken_language => 'Разговорный язык';
	@override String get select_region => 'Выбрать регион';
	@override String get select_city => 'Выбрать город';
	@override String get select_sphere => 'Выбрать сферу';
	@override String get select_payment_type => 'Выбрать тип оплаты';
}

// Path: contact
class _TranslationsContactRu implements TranslationsContactEn {
	_TranslationsContactRu._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get phone => 'Телефон';
	@override String get telegram => 'Telegram';
	@override String get instagram => 'Instagram';
	@override String get telegram_user_name => 'Имя пользователя Telegram';
	@override String get instagram_account => 'Аккаунт Instagram';
	@override String get no_contact_details => 'Контактные данные отсутствуют';
}

// Path: optional_items
class _TranslationsOptionalItemsRu implements TranslationsOptionalItemsEn {
	_TranslationsOptionalItemsRu._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get tv_ad_experience => 'Опыт в ТВ/рекламе';
	@override String get press_mentions => 'Упоминания в прессе';
	@override String get agency_representation => 'Представительство агентства';
	@override String get previous_brand_collaborations => 'Предыдущие коллаборации с брендами';
	@override String get case_study_link => 'Ссылка на кейс или скриншот';
	@override String get conversion_metrics => 'Показатели конверсии (если есть)';
	@override String get willing_to_work_kpi => 'Готов работать по модели KPI';
	@override String get campaign_based_fee => 'Оплата на основе кампании';
	@override String get event_appearance_fee => 'Оплата за участие в мероприятии';
}

// Path: home
class _TranslationsHomeRu implements TranslationsHomeEn {
	_TranslationsHomeRu._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get offers_and_messages => 'Предложения и сообщения';
	@override String get recommendations_for_you => 'Рекомендации для вас';
	@override String get flexible_reward => 'Гибкое';
	@override String get new_recommendation => 'Новая рекомендация под ваш профиль.';
	@override String get error_load => 'Не удалось загрузить данные главной страницы.';
	@override String get empty_recommendations => 'Рекомендации появятся здесь, когда будут готовы подходящие результаты.';
	@override String get pending_approval_text => 'Ваш профиль ещё на проверке. Предложения и рекомендации появятся после одобрения.';
	@override String get pending_approval_banner => 'Ваш профиль ожидает одобрения. Сообщения и уведомления доступны сейчас, инструменты для предложений откроются после модерации.';
}

// Path: brand
class _TranslationsBrandRu implements TranslationsBrandEn {
	_TranslationsBrandRu._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Бренд';
	@override String get offers_and_applications => 'Предложения и заявки';
	@override String get new_applications => 'Новые заявки';
	@override String get ai_matching => 'AI Подбор';
	@override String get top_label => 'TOP';
	@override String get no_active_campaigns_yet => 'Пока нет активных кампаний';
	@override String get collaboration_offers => 'Предложения о сотрудничестве';
	@override String get brandfaces => 'Brandfaces';
	@override String get ambassadors => 'Амбассадоры';
	@override String get influencers => 'Инфлюенсеры';
	@override String get favourites => 'Избранное';
	@override String get analytics => 'Аналитика';
	@override String get influencer_tab => 'Инфлюенсер';
	@override String get ambassadors_tab => 'Амбассадоры';
	@override String get brand_profile => 'Профиль бренда';
	@override String get website => 'Веб-сайт';
	@override String get actives => 'Активные';
	@override String get archived => 'Архив';
	@override String get views => 'Просмотры';
	@override String get applications => 'Заявки';
	@override String get search => 'Поиск';
	@override String get new_offer => 'Новое предложение';
	@override String get sort_by => 'Сортировать по';
	@override String get sort_by_ranking => 'Сортировать по рейтингу';
	@override String get sort_by_newly_joined => 'Сортировать по дате присоединения';
	@override String get sort_by_followers => 'Сортировать по количеству подписчиков';
	@override String get sort_by_experience => 'Сортировать по опыту';
	@override String get sort_by_views => 'Сортировать по просмотрам';
	@override String get sort_by_applications => 'Сортировать по заявкам';
	@override String get filter => 'Фильтр';
	@override String get rank_type => 'Тип ранга';
	@override String get vip_label => 'VIP';
	@override String ambassadors_found({required Object count}) => 'Найдено ${count} амбассадоров';
	@override String get no_ambassadors_found => 'Амбассадоры не найдены';
	@override String followers_count({required Object count}) => '${count} подписчиков';
	@override String years_experience({required Object count}) => '${count} лет опыта';
	@override String get collaboration_offer_details => 'Детали предложения о сотрудничестве';
	@override String get offer_failed_load => 'Не удалось загрузить предложение.';
	@override String get offer_complete => 'Завершить';
}

// Path: offer
class _TranslationsOfferRu implements TranslationsOfferEn {
	_TranslationsOfferRu._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get offer_details => 'Детали предложения';
	@override String get offer_title => 'Заголовок предложения';
	@override String get description => 'Описание';
	@override String get status => 'Статус';
	@override String get requirements => 'Требования';
	@override String get country => 'Страна';
	@override String get city => 'Город';
	@override String get followers_max => 'Подписчиков макс.';
	@override String get followers_min => 'Подписчиков мин.';
	@override String get languages => 'Языки';
	@override String get engagement_rate => 'Уровень вовлечённости';
	@override String get content_type => 'Тип контента';
	@override String get gender => 'Пол';
	@override String get collaboration_details => 'Детали сотрудничества';
	@override String get duration => 'Длительность';
	@override String get visibility => 'Видимость';
	@override String get application_submitted => 'Заявка успешно отправлена.';
	@override String get error_could_not_open => 'Не удалось открыть предложение.';
	@override String get error_no_id => 'ID предложения не указан.';
	@override String get error_retry_message => 'Потяните назад и попробуйте открыть предложение снова.';
	@override String get not_found => 'Предложение не найдено.';
	@override String get no_detail_data => 'Данные для этого предложения недоступны.';
	@override String get apply_title => 'Подать заявку на это предложение';
	@override String get cover_letter_subtitle => 'Добавьте необязательное сопроводительное письмо.';
	@override String get cover_letter_label => 'Сопроводительное письмо';
	@override String get cover_letter_hint => 'Напишите короткое сообщение';
	@override String get submit_application => 'Отправить заявку';
	@override String get continue_without_cover_letter => 'Продолжить без сопроводительного письма';
	@override String get general_info => 'Общая информация';
	@override String get no_category => 'Нет категории';
	@override String get create_title => 'Добавить новое предложение о сотрудничестве';
	@override String get title_hint => 'Напишите название предложения';
	@override String get applied => 'Отправлено';
	@override String get submitting => 'Отправка...';
	@override String get apply_now => 'Подать заявку';
	@override String get no_deadline => 'Без срока';
	@override String get open_deadline => 'Открыто';
	@override String get reward => 'Вознаграждение';
	@override String get no_offers_available => 'Сейчас нет доступных предложений.';
	@override String no_offers_for_niche({required Object niche}) => 'Предложения для ${niche} не найдены.';
	@override String get offers_error_load => 'Не удалось загрузить предложения.';
	@override String get open_collaboration => 'Открытое предложение о сотрудничестве';
	@override String get new_offer_success => 'Новое предложение о сотрудничестве\nуспешно добавлено';
	@override String get page_title => 'Предложения от брендов';
	@override String get all_niches => 'Все ниши';
	@override String get no_recommendations => 'Рекомендаций пока нет.';
	@override String get recommendations_subtitle => 'Здесь появятся подходящие предложения.';
}

// Path: reviews
class _TranslationsReviewsRu implements TranslationsReviewsEn {
	_TranslationsReviewsRu._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get average => 'Среднее';
	@override String get client_reviews => 'Отзывы клиентов';
	@override String get title => 'Отзывы';
	@override String get no_reviews => 'Отзывов пока нет.';
	@override String get no_review_text => 'Текст отзыва отсутствует.';
	@override String get error_load => 'Не удалось загрузить отзывы.';
}

// Path: notifications
class _TranslationsNotificationsRu implements TranslationsNotificationsEn {
	_TranslationsNotificationsRu._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Уведомления';
	@override String get read_all => 'Прочитать все';
	@override String get no_notifications => 'У вас пока нет уведомлений.';
	@override String get error_load => 'Не удалось загрузить уведомления.';
}

// Path: billing
class _TranslationsBillingRu implements TranslationsBillingEn {
	_TranslationsBillingRu._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get plan_tab => 'Тариф';
	@override String get my_cards_tab => 'Мои карты';
	@override String get history_tab => 'История платежей';
	@override String get current_plan => 'Текущий тариф';
	@override String get boost_profile => 'Продвинуть профиль';
	@override String get processing => 'Обработка...';
	@override String get cancel_subscription => 'Отменить подписку';
	@override String get add_new_card => 'Добавить новую карту';
	@override String get issue_date => 'Дата выдачи';
	@override String get amount => 'Сумма';
	@override String get start_date => 'Дата начала';
	@override String get add_payment_card => 'Добавить платёжную карту';
	@override String get set_as_default => 'Сделать основной';
	@override String get save_card => 'Сохранить карту';
	@override String get fill_valid_card_details => 'Заполните данные карты.';
	@override String get last_four_digits => 'Последние четыре цифры';
	@override String get expiry_month => 'Месяц истечения';
	@override String get expiry_year => 'Год истечения';
	@override String get gateway_token => 'Токен шлюза';
	@override String get card_type => 'Тип карты';
	@override String get no_billing_history => 'История платежей пуста.';
	@override String get error_load => 'Не удалось загрузить данные о платежах.';
	@override String get no_active_subscription => 'Нет активной подписки';
	@override String get per_month => '/ месяц';
	@override String get add_payment_card_first => 'Сначала добавьте платёжную карту.';
	@override String get contact_unlock => 'Разблокировка контакта:';
	@override String get profile_offer_boost => 'Продвижение профиля / предложения:';
	@override String get pay_as_you_go => 'Дополнения по оплате (прозрачно)';
	@override String card_ending_in({required Object cardType, required Object lastFour}) => '${cardType} оканчивается на ${lastFour}';
	@override String card_expiry({required Object month, required Object year}) => 'Истекает ${month}/${year}';
	@override String transaction_label({required Object id}) => 'Транзакция #${id}';
	@override String get delete_card => 'Удалить';
	@override String get default_card => 'По умолчанию';
	@override String get set_default_card => 'Сделать основной';
	@override String get no_plan => 'Нет плана';
	@override String get no_feature_details => 'Сведения о функциях недоступны';
	@override String days({required Object days}) => '${days} дней';
}

// Path: errors
class _TranslationsErrorsRu implements TranslationsErrorsEn {
	_TranslationsErrorsRu._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get network => 'Проблемы с интернетом, проверьте соединение';
	@override String get parsing => 'Ошибка обработки данных';
	@override String get unknown => 'Произошла неизвестная ошибка';
	@override String get session_expired => 'Сессия истекла';
	@override String get redirect_to_login => 'Вы будете перенаправлены на страницу входа.';
	@override late final _TranslationsErrorsServerRu server = _TranslationsErrorsServerRu._(_root);
}

// Path: errors.server
class _TranslationsErrorsServerRu implements TranslationsErrorsServerEn {
	_TranslationsErrorsServerRu._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String defaultMsg({required Object code}) => 'Ошибка сервера (${code})';
	@override String get badRequest => 'Некорректный запрос';
	@override String get unauthorized => 'Сессия истекла, войдите снова';
	@override String get notFound => 'Ресурс не найден';
	@override String get userExists => 'Пользователь с таким email уже есть';
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
			'login.sms_confirmation' => 'SMS подтверждение',
			'login.sms_sent_to' => ({required Object phoneEnd}) => 'На ваш номер телефона **${phoneEnd} отправлен SMS код, пожалуйста введите его',
			'login.send_code_again' => 'Отправить код снова',
			'login.soon_title' => 'Скоро',
			'login.soon_message' => ({required Object provider}) => 'Вход через ${provider} скоро будет доступен.',
			'login.social_login_failed' => 'Не удалось войти через соцсеть',
			'login.social_login_cancelled' => 'Вход отменён',
			'login.linkedin_title' => 'Вход через LinkedIn',
			'login.telegram_title' => 'Вход через Telegram',
			'registration.title' => 'Регистрация',
			'registration.influencer' => 'Инфлюенсер',
			'registration.ambassador' => 'Амбассадор',
			'registration.brand' => 'Бренд',
			'registration.your_name' => 'Ваше имя',
			'registration.your_surname' => 'Ваша фамилия',
			'registration.full_name' => 'Полное имя',
			'registration.brand_name' => 'Название бренда',
			'registration.upload_profile_picture' => 'Загрузить фото профиля',
			'registration.choose_file' => 'Выбрать файл',
			'registration.file_format_hint' => 'SVG, PNG, JPG или GIF (MAX. 800x400px).',
			'registration.spoken_languages' => 'Разговорные языки',
			'registration.date_of_birth' => 'Дата рождения',
			'registration.gender' => 'Пол',
			'registration.male' => 'Мужской',
			'registration.female' => 'Женский',
			'registration.contact_details' => 'Контактные данные',
			'registration.profile_information' => 'Информация о профиле',
			'registration.brand_segment_fit' => 'Сегмент бренда',
			'registration.geography' => 'География',
			'registration.selected_geography' => 'Выбранная география',
			'registration.social_media_accounts' => 'Аккаунты в соцсетях',
			'registration.paste_link_here' => 'Вставьте ссылку',
			'registration.men' => 'Мужчины',
			'registration.women' => 'Женщины',
			'registration.age_from' => 'Возраст от',
			'registration.age_to' => 'Возраст до',
			'registration.years_of_camera_experience' => 'Опыт работы с камерой (лет)',
			'registration.write_years_of_experience' => 'Введите годы опыта',
			'registration.optional_experience' => 'Дополнительный опыт',
			'registration.partners' => 'Партнёры',
			'registration.exclusivity_availability' => 'Наличие эксклюзивности',
			'registration.write_award_info' => 'Введите информацию о наградах',
			'registration.years_of_experience' => 'Лет опыта',
			'registration.niches' => 'Ниши',
			'registration.selected_niches' => 'Выбранные ниши',
			'registration.services' => 'Услуги',
			'registration.currency' => 'Валюта',
			'registration.min' => 'Мин',
			'registration.max' => 'Макс',
			'registration.write_hourly_rate' => 'Укажите почасовую ставку',
			'registration.projectly_payment_starting_price' => 'Начальная цена за проект',
			'registration.write_starting_price' => 'Введите начальную цену',
			'registration.payment_types' => 'Типы оплаты',
			'registration.categories' => 'Категории',
			'registration.selected_categories' => 'Выбранные категории',
			'registration.experience_in_referral' => 'Есть ли опыт в реферальных/промо кампаниях?',
			'registration.describe_your_experience' => 'Опишите ваш опыт',
			'registration.region' => 'Регион',
			'registration.city' => 'Город',
			'registration.sphere' => 'Сфера',
			'registration.available_for_long_term_contract' => 'Доступны для долгосрочного контракта?',
			'registration.kpi_based_model' => 'Модель на основе KPI',
			'registration.available_for_offline_events' => 'Доступны для офлайн мероприятий',
			'registration.pricing_options' => 'Варианты ценообразования',
			'registration.do_not_have_account' => 'нет аккаунта',
			'registration.no_languages_found' => 'Языки не найдены',
			'registration.service_creating_reels_placeholder' => 'Создание Reels',
			'registration.niche_business_placeholder' => 'Бизнес',
			'common.select' => 'Выбрать',
			'common.confirm' => 'Подтвердить',
			'common.cancel' => 'Отмена',
			'common.apply' => 'Применить',
			'common.delete' => 'Удалить',
			'common.yes' => 'Да',
			'common.no' => 'Нет',
			'common.write_text_here' => 'Напишите текст...',
			'common.please_enter_text' => 'Пожалуйста, введите текст',
			'common.email' => 'Email',
			'common.set_as_main' => 'Сделать основным',
			'common.ok' => 'OK',
			'common.submit' => 'Отправить',
			'common.loading' => 'Загрузка...',
			'common.deadline' => 'Срок',
			'common.menu' => 'Меню',
			'common.messages' => 'Сообщения',
			'common.active_offers' => 'Активные предложения',
			'common.recommended_for_you' => 'Рекомендуется для вас',
			'common.offers_from_brands' => 'Предложения от брендов',
			'common.niche_type' => 'Тип ниши',
			'common.offer_title_placeholder' => 'Заголовок предложения',
			'common.try_again' => 'Попробовать снова',
			'common.back' => 'Назад',
			'common.any' => 'Любой',
			'common.not_specified' => 'Не указано',
			'common.unknown' => 'Неизвестно',
			'common.unknown_date' => 'Дата неизвестна',
			'common.pull_refresh_or_retry' => 'Потяните для обновления или попробуйте снова.',
			'common.pull_refresh_check_soon' => 'Потяните для обновления и проверьте позже.',
			'common.error_occurred' => 'Произошла ошибка',
			'common.open' => 'Открыто',
			'common.date_format_hint' => 'ДД.ММ.ГГГГ',
			'common.continue_label' => 'Продолжить',
			'common.general' => 'Общее',
			'common.requirements_label' => 'Требования',
			'common.details_label' => 'Детали',
			'common.select_country' => 'Выбрать страну',
			'common.select_visibility' => 'Выбрать видимость',
			'common.age_range' => 'Возрастной диапазон',
			'common.public' => 'Публичный',
			'common.private' => 'Приватный',
			'common.duration_1_week' => '1 неделя',
			'common.duration_2_weeks' => '2 недели',
			'common.duration_1_month' => '1 месяц',
			'common.duration_2_months' => '2 месяца',
			'common.duration_3_months' => '3 месяца',
			'common.default_label' => 'По умолчанию',
			'common.set_default' => 'По умолчанию',
			'common.no_contact_details' => 'Контактные данные отсутствуют',
			'profile.profile_page' => 'Страница профиля',
			'profile.stats' => 'Статистика',
			'profile.reviews' => 'Отзывы',
			'profile.calendar' => 'Календарь',
			'profile.portfolio' => 'Портфолио',
			'profile.billing' => 'Биллинг',
			'profile.make_profile_top' => 'Сделать профиль TOP',
			'profile.app_language' => 'Язык приложения',
			'profile.terms_and_conditions' => 'Условия использования',
			'profile.log_out' => 'Выйти',
			'profile.general_info' => 'Общая информация',
			'profile.audience_and_followers' => 'Аудитория и подписчики',
			'profile.experience' => 'Опыт',
			'profile.awards' => 'Награды',
			'profile.pricing_tariffs' => 'Ценообразование / Тарифы',
			'profile.payment_type' => 'Тип оплаты',
			'profile.delete_account' => 'Удалить аккаунт',
			'profile.delete_account_confirm' => 'Вы уверены, что хотите удалить аккаунт? Это действие нельзя отменить.',
			'profile.age_range' => ({required Object from, required Object to}) => 'Возраст ${from} - ${to}',
			'profile.confirm_delete' => 'Подтвердить удаление',
			'profile.total_followers' => 'Всего подписчиков',
			'profile.engagement_rate' => 'Уровень вовлечённости',
			'validation.name_required' => 'Пожалуйста, введите имя и фамилию',
			'validation.name_full_required' => 'Пожалуйста, введите полное имя и фамилию',
			'validation.name_letters_only' => 'Имя должно содержать только буквы',
			'validation.name_too_short' => 'Имя слишком короткое',
			'validation.fill_required_fields' => 'Заполните обязательные поля',
			'validation.account_already_added' => 'Аккаунт уже добавлен',
			'choose.select_niche' => 'Выбрать нишу',
			'choose.select_gender' => 'Выбрать пол',
			'choose.select_geography' => 'Выбрать географию',
			'choose.select_currency' => 'Выбрать валюту',
			'choose.select_partners' => 'Выбрать партнёров',
			'choose.select_service' => 'Выбрать услугу',
			'choose.select_date_of_birth' => 'Выбрать дату рождения',
			'choose.select_contact_detail' => 'Выбрать контакт',
			'choose.spoken_language' => 'Разговорный язык',
			'choose.select_region' => 'Выбрать регион',
			'choose.select_city' => 'Выбрать город',
			'choose.select_sphere' => 'Выбрать сферу',
			'choose.select_payment_type' => 'Выбрать тип оплаты',
			'contact.phone' => 'Телефон',
			'contact.telegram' => 'Telegram',
			'contact.instagram' => 'Instagram',
			'contact.telegram_user_name' => 'Имя пользователя Telegram',
			'contact.instagram_account' => 'Аккаунт Instagram',
			'contact.no_contact_details' => 'Контактные данные отсутствуют',
			'optional_items.tv_ad_experience' => 'Опыт в ТВ/рекламе',
			'optional_items.press_mentions' => 'Упоминания в прессе',
			'optional_items.agency_representation' => 'Представительство агентства',
			'optional_items.previous_brand_collaborations' => 'Предыдущие коллаборации с брендами',
			'optional_items.case_study_link' => 'Ссылка на кейс или скриншот',
			'optional_items.conversion_metrics' => 'Показатели конверсии (если есть)',
			'optional_items.willing_to_work_kpi' => 'Готов работать по модели KPI',
			'optional_items.campaign_based_fee' => 'Оплата на основе кампании',
			'optional_items.event_appearance_fee' => 'Оплата за участие в мероприятии',
			'home.offers_and_messages' => 'Предложения и сообщения',
			'home.recommendations_for_you' => 'Рекомендации для вас',
			'home.flexible_reward' => 'Гибкое',
			'home.new_recommendation' => 'Новая рекомендация под ваш профиль.',
			'home.error_load' => 'Не удалось загрузить данные главной страницы.',
			'home.empty_recommendations' => 'Рекомендации появятся здесь, когда будут готовы подходящие результаты.',
			'home.pending_approval_text' => 'Ваш профиль ещё на проверке. Предложения и рекомендации появятся после одобрения.',
			'home.pending_approval_banner' => 'Ваш профиль ожидает одобрения. Сообщения и уведомления доступны сейчас, инструменты для предложений откроются после модерации.',
			'brand.title' => 'Бренд',
			'brand.offers_and_applications' => 'Предложения и заявки',
			'brand.new_applications' => 'Новые заявки',
			'brand.ai_matching' => 'AI Подбор',
			'brand.top_label' => 'TOP',
			'brand.no_active_campaigns_yet' => 'Пока нет активных кампаний',
			'brand.collaboration_offers' => 'Предложения о сотрудничестве',
			'brand.brandfaces' => 'Brandfaces',
			'brand.ambassadors' => 'Амбассадоры',
			'brand.influencers' => 'Инфлюенсеры',
			'brand.favourites' => 'Избранное',
			'brand.analytics' => 'Аналитика',
			'brand.influencer_tab' => 'Инфлюенсер',
			'brand.ambassadors_tab' => 'Амбассадоры',
			'brand.brand_profile' => 'Профиль бренда',
			'brand.website' => 'Веб-сайт',
			'brand.actives' => 'Активные',
			'brand.archived' => 'Архив',
			'brand.views' => 'Просмотры',
			'brand.applications' => 'Заявки',
			'brand.search' => 'Поиск',
			'brand.new_offer' => 'Новое предложение',
			'brand.sort_by' => 'Сортировать по',
			'brand.sort_by_ranking' => 'Сортировать по рейтингу',
			'brand.sort_by_newly_joined' => 'Сортировать по дате присоединения',
			'brand.sort_by_followers' => 'Сортировать по количеству подписчиков',
			'brand.sort_by_experience' => 'Сортировать по опыту',
			'brand.sort_by_views' => 'Сортировать по просмотрам',
			'brand.sort_by_applications' => 'Сортировать по заявкам',
			'brand.filter' => 'Фильтр',
			'brand.rank_type' => 'Тип ранга',
			'brand.vip_label' => 'VIP',
			'brand.ambassadors_found' => ({required Object count}) => 'Найдено ${count} амбассадоров',
			'brand.no_ambassadors_found' => 'Амбассадоры не найдены',
			'brand.followers_count' => ({required Object count}) => '${count} подписчиков',
			'brand.years_experience' => ({required Object count}) => '${count} лет опыта',
			'brand.collaboration_offer_details' => 'Детали предложения о сотрудничестве',
			'brand.offer_failed_load' => 'Не удалось загрузить предложение.',
			'brand.offer_complete' => 'Завершить',
			'offer.offer_details' => 'Детали предложения',
			'offer.offer_title' => 'Заголовок предложения',
			'offer.description' => 'Описание',
			'offer.status' => 'Статус',
			'offer.requirements' => 'Требования',
			'offer.country' => 'Страна',
			'offer.city' => 'Город',
			'offer.followers_max' => 'Подписчиков макс.',
			'offer.followers_min' => 'Подписчиков мин.',
			'offer.languages' => 'Языки',
			'offer.engagement_rate' => 'Уровень вовлечённости',
			'offer.content_type' => 'Тип контента',
			'offer.gender' => 'Пол',
			'offer.collaboration_details' => 'Детали сотрудничества',
			'offer.duration' => 'Длительность',
			'offer.visibility' => 'Видимость',
			'offer.application_submitted' => 'Заявка успешно отправлена.',
			'offer.error_could_not_open' => 'Не удалось открыть предложение.',
			'offer.error_no_id' => 'ID предложения не указан.',
			'offer.error_retry_message' => 'Потяните назад и попробуйте открыть предложение снова.',
			'offer.not_found' => 'Предложение не найдено.',
			'offer.no_detail_data' => 'Данные для этого предложения недоступны.',
			'offer.apply_title' => 'Подать заявку на это предложение',
			'offer.cover_letter_subtitle' => 'Добавьте необязательное сопроводительное письмо.',
			'offer.cover_letter_label' => 'Сопроводительное письмо',
			'offer.cover_letter_hint' => 'Напишите короткое сообщение',
			'offer.submit_application' => 'Отправить заявку',
			'offer.continue_without_cover_letter' => 'Продолжить без сопроводительного письма',
			'offer.general_info' => 'Общая информация',
			'offer.no_category' => 'Нет категории',
			'offer.create_title' => 'Добавить новое предложение о сотрудничестве',
			'offer.title_hint' => 'Напишите название предложения',
			'offer.applied' => 'Отправлено',
			'offer.submitting' => 'Отправка...',
			'offer.apply_now' => 'Подать заявку',
			'offer.no_deadline' => 'Без срока',
			'offer.open_deadline' => 'Открыто',
			'offer.reward' => 'Вознаграждение',
			'offer.no_offers_available' => 'Сейчас нет доступных предложений.',
			'offer.no_offers_for_niche' => ({required Object niche}) => 'Предложения для ${niche} не найдены.',
			'offer.offers_error_load' => 'Не удалось загрузить предложения.',
			'offer.open_collaboration' => 'Открытое предложение о сотрудничестве',
			'offer.new_offer_success' => 'Новое предложение о сотрудничестве\nуспешно добавлено',
			'offer.page_title' => 'Предложения от брендов',
			'offer.all_niches' => 'Все ниши',
			'offer.no_recommendations' => 'Рекомендаций пока нет.',
			'offer.recommendations_subtitle' => 'Здесь появятся подходящие предложения.',
			'reviews.average' => 'Среднее',
			'reviews.client_reviews' => 'Отзывы клиентов',
			'reviews.title' => 'Отзывы',
			'reviews.no_reviews' => 'Отзывов пока нет.',
			'reviews.no_review_text' => 'Текст отзыва отсутствует.',
			'reviews.error_load' => 'Не удалось загрузить отзывы.',
			'notifications.title' => 'Уведомления',
			'notifications.read_all' => 'Прочитать все',
			'notifications.no_notifications' => 'У вас пока нет уведомлений.',
			'notifications.error_load' => 'Не удалось загрузить уведомления.',
			'billing.plan_tab' => 'Тариф',
			'billing.my_cards_tab' => 'Мои карты',
			'billing.history_tab' => 'История платежей',
			'billing.current_plan' => 'Текущий тариф',
			'billing.boost_profile' => 'Продвинуть профиль',
			'billing.processing' => 'Обработка...',
			'billing.cancel_subscription' => 'Отменить подписку',
			'billing.add_new_card' => 'Добавить новую карту',
			'billing.issue_date' => 'Дата выдачи',
			'billing.amount' => 'Сумма',
			'billing.start_date' => 'Дата начала',
			'billing.add_payment_card' => 'Добавить платёжную карту',
			'billing.set_as_default' => 'Сделать основной',
			'billing.save_card' => 'Сохранить карту',
			'billing.fill_valid_card_details' => 'Заполните данные карты.',
			'billing.last_four_digits' => 'Последние четыре цифры',
			'billing.expiry_month' => 'Месяц истечения',
			'billing.expiry_year' => 'Год истечения',
			'billing.gateway_token' => 'Токен шлюза',
			'billing.card_type' => 'Тип карты',
			'billing.no_billing_history' => 'История платежей пуста.',
			'billing.error_load' => 'Не удалось загрузить данные о платежах.',
			'billing.no_active_subscription' => 'Нет активной подписки',
			'billing.per_month' => '/ месяц',
			'billing.add_payment_card_first' => 'Сначала добавьте платёжную карту.',
			'billing.contact_unlock' => 'Разблокировка контакта:',
			'billing.profile_offer_boost' => 'Продвижение профиля / предложения:',
			'billing.pay_as_you_go' => 'Дополнения по оплате (прозрачно)',
			'billing.card_ending_in' => ({required Object cardType, required Object lastFour}) => '${cardType} оканчивается на ${lastFour}',
			'billing.card_expiry' => ({required Object month, required Object year}) => 'Истекает ${month}/${year}',
			'billing.transaction_label' => ({required Object id}) => 'Транзакция #${id}',
			'billing.delete_card' => 'Удалить',
			'billing.default_card' => 'По умолчанию',
			'billing.set_default_card' => 'Сделать основной',
			'billing.no_plan' => 'Нет плана',
			'billing.no_feature_details' => 'Сведения о функциях недоступны',
			'billing.days' => ({required Object days}) => '${days} дней',
			'errors.network' => 'Проблемы с интернетом, проверьте соединение',
			'errors.parsing' => 'Ошибка обработки данных',
			'errors.unknown' => 'Произошла неизвестная ошибка',
			'errors.session_expired' => 'Сессия истекла',
			'errors.redirect_to_login' => 'Вы будете перенаправлены на страницу входа.',
			'errors.server.defaultMsg' => ({required Object code}) => 'Ошибка сервера (${code})',
			'errors.server.badRequest' => 'Некорректный запрос',
			'errors.server.unauthorized' => 'Сессия истекла, войдите снова',
			'errors.server.notFound' => 'Ресурс не найден',
			'errors.server.userExists' => 'Пользователь с таким email уже есть',
			_ => null,
		};
	}
}
