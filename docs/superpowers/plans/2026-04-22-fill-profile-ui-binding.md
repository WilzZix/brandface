# Fill Profile UI + API Binding Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Fix all broken data-binding in the multi-step Fill Profile form so edit mode pre-fills correctly, all page views send data to parent, and "Save and continue later" navigates home.

**Architecture:** Minimal patch for most fixes. Awards require a new thin layer: `AwardCubit` + `CreateAwardUseCase` + `DeleteAwardUseCase` + 2 data source methods — same pattern as `AudienceCubit`. Awards endpoint is separate from fill-profile (`POST /api/profiles/v1/my/awards/`, `DELETE /api/profiles/v1/my/awards/{id}/`). Three picker widgets also receive `initialValue` parameters for edit-mode pre-fill. `ChooseOptionWidget` gets an `onChanged` callback.

**Tech Stack:** Flutter, BLoC/Cubit, go_router, freezed

---

## Files Modified

| File | Change |
|------|--------|
| `lib/presentation/registration/ui/components/choose_date_of_birthday.dart` | Add `initialValue` param |
| `lib/presentation/registration/ui/components/choose_gender.dart` | Add `initialValue` param |
| `lib/presentation/registration/ui/components/choose_contact_detail.dart` | Add `initialValue` param |
| `lib/presentation/registration/ui/components/general_info_page_view.dart` | Pre-fill all fields from `initialParam` |
| `lib/presentation/registration/ui/components/ambassador_experience_page_view.dart` | Wire `yearsOfExperience`, `hasAdExperience`; add `onChanged` to `ChooseOptionWidget` |
| `lib/presentation/registration/ui/components/brandface_camera_experience_page_view.dart` | Fix `final _param`, wire all callbacks |
| `lib/presentation/registration/ui/components/my_pricing_tariffs_page_view.dart` | Wire currency → `campaignFeeCurrency` |
| `lib/presentation/registration/ui/fill_profile_information_page.dart` | Wire "Save and continue later" + BlocProvider for AwardCubit |
| `lib/core/constants/api_routes.dart` | Add `myAwards`, `deleteAward(id)` routes |
| `lib/data/data_source/network_data_source/profile/profile_data_source.dart` | Add `createAward`, `deleteAward` methods |
| `lib/domain/repository/profile_repository.dart` | Add `createAward`, `deleteAward` to interface |
| `lib/data/repositories/profile_repository_impl.dart` | Implement `createAward`, `deleteAward` |
| `lib/core/di/app_di.dart` | Register `AwardCubit`, `CreateAwardUseCase`, `DeleteAwardUseCase` |
| **Create:** `lib/domain/entities/profile/award_entity.dart` | `AwardEntity {int id, String title}` |
| **Create:** `lib/domain/usecase/profile/create_award_use_case.dart` | Calls `repository.createAward(title)` |
| **Create:** `lib/domain/usecase/profile/delete_award_use_case.dart` | Calls `repository.deleteAward(id)` |
| **Create:** `lib/presentation/registration/bloc/award/award_cubit.dart` | Manages award list via API |
| **Create:** `lib/presentation/registration/bloc/award/award_state.dart` | Freezed state |

---

### Task 1: Add `initialValue` to `ChooseDateOfBirthday`

**Files:**
- Modify: `lib/presentation/registration/ui/components/choose_date_of_birthday.dart`

- [ ] **Step 1: Add `initialValue` parameter and pre-fill in `initState`**

Replace the class definition and `initState`:

```dart
class ChooseDateOfBirthday extends StatefulWidget {
  const ChooseDateOfBirthday({
    super.key,
    required this.title,
    required this.label,
    required this.onItemSelected,
    required this.iconPath,
    this.initialValue,          // ADD THIS
  });

  final String title;
  final String label;
  final String iconPath;
  final DateTime? initialValue; // ADD THIS
  final Function(DateTime) onItemSelected;

  @override
  State<ChooseDateOfBirthday> createState() => _ChooseDateOfBirthdayState();
}

class _ChooseDateOfBirthdayState extends State<ChooseDateOfBirthday> {
  String? _selectedLang;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) {
      _selectedDate = widget.initialValue;
      _selectedLang = DateFormat('dd.MM.yyyy').format(widget.initialValue!);
    } else {
      _selectedLang = widget.title;
    }
  }
  // ... rest unchanged
}
```

- [ ] **Step 2: Verify it compiles**

```bash
cd /Users/macbookpro/StudioProjects/brandface && flutter analyze lib/presentation/registration/ui/components/choose_date_of_birthday.dart
```
Expected: no errors

- [ ] **Step 3: Commit**

```bash
git add lib/presentation/registration/ui/components/choose_date_of_birthday.dart
git commit -m "feat: add initialValue to ChooseDateOfBirthday"
```

---

### Task 2: Add `initialValue` to `ChooseGender`

**Files:**
- Modify: `lib/presentation/registration/ui/components/choose_gender.dart`

