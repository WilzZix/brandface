# Brand Home Page Redesign

**Date:** 2026-07-23
**Status:** Approved

## Goal

Replace the brand home page body with the new design: a long scrollable page of
analytics and people-discovery blocks. The current page shows only two stat
cards plus a raw AI-match list; the new one carries ten sections.

## Section order

| # | Section | Data source |
|---|---------|-------------|
| 1 | AppBar — avatar, brand name, bell | `ProfileInformationCubit` (unchanged) |
| 2 | Brand Activity Summary — 2×3 stat grid | `BrandAnalyticsEntity` |
| 3 | Offer Performance — offer picker, period picker, PDF button, bar chart, top niches, top regions, 2×2 funnel | `BrandAnalyticsCubit.load(offerId, period)` |
| 4 | AI Matching Insights — 2×2 (score, niche/audience/platform fit) | `BrandAnalyticsEntity` |
| 5 | Top 4 recommended ambassadors | `topRecommendedAmbassadors` |
| 6 | Audience Insights — gender, age group, countries | `BrandAnalyticsEntity` |
| 7 | Most viewed ambassadors + "Browse all" | `mostViewedAmbassadors` |
| 8 | VIP users + "Browse all" | `GET ambassadors?is_vip=true` |
| 9 | TOP users + "Browse all" | `GET ambassadors?is_top=true` |
| 10 | AI Matching — Influencers/Ambassadors toggle + "Browse all" | `GET ambassadors?role=influencer` / `role=ambassador` |

The old "Offers and applications" block and the old AI-match sliver list are
removed — the new design has no place for them. The floating menu FAB and its
overlay stay exactly as they are.

## Decisions

- **Offer Performance controls.** The analytics endpoint takes no offer or
  period argument today. The UI is built in full and the data source gains
  `offer_id` / `period` query params; a backend that ignores them still returns
  a valid payload, so nothing breaks while waiting for support.
- **Download as PDF.** No endpoint exists. The button is rendered per the
  design and shows a "coming soon" snackbar until one is available.
- **VIP / TOP / role lists.** Served by the existing ambassadors endpoint via
  its `is_vip`, `is_top` and `role` filters — no backend change needed. The AI
  Matching toggle at the bottom switches between the two role queries; AI-match
  results carry no role field, so they cannot drive that toggle.
- **`BrandAnalyticsPage` is untouched.** The menu link keeps working. Shared
  presentation moves into `brand/ui/widgets/`; the analytics page keeps its own
  denser layout.

## Structure

`brand_home_page.dart` is already 848 lines. Rather than grow it, sections live
in `lib/presentation/home_page/brand/ui/widgets/`:

- `brand_stat_tile.dart` — the two-column stat card used by sections 2, 3, 4, 6
- `section_header.dart` — title + optional "Browse all" footer button
- `brand_activity_summary.dart`
- `offer_performance_section.dart`
- `ai_insights_section.dart` — AI Matching Insights + Top 4 recommended
- `audience_insights_section.dart`
- `ambassador_row_card.dart` — the design's list row (TOP/VIP badge, rating ·
  followers · experience, category chips)
- `people_list_section.dart` — header + rows + "Browse all", used by 7–10

`brand_home_page.dart` becomes a `CustomScrollView` assembling these.

## Bloc layer

- `BrandAnalyticsCubit` is added to the brand home route's providers and gains
  `load({int? offerId, String? period})`. Its loaded state also carries the
  brand's active offers so the picker has something to show; the picker and the
  period chip re-issue `load` with the new arguments.
- `BrandPeopleListsCubit` (new) loads the VIP, TOP, influencer and ambassador
  lists concurrently and holds each as an independent slot. One failing list
  never blanks the others.
- `AmbassadorEntity` gains `isVip`, parsed from `is_vip`, so the VIP badge in
  the design can render.

## Failure and empty behaviour

Every section renders independently. While a section's data loads it shows a
placeholder; if its request fails or returns nothing, that section is omitted
entirely. The home page never becomes a full-screen spinner or error state.

## i18n

New keys in `analytics` (all three locales): `choose_an_offer`, `choose`,
`download_as_pdf`, `total_applications_received`, `top_3_applicant_niches`,
`top_3_applicant_regions`, `all_applications`, `ai_match_score`,
`most_viewed_ambassadors`, `vip_users`, `top_users`, `browse_all`, `female`,
`male`, `pdf_coming_soon`. `brand.vip_label` and `brand.top_label` already
exist and are reused.
