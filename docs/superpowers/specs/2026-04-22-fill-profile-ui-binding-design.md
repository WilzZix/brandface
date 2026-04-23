# Fill Profile Page — UI + API Binding

**Date:** 2026-04-22  
**Branch:** TASK-23-fill-profile-page-ui-pixel-perfect-and-in-one-ui-code  
**Approach:** Minimal patch — fix existing architecture without restructuring

---

## Problem Summary

The `FillProfileInformationPage` multi-step form has 6 issues preventing correct UI+API binding:

1. `GeneralInfoPageView` does not pre-fill fields from `initialParam` (edit mode broken)
2. `AmbassadorExperiencePageView` has empty `onChanged` — data never reaches parent
3. `BrandfaceCameraExperiencePageView` has `final _param` that never mutates — no data sent
4. `ExperiencePageView` awards section is TODO — no list management
5. `MyPricingTariffsPageView` currency selection not wired to `campaignFeeCurrency`
6. "Save and continue later" button is empty `onTap: () {}`

---

## Changes Per File

### 1. `choose_date_of_birthday.dart`
- Add `initialValue` (`DateTime?`) parameter
- In `initState`: if `initialValue != null`, set `_selectedDate` and format `_selectedLang`

### 2. `choose_gender.dart`
- Add `initialValue` (`String?`) parameter  
- In `initState`: if `initialValue != null`, match against langItems and set `_selectedLang` and `_selectedLangId`

### 3. `choose_contact_detail.dart`
- Add `initialValue` (`List<Contact>?`) parameter
- In `initState`: populate `contactItems` from `initialValue`

### 4. `general_info_page_view.dart`
- In `initState`: set `_fillInfluencerProfileParam = widget.initialParam ?? FillInfluencerProfileParam()`
- Set `_fullNameController.text = widget.initialParam?.displayName ?? ''`
- Pass `initialValue` to `ChooseDateOfBirthday`, `ChooseGender`, `ChooseContactDetail`

### 5. `ambassador_experience_page_view.dart`
- Add listener to `_promoExperienceController` → parse int → `_param.yearsOfExperience`
- Fix `_updateData()` to include `yearsOfExperience`
- Wire `YesNoWidget(onItemTaped:)` → `_param.hasAdExperience`

### 6. `brandface_camera_experience_page_view.dart`
- Change `final _param` → `FillInfluencerProfileParam _param`
- Add `onChanged` to `ChooseOptionWidget` for `hasAdExperience`, `pressMentions`, `agencyRepresentation`
- Add listener to `_yearsController` → `yearsOfExperience`
- Wire `YesNoWidget` → `exclusivityAvailable`

### 7. `choose_option_widget` (in `ambassador_experience_page_view.dart`)
- Add `onChanged` (`ValueChanged<bool>?`) callback parameter

### 8. `my_pricing_tariffs_page_view.dart`
- `ChooseCurrency` `onItemSelected` → set `campaignFeeCurrency = p1.name` in `_param`

### 9. `fill_profile_information_page.dart`
- "Save and continue later" `onTap` → `context.go(HomePage.tag)`

---

## Out of Scope

- Awards API field does not exist in `FillInfluencerProfileParam` — UI list management only (no API send)
- No draft/local storage for "save and continue later" — API has no draft endpoint
- No validation enforcement before page advance
- No new BLoC/Cubit — existing `onChanged` pattern kept