- [ ] **Step 1: Add `initialValue` parameter and pre-fill in `initState`**

The API returns `"male"` or `"female"`. Map these to the display item:

```dart
class ChooseGender extends StatefulWidget {
  const ChooseGender({
    super.key,
    required this.title,
    required this.label,
    required this.onItemSelected,
    this.initialValue,          // ADD THIS
  });

  final String title;
  final String label;
  final String? initialValue;   // ADD THIS — "male" | "female" from API
  final Function(String) onItemSelected;

  @override
  State<ChooseGender> createState() => _ChooseGenderState();
}

class _ChooseGenderState extends State<ChooseGender> {
  String? _selectedLang;
  int _selectedLangId = 0;

  List<LangItemModel> get langItems => [
    LangItemModel(name: t.registration.male, id: 0),
    LangItemModel(name: t.registration.female, id: 1),
  ];

  @override
  void initState() {
    super.initState();
    if (widget.initialValue == 'male') {
      _selectedLang = t.registration.male;
      _selectedLangId = 0;
    } else if (widget.initialValue == 'female') {
      _selectedLang = t.registration.female;
      _selectedLangId = 1;
    } else {
      _selectedLang = widget.title;
    }
  }
  // ... rest unchanged
}
```

- [ ] **Step 2: Verify it compiles**

```bash
cd /Users/macbookpro/StudioProjects/brandface && flutter analyze lib/presentation/registration/ui/components/choose_gender.dart
```
Expected: no errors

- [ ] **Step 3: Commit**

```bash
git add lib/presentation/registration/ui/components/choose_gender.dart
git commit -m "feat: add initialValue to ChooseGender"
```

---

### Task 3: Add `initialValue` to `ChooseContactDetail`

**Files:**
- Modify: `lib/presentation/registration/ui/components/choose_contact_detail.dart`

- [ ] **Step 1: Add `initialValue` parameter and pre-fill `contactItems` in `initState`**

```dart
class ChooseContactDetail extends StatefulWidget {
  const ChooseContactDetail({
    super.key,
    required this.title,
    required this.label,
    required this.onItemSelected,
    this.initialValue,              // ADD THIS
  });

  final String title;
  final String label;
  final List<Contact>? initialValue; // ADD THIS
  final Function(List<Contact>) onItemSelected;

  @override
  State<ChooseContactDetail> createState() => _ChooseContactDetailState();
}

class _ChooseContactDetailState extends State<ChooseContactDetail> {
  String? _selectedLang;
  int _selectedLangId = 0;
  InputFieldType _inputFieldType = InputFieldType.phone;
  final TextEditingController _controller = TextEditingController();
  List<Contact> contactItems = [];

  @override
  void initState() {
    super.initState();
    _selectedLang = widget.title;
    if (widget.initialValue != null) {
      contactItems = List.from(widget.initialValue!); // ADD THIS
    }
  }
  // ... rest unchanged
}
```

- [ ] **Step 2: Verify it compiles**

```bash
cd /Users/macbookpro/StudioProjects/brandface && flutter analyze lib/presentation/registration/ui/components/choose_contact_detail.dart
```
Expected: no errors

- [ ] **Step 3: Commit**

```bash
git add lib/presentation/registration/ui/components/choose_contact_detail.dart
git commit -m "feat: add initialValue to ChooseContactDetail"
```

---

### Task 4: Pre-fill `GeneralInfoPageView` from `initialParam`

**Files:**
- Modify: `lib/presentation/registration/ui/components/general_info_page_view.dart`

- [ ] **Step 1: Initialize `_fillInfluencerProfileParam` from `initialParam` in `initState`**

Change `initState`:

```dart
@override
void initState() {
  super.initState();
  _fillInfluencerProfileParam = widget.initialParam ?? FillInfluencerProfileParam();
  _profileInfoController.text = widget.initialParam?.bio ?? '';
  _fullNameController.text = widget.initialParam?.displayName ?? '';
}
```

- [ ] **Step 2: Pass `initialValue` to `ChooseDateOfBirthday`, `ChooseGender`, `ChooseContactDetail`**

In the `build` method, update these three widgets:

```dart
ChooseSpokenLanguage(
  initialValue: widget.initialParam?.languageIds, // already correct
  title: t.common.select,
  label: t.registration.spoken_languages,
  onItemSelected: (List<int> ids) {
    _fillInfluencerProfileParam = _fillInfluencerProfileParam.copyWith(languageIds: ids);
    widget.onChanged(_fillInfluencerProfileParam);
  },
),
SizedBox(height: 24),
ChooseDateOfBirthday(
  initialValue: widget.initialParam?.birthDate, // ADD THIS
  title: 'DD.MM.YYYY',
  label: t.registration.date_of_birth,
  onItemSelected: (DateTime date) {
    _fillInfluencerProfileParam = _fillInfluencerProfileParam.copyWith(birthDate: date);
    widget.onChanged(_fillInfluencerProfileParam);
  },
  iconPath: AppAssets.icCalendar,
),
SizedBox(height: 24),
ChooseGender(
  initialValue: widget.initialParam?.gender, // ADD THIS
  title: t.common.select,
  label: t.registration.gender,
  onItemSelected: (String p1) {
    _fillInfluencerProfileParam = _fillInfluencerProfileParam.copyWith(gender: p1);
    widget.onChanged(_fillInfluencerProfileParam);
  },
),
SizedBox(height: 24),
ChooseContactDetail(
  initialValue: widget.initialParam?.contacts, // ADD THIS
  title: t.contact.phone,
  label: t.registration.contact_details,
  onItemSelected: (List<Contact> contacts) {
    _fillInfluencerProfileParam = _fillInfluencerProfileParam.copyWith(contacts: contacts);
    widget.onChanged(_fillInfluencerProfileParam);
  },
),
```

- [ ] **Step 3: Verify it compiles**

```bash
cd /Users/macbookpro/StudioProjects/brandface && flutter analyze lib/presentation/registration/ui/components/general_info_page_view.dart
```
Expected: no errors

- [ ] **Step 4: Commit**

```bash
git add lib/presentation/registration/ui/components/general_info_page_view.dart
git commit -m "feat: pre-fill GeneralInfoPageView from initialParam"
```

---

### Task 5: Add `onChanged` to `ChooseOptionWidget` + wire `AmbassadorExperiencePageView`

**Files:**
- Modify: `lib/presentation/registration/ui/components/ambassador_experience_page_view.dart`

- [ ] **Step 1: Add `onChanged` callback to `ChooseOptionWidget`**

```dart
class ChooseOptionWidget extends StatefulWidget {
  const ChooseOptionWidget({
    super.key,
    required this.title,
    this.onChanged,           // ADD THIS
  });

  final String title;
  final ValueChanged<bool>? onChanged; // ADD THIS

  @override
  State<ChooseOptionWidget> createState() => _ChooseOptionWidgetState();
}

class _ChooseOptionWidgetState extends State<ChooseOptionWidget> {
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selected = !_selected;
        });
        widget.onChanged?.call(_selected); // ADD THIS
      },
      child: Row(
        children: [
          Checkbox(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
            side: BorderSide(
              color: _selected ? Color(0xFF497D00) : AppColors.borderColor,
              width: 1.0,
            ),
            activeColor: AppColors.primary,
            value: _selected,
            onChanged: (value) {
              setState(() {
                _selected = value!;
              });
              widget.onChanged?.call(_selected); // ADD THIS
            },
          ),
          Text(widget.title, style: Typographies.labelLarge),
        ],
      ),
    );
  }
}
```

- [ ] **Step 2: Wire `AmbassadorExperiencePageView` — fix `_updateData` and add listeners**

Replace the entire `_AmbassadorExperiencePageViewState`:

```dart
class _AmbassadorExperiencePageViewState
    extends State<AmbassadorExperiencePageView> {
  FillInfluencerProfileParam _param = FillInfluencerProfileParam();
  final TextEditingController _promoExperienceController = TextEditingController();
  final TextEditingController _awardController = TextEditingController();
  final List<LangItemModel> _selectedNichesItems = [];
  final List<String> _awards = [];

  @override
  void initState() {
    super.initState();
    _promoExperienceController.addListener(_onExperienceChanged);
  }

  void _onExperienceChanged() {
    final years = int.tryParse(_promoExperienceController.text);
    if (years != null) {
      _param = _param.copyWith(yearsOfExperience: years);
      widget.onChanged(_param);
    }
  }

  void _updateData() {
    _param = _param.copyWith(
      yearsOfExperience: int.tryParse(_promoExperienceController.text),
      partners: _selectedNichesItems.map((e) => e.id.toString()).toList(),
    );
    widget.onChanged(_param);
  }

  @override
  void dispose() {
    _promoExperienceController.removeListener(_onExperienceChanged);
    _promoExperienceController.dispose();
    _awardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(t.registration.years_of_experience, style: Typographies.titleMedium),
          const SizedBox(height: 8),
          CredInputField(
            controller: _promoExperienceController,
            label: t.registration.describe_your_experience,
            validator: (String? value) {
              if (value == null || value.isEmpty) return t.common.please_enter_text;
              return null;
            },
          ),
          SizedBox(height: 16),
          Text(t.registration.partners, style: Typographies.titleMedium),
          const SizedBox(height: 8),
          ChoosePartners(
            onItemSelected: (LangItemModel p1) {
              if (!_selectedNichesItems.any((e) => e.id == p1.id)) {
                _selectedNichesItems.add(p1);
              }
              _updateData();
            },
          ),
          const SizedBox(height: 24),
          Text(t.registration.experience_in_referral, style: Typographies.titleMedium),
          const SizedBox(height: 8),
          YesNoWidget(
            onItemTaped: (bool value) {
              _param = _param.copyWith(hasAdExperience: value);
              widget.onChanged(_param);
            },
          ),
          const SizedBox(height: 16),
          Text(t.registration.optional_experience, style: Typographies.titleMedium),
          const SizedBox(height: 8),
          ChooseOptionWidget(
            title: t.optional_items.previous_brand_collaborations,
            onChanged: (val) {
              // optional — no direct API field, skip sending
            },
          ),
          const SizedBox(height: 16),
          ChooseOptionWidget(
            title: t.optional_items.case_study_link,
            onChanged: (val) {},
          ),
          const SizedBox(height: 16),
          ChooseOptionWidget(
            title: t.optional_items.conversion_metrics,
            onChanged: (val) {},
          ),
          SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(t.registration.write_award_info, style: Typographies.titleSmall),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: CredInputField(
                      controller: _awardController,
                      label: t.registration.write_award_info,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) return t.common.please_enter_text;
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 8),
                  AppButtons.primary(
                    title: t.common.apply,
                    onTap: () {
                      final text = _awardController.text.trim();
                      if (text.isNotEmpty) {
                        setState(() => _awards.add(text));
                        _awardController.clear();
                      }
                    },
                  ),
                ],
              ),
              if (_awards.isNotEmpty)
                ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _awards.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Text(_awards[index], style: Typographies.bodyMedium)),
                          GestureDetector(
                            onTap: () => setState(() => _awards.removeAt(index)),
                            child: Text(t.common.delete,
                                style: Typographies.labelLarge.copyWith(color: AppColors.red)),
                          ),
                        ],
                      ),
                    );
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }
}
```

Note: `_awards` list is UI-only — no corresponding field in `FillInfluencerProfileParam`.

- [ ] **Step 3: Verify it compiles**

```bash
cd /Users/macbookpro/StudioProjects/brandface && flutter analyze lib/presentation/registration/ui/components/ambassador_experience_page_view.dart
```
Expected: no errors

- [ ] **Step 4: Commit**

```bash
git add lib/presentation/registration/ui/components/ambassador_experience_page_view.dart
git commit -m "feat: wire AmbassadorExperiencePageView callbacks and add onChanged to ChooseOptionWidget"
```

---

### Task 6: Fix `BrandfaceCameraExperiencePageView`

**Files:**
- Modify: `lib/presentation/registration/ui/components/brandface_camera_experience_page_view.dart`

- [ ] **Step 1: Replace the entire state class to fix `final _param` and wire all callbacks**

```dart
class _BrandfaceCameraExperiencePageViewState
    extends State<BrandfaceCameraExperiencePageView>
    with AutomaticKeepAliveClientMixin<BrandfaceCameraExperiencePageView> {
  FillInfluencerProfileParam _param = FillInfluencerProfileParam(); // was final
  final TextEditingController _yearsController = TextEditingController();
  final TextEditingController _awardController = TextEditingController();
  final List<String> _awards = [];

  @override
  void initState() {
    super.initState();
    _yearsController.addListener(_onYearsChanged);
  }

  void _onYearsChanged() {
    final years = int.tryParse(_yearsController.text);
    if (years != null) {
      _param = _param.copyWith(yearsOfExperience: years);
      widget.onChanged(_param);
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _yearsController.removeListener(_onYearsChanged);
    _yearsController.dispose();
    _awardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(t.registration.years_of_camera_experience, style: Typographies.titleMedium),
          const SizedBox(height: 8),
          CredInputField(
            controller: _yearsController,
            label: t.registration.write_years_of_experience,
            validator: (String? value) {
              if (value == null || value.isEmpty) return t.common.please_enter_text;
              return null;
            },
          ),
          const SizedBox(height: 24),
          Text(t.registration.optional_experience, style: Typographies.titleMedium),
          const SizedBox(height: 8),
          ChooseOptionWidget(
            title: t.optional_items.tv_ad_experience,
            onChanged: (val) {
              _param = _param.copyWith(hasAdExperience: val);
              widget.onChanged(_param);
            },
          ),
          ChooseOptionWidget(
            title: t.optional_items.press_mentions,
            onChanged: (val) {
              _param = _param.copyWith(pressMentions: val);
              widget.onChanged(_param);
            },
          ),
          ChooseOptionWidget(
            title: t.optional_items.agency_representation,
            onChanged: (val) {
              _param = _param.copyWith(agencyRepresentation: val);
              widget.onChanged(_param);
            },
          ),
          SizedBox(height: 16),
          Text(t.registration.partners, style: Typographies.titleMedium),
          const SizedBox(height: 8),
          ChoosePartners(
            onItemSelected: (LangItemModel p1) {
              final current = List<String>.from(_param.partners ?? []);
              if (!current.contains(p1.id.toString())) {
                current.add(p1.id.toString());
              }
              _param = _param.copyWith(partners: current);
              widget.onChanged(_param);
            },
          ),
          SizedBox(height: 16),
          Text(t.registration.exclusivity_availability, style: Typographies.bodyMedium),
          const SizedBox(height: 8),
          YesNoWidget(
            onItemTaped: (value) {
              _param = _param.copyWith(
                pricing: (_param.pricing ?? Pricing()).copyWith(
                  exclusivityAvailable: value,
                ),
              );
              widget.onChanged(_param);
            },
          ),
          SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(t.registration.write_award_info, style: Typographies.titleSmall),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: CredInputField(
                      controller: _awardController,
                      label: t.registration.write_award_info,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) return t.common.please_enter_text;
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 8),
                  AppButtons.primary(
                    title: t.common.apply,
                    onTap: () {
                      final text = _awardController.text.trim();
                      if (text.isNotEmpty) {
                        setState(() => _awards.add(text));
                        _awardController.clear();
                      }
                    },
                  ),
                ],
              ),
              if (_awards.isNotEmpty)
                ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _awards.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Text(_awards[index], style: Typographies.bodyMedium)),
                          GestureDetector(
                            onTap: () => setState(() => _awards.removeAt(index)),
                            child: Text(t.common.delete,
                                style: Typographies.labelLarge.copyWith(color: AppColors.red)),
                          ),
                        ],
                      ),
                    );
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }
}
```

- [ ] **Step 2: Add `Pricing` import if missing — check file imports include `fill_influencer_profile_param.dart`**

The file already imports `fill_influencer_profile_param.dart` which defines `Pricing`. No change needed.

- [ ] **Step 3: Verify it compiles**

```bash
cd /Users/macbookpro/StudioProjects/brandface && flutter analyze lib/presentation/registration/ui/components/brandface_camera_experience_page_view.dart
```
Expected: no errors

- [ ] **Step 4: Commit**

```bash
git add lib/presentation/registration/ui/components/brandface_camera_experience_page_view.dart
git commit -m "feat: fix BrandfaceCameraExperiencePageView param mutation and wire all callbacks"
```

---

### Task 7: Wire currency in `MyPricingTariffsPageView`

**Files:**
- Modify: `lib/presentation/registration/ui/components/my_pricing_tariffs_page_view.dart`

- [ ] **Step 1: Wire `ChooseCurrency.onItemSelected` to `campaignFeeCurrency`**

Change the `ChooseCurrency` block:

```dart
ChooseCurrency(
  onItemSelected: (LangItemModel p1) {
    _param = _param.copyWith(
      pricing: Pricing(
        hourlyRateMinUsd: _hourlyRateFrom.text,
        hourlyRateMinUzs: _hourlyRateFrom.text,
        hourlyRateMaxUsd: _hourlyRateTo.text,
        hourlyRateMaxUzs: _hourlyRateTo.text,
        paymentTypes: _selectedPaymentTypes,
        campaignFee: _paymentByProjectController.text,
        campaignFeeCurrency: p1.name, // ADD THIS — "Usd" or "Uzs"
      ),
    );
    widget.onChanged(_param);
  },
),
```

- [ ] **Step 2: Verify it compiles**

```bash
cd /Users/macbookpro/StudioProjects/brandface && flutter analyze lib/presentation/registration/ui/components/my_pricing_tariffs_page_view.dart
```
Expected: no errors

- [ ] **Step 3: Commit**

```bash
git add lib/presentation/registration/ui/components/my_pricing_tariffs_page_view.dart
git commit -m "feat: wire currency selection to campaignFeeCurrency in MyPricingTariffsPageView"
```

---

### Task 8: Wire "Save and continue later"

**Files:**
- Modify: `lib/presentation/registration/ui/fill_profile_information_page.dart`

- [ ] **Step 1: Wire the button `onTap`**

Find the `GestureDetector` with "Save and continue later" text and change `onTap`:

```dart
GestureDetector(
  onTap: () => context.go(HomePage.tag), // was: onTap: () {}
  child: Text(
    'Save and continue later',
    style: Typographies.labelLarge,
  ),
),
```

- [ ] **Step 2: Verify it compiles**

```bash
cd /Users/macbookpro/StudioProjects/brandface && flutter analyze lib/presentation/registration/ui/fill_profile_information_page.dart
```
Expected: no errors

- [ ] **Step 3: Commit**

```bash
git add lib/presentation/registration/ui/fill_profile_information_page.dart
git commit -m "feat: wire Save and continue later to navigate home"
```

---

### Task 9: Awards API Integration

**Files:**
- Create: `lib/domain/entities/profile/award_entity.dart`
- Create: `lib/domain/usecase/profile/create_award_use_case.dart`
- Create: `lib/domain/usecase/profile/delete_award_use_case.dart`
- Create: `lib/presentation/registration/bloc/award/award_cubit.dart`
- Create: `lib/presentation/registration/bloc/award/award_state.dart`
- Modify: `lib/core/constants/api_routes.dart`
- Modify: `lib/data/data_source/network_data_source/profile/profile_data_source.dart`
- Modify: `lib/domain/repository/profile_repository.dart`
- Modify: `lib/data/repositories/profile_repository_impl.dart`
- Modify: `lib/core/di/app_di.dart`
- Modify: `lib/presentation/registration/ui/components/experience_page_view.dart`
- Modify: `lib/presentation/registration/ui/components/ambassador_experience_page_view.dart`
- Modify: `lib/presentation/registration/ui/components/brandface_camera_experience_page_view.dart`
- Modify: `lib/presentation/registration/ui/fill_profile_information_page.dart`

- [ ] **Step 1: Create `AwardEntity`**

```dart
// lib/domain/entities/profile/award_entity.dart
import 'package:equatable/equatable.dart';

class AwardEntity extends Equatable {
  final int id;
  final String title;

  const AwardEntity({required this.id, required this.title});

  @override
  List<Object?> get props => [id, title];
}
```

- [ ] **Step 2: Add API routes**

In `lib/core/constants/api_routes.dart` add:

```dart
static String myAwards = 'profiles/v1/my/awards/';
static String deleteAward(int awardId) => 'profiles/v1/my/awards/$awardId/';
```

- [ ] **Step 3: Add data source methods**

In `lib/data/data_source/network_data_source/profile/profile_data_source.dart`:

Add to abstract class:
```dart
Future<AwardEntity> createAward({required String title});
Future<void> deleteAward({required int awardId});
```

Add import at top:
```dart
import '../../../domain/entities/profile/award_entity.dart';
```

Add to `ProfileDataSourceImpl`:
```dart
@override
Future<AwardEntity> createAward({required String title}) async {
  try {
    final result = await _dioClient.post(
      ApiRoutes.myAwards,
      data: {'title': title},
    );
    final data = result.data['data'] ?? result.data;
    return AwardEntity(id: data['id'], title: data['title']);
  } catch (e) {
    rethrow;
  }
}

@override
Future<void> deleteAward({required int awardId}) async {
  try {
    await _dioClient.delete(ApiRoutes.deleteAward(awardId));
  } catch (e) {
    rethrow;
  }
}
```

Note: Check `_dioClient` — if it doesn't have a `delete` method, use `_dioClient.dio.delete(...)`.

- [ ] **Step 4: Check if DioClient has `delete` method**

```bash
grep -n "Future" /Users/macbookpro/StudioProjects/brandface/lib/core/network/dio_client.dart
```

If no `delete` method exists, add it to `DioClient`:
```dart
Future<Response<dynamic>> delete(String path) async {
  return await _dio.delete('${ApiRoutes.baseUrl}$path');
}
```

- [ ] **Step 5: Add repository interface methods**

In `lib/domain/repository/profile_repository.dart` add to `IProfileRepository`:
```dart
import '../entities/profile/award_entity.dart';

Future<Either<Failure, AwardEntity>> createAward({required String title});
Future<Either<Failure, void>> deleteAward({required int awardId});
```

- [ ] **Step 6: Implement repository methods**

In `lib/data/repositories/profile_repository_impl.dart` add:
```dart
@override
Future<Either<Failure, AwardEntity>> createAward({required String title}) async {
  try {
    final award = await _dataSource.createAward(title: title);
    return Right(award);
  } on DioException catch (e) {
    return Left(ServerFailure(
      e.response?.data?['message'] ?? e.message ?? 'Serverda xatolik yuz berdi',
      statusCode: e.response?.statusCode,
    ));
  } catch (e) {
    return Left(ServerFailure('Tizim xatoligi: ${e.toString()}'));
  }
}

@override
Future<Either<Failure, void>> deleteAward({required int awardId}) async {
  try {
    await _dataSource.deleteAward(awardId: awardId);
    return const Right(null);
  } on DioException catch (e) {
    return Left(ServerFailure(
      e.response?.data?['message'] ?? e.message ?? 'Serverda xatolik yuz berdi',
      statusCode: e.response?.statusCode,
    ));
  } catch (e) {
    return Left(ServerFailure('Tizim xatoligi: ${e.toString()}'));
  }
}
```

Add import at top: `import '../domain/entities/profile/award_entity.dart';`

- [ ] **Step 7: Create use cases**

```dart
// lib/domain/usecase/profile/create_award_use_case.dart
import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/profile/award_entity.dart';
import 'package:brandface/domain/repository/profile_repository.dart';
import 'package:brandface/domain/usecase/login/send_otp_usecase.dart';
import 'package:dart_either/dart_either.dart';

class CreateAwardUseCase implements UseCase<AwardEntity, String> {
  final IProfileRepository repository;

  CreateAwardUseCase({required this.repository});

  @override
  Future<Either<Failure, AwardEntity>> call({required String params}) {
    return repository.createAward(title: params);
  }
}
```

```dart
// lib/domain/usecase/profile/delete_award_use_case.dart
import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/repository/profile_repository.dart';
import 'package:brandface/domain/usecase/login/send_otp_usecase.dart';
import 'package:dart_either/dart_either.dart';

class DeleteAwardUseCase implements UseCase<void, int> {
  final IProfileRepository repository;

  DeleteAwardUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call({required int params}) {
    return repository.deleteAward(awardId: params);
  }
}
```

- [ ] **Step 8: Create `AwardState` and `AwardCubit`**

```dart
// lib/presentation/registration/bloc/award/award_state.dart
part of 'award_cubit.dart';

@freezed
class AwardState with _$AwardState {
  const factory AwardState.initial({@Default([]) List<AwardEntity> awards}) = _Initial;
  const factory AwardState.loading({@Default([]) List<AwardEntity> awards}) = _Loading;
  const factory AwardState.success({required List<AwardEntity> awards}) = _Success;
  const factory AwardState.failure({
    required List<AwardEntity> awards,
    required Failure failure,
  }) = _Failure;
}
```

```dart
// lib/presentation/registration/bloc/award/award_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/profile/award_entity.dart';
import 'package:brandface/domain/usecase/profile/create_award_use_case.dart';
import 'package:brandface/domain/usecase/profile/delete_award_use_case.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'award_state.dart';
part 'award_cubit.freezed.dart';

class AwardCubit extends Cubit<AwardState> {
  final CreateAwardUseCase _createAwardUseCase;
  final DeleteAwardUseCase _deleteAwardUseCase;

  AwardCubit({
    required CreateAwardUseCase createAwardUseCase,
    required DeleteAwardUseCase deleteAwardUseCase,
  })  : _createAwardUseCase = createAwardUseCase,
        _deleteAwardUseCase = deleteAwardUseCase,
        super(const AwardState.initial());

  Future<void> createAward({required String title}) async {
    final currentAwards = state.awards;
    emit(AwardState.loading(awards: currentAwards));
    final result = await _createAwardUseCase.call(params: title);
    result.fold(
      ifLeft: (failure) => emit(AwardState.failure(awards: currentAwards, failure: failure)),
      ifRight: (award) => emit(AwardState.success(awards: [...currentAwards, award])),
    );
  }

  Future<void> deleteAward({required int awardId}) async {
    final currentAwards = state.awards;
    emit(AwardState.loading(awards: currentAwards));
    final result = await _deleteAwardUseCase.call(params: awardId);
    result.fold(
      ifLeft: (failure) => emit(AwardState.failure(awards: currentAwards, failure: failure)),
      ifRight: (_) => emit(AwardState.success(
        awards: currentAwards.where((a) => a.id != awardId).toList(),
      )),
    );
  }
}

extension on AwardState {
  List<AwardEntity> get awards => maybeWhen(
        initial: (awards) => awards,
        loading: (awards) => awards,
        success: (awards) => awards,
        failure: (awards, _) => awards,
        orElse: () => [],
      );
}
```

- [ ] **Step 9: Run build_runner to generate freezed file**

```bash
cd /Users/macbookpro/StudioProjects/brandface && flutter pub run build_runner build --delete-conflicting-outputs
```

Expected: generates `award_cubit.freezed.dart`

- [ ] **Step 10: Register in DI**

In `lib/core/di/app_di.dart`, add imports:
```dart
import '../../domain/usecase/profile/create_award_use_case.dart';
import '../../domain/usecase/profile/delete_award_use_case.dart';
import '../../presentation/registration/bloc/award/award_cubit.dart';
```

Add to `init()` after existing use cases:
```dart
sl.registerLazySingleton(() => CreateAwardUseCase(repository: sl()));
sl.registerLazySingleton(() => DeleteAwardUseCase(repository: sl()));
sl.registerFactory(() => AwardCubit(
  createAwardUseCase: sl(),
  deleteAwardUseCase: sl(),
));
```

- [ ] **Step 11: Add `BlocProvider<AwardCubit>` to experience pages in `FillProfileInformationPage`**

In `lib/presentation/registration/ui/fill_profile_information_page.dart`, update the influencer case's `ExperiencePageView` and ambassador's `AmbassadorExperiencePageView` and brandface's `BrandfaceCameraExperiencePageView` to wrap with `BlocProvider`:

```dart
// For influencer — ExperiencePageView (pageFive)
BlocProvider(
  create: (context) => sl<AwardCubit>(),
  child: ExperiencePageView(
    key: const PageStorageKey<String>('pageFive'),
    onChanged: (p1) {
      _finalParam = _finalParam.copyWith(
        yearsOfExperience: p1.yearsOfExperience,
        partners: p1.partners,
      );
    },
  ),
),

// For ambassador — AmbassadorExperiencePageView (pageFive)
BlocProvider(
  create: (context) => sl<AwardCubit>(),
  child: AmbassadorExperiencePageView(
    key: const PageStorageKey<String>('pageFive'),
    onChanged: (p1) {},
  ),
),

// For brandface — BrandfaceCameraExperiencePageView (pageFive)
BlocProvider(
  create: (context) => sl<AwardCubit>(),
  child: BrandfaceCameraExperiencePageView(
    key: const PageStorageKey<String>('pageFive'),
    onChanged: (p1) {},
  ),
),
```

- [ ] **Step 12: Update awards UI in `ExperiencePageView` to use `AwardCubit`**

In `lib/presentation/registration/ui/components/experience_page_view.dart`, replace the awards section:

```dart
// Remove _awards list and manual management. Replace with BlocConsumer:

Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text(t.registration.write_award_info, style: Typographies.titleSmall),
    SizedBox(height: 8),
    BlocConsumer<AwardCubit, AwardState>(
      listener: (context, state) {
        state.maybeWhen(
          failure: (awards, failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(failure.localized), backgroundColor: AppColors.red),
            );
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        final awards = state.awards;
        final isLoading = state.maybeWhen(loading: (_) => true, orElse: () => false);
        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CredInputField(
                    controller: _awardController,
                    label: t.registration.write_award_info,
                    validator: (v) => null,
                  ),
                ),
                SizedBox(width: 8),
                AppButtons.primary(
                  title: t.common.apply,
                  onTap: isLoading ? null : () {
                    final text = _awardController.text.trim();
                    if (text.isNotEmpty) {
                      context.read<AwardCubit>().createAward(title: text);
                      _awardController.clear();
                    }
                  },
                ),
              ],
            ),
            if (awards.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                itemCount: awards.length,
                itemBuilder: (context, index) {
                  final award = awards[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text(award.title, style: Typographies.bodyMedium)),
                        GestureDetector(
                          onTap: () => context.read<AwardCubit>().deleteAward(awardId: award.id),
                          child: Text(t.common.delete,
                              style: Typographies.labelLarge.copyWith(color: AppColors.red)),
                        ),
                      ],
                    ),
                  );
                },
              ),
          ],
        );
      },
    ),
  ],
),
```

Add imports to `experience_page_view.dart`:
```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../uikit/tokens/colors.dart';
import '../bloc/award/award_cubit.dart';
```

- [ ] **Step 13: Apply same awards BlocConsumer to `AmbassadorExperiencePageView` and `BrandfaceCameraExperiencePageView`**

Replace the `_awards` list and manual award management in both files with the same `BlocConsumer<AwardCubit, AwardState>` pattern shown in Step 12. Add the same imports to both files.

- [ ] **Step 14: Verify full project compiles**

```bash
cd /Users/macbookpro/StudioProjects/brandface && flutter analyze lib/
```
Expected: no errors

- [ ] **Step 15: Commit**

```bash
git add \
  lib/domain/entities/profile/award_entity.dart \
  lib/domain/usecase/profile/create_award_use_case.dart \
  lib/domain/usecase/profile/delete_award_use_case.dart \
  lib/presentation/registration/bloc/award/award_cubit.dart \
  lib/presentation/registration/bloc/award/award_state.dart \
  lib/presentation/registration/bloc/award/award_cubit.freezed.dart \
  lib/core/constants/api_routes.dart \
  lib/data/data_source/network_data_source/profile/profile_data_source.dart \
  lib/domain/repository/profile_repository.dart \
  lib/data/repositories/profile_repository_impl.dart \
  lib/core/di/app_di.dart \
  lib/presentation/registration/ui/components/experience_page_view.dart \
  lib/presentation/registration/ui/components/ambassador_experience_page_view.dart \
  lib/presentation/registration/ui/components/brandface_camera_experience_page_view.dart \
  lib/presentation/registration/ui/fill_profile_information_page.dart
git commit -m "feat: awards API integration — create/delete awards via dedicated endpoint"
```

---

### Task 10: Full project analysis + smoke test

- [ ] **Step 1: Run full project analysis**

```bash
cd /Users/macbookpro/StudioProjects/brandface && flutter analyze lib/
```
Expected: no errors (warnings from existing code are acceptable)

- [ ] **Step 2: Manual smoke test checklist**

Open the app and verify:
1. Register as influencer → Fill Profile → General Info page shows empty form ✓
2. Go to Profile → Profile Information → tap edit (pen icon) → General Info page shows saved name, bio, language, DOB, gender, contacts ✓
3. Proceed to Audience page → age inputs and social media wires to param ✓
4. For ambassador role: Experience page → years input triggers `onChanged` ✓
5. For brandface role: Camera Experience page → years, checkboxes, exclusivity all fire ✓
6. Pricing page → selecting currency updates `campaignFeeCurrency` ✓
7. "Save and continue later" → navigates to home ✓

- [ ] **Step 3: Final commit**

```bash
git add docs/superpowers/
git commit -m "docs: add fill-profile UI binding spec and implementation plan"
```
