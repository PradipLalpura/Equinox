# EQUINOX — Changelog

Concise record of meaningful changes. Phases tracked in `docs/PHASES.md`.
Categories: Added · Changed · Fixed · Improved · Technical.

## [v1.0.1] — 2026-09-28

### Fixed
- UPI app discovery is now live (`queryIntentActivities`): every upi://-capable
  app on the phone appears and is guaranteed launchable. Kills wrong
  package-name guesses for super.money / POP UPI.
- Added BHIM (`in.org.npci.upiapp`) to the payment app list.
- Outgoing `tr` sanitized (alphanumeric, ≤35) and generated when missing —
  reused/malformed refs are a common PSP decline reason. Sent URI stored per
  attempt for forensics (JSON export).
- Release artifacts (signed): `release/Equinox-v1.0.1-release.apk` (75.6 MB),
  `release/Equinox-v1.0.1-arm64.apk` (27.4 MB).

## [v1.0.0] — 2026-09-28 (all 6 phases complete)

### Added
- Phase 6 — Reliability, Backup & Final Polish: pending-review inbox (never
  auto-resolves), CSV export, JSON backup + validated atomic restore, explicit
  DELETE EVERYTHING, location rationale dialog, nav haptics, a11y tooltips,
  release signing (`equinox` key, apksigner-verified), on-emulator integration
  test (§62 flow minus camera leg) passing on real SQLite.
- Release artifacts (signed): `release/Equinox-v1.0.0-release.apk` (75.6 MB),
  `release/Equinox-v1.0.0-arm64.apk` (27.4 MB).

### Fixed
- Seed gate moved to secure-storage flag: DELETE ALL DATA stays deleted.
- DAO/`db.delete` loops rewritten for drift typing; csv/file_picker/share_plus
  migrated to current APIs (CsvEncoder, PlatformFile.readAsBytes,
  SharePlus.instance).

## [Unreleased]

### Added
- `docs/PHASES.md`: 6-phase source of truth (Foundation → Dashboard → QR/UPI →
  Savings/Analytics → Reports → Reliability/Polish) with acceptance + DoD per phase.
- `docs/CHANGELOG.md`: this file.
- Phase 1 — Foundation: Flutter Android scaffold (`com.equinox.app`), M3 theme
  (§39 palette), INR formatting, 5-category + 7-status domain models with §58
  seed, Drift schema (6 tables + §54 indexes), Riverpod providers, reusable
  widgets (PrimaryButton, AmountDisplay, EmptyState, LoadingState, FilterChip,
  TransactionRow, CategorySelector, SavingsProgress, SpendingCard), onboarding +
  5-tab nav shell, Android manifest (camera/location permissions, UPI package
  queries), widget smoke tests (2/2 pass).
- Release artifacts: `release/Equinox-v1.0.0-release.apk` (75.1 MB),
  `release/Equinox-v1.0.0-arm64.apk` (27.3 MB).
- Phase 5 — Monthly Reports: pure `buildReport` (summary, categories, daily,
  W1–W5, top-5 largest/merchants, savings, MoM) derived live — no snapshots,
  no worker; archive + detail screens with daily strip, neutral MoM wording;
  on-device PDF (all §32 sections, bar visuals, generation date) + Export to
  app storage + system Share sheet. Tests: 53/53.
- Phase 4 — Savings & Analytics: reactive savings/goals/target streams,
  AddSaving sheet (amount/goal/desc/date), goal CRUD + atomic contributions +
  pause/complete/delete (history preserved as General), editable monthly
  target, Savings screen (month progress, goals, history), Analytics screen
  (month stepper across year boundaries, summary grid, touch weekly chart,
  category drill-down into History, per-month savings). Tests: 42/42.
- Phase 3 — QR → UPI flow: `UpiPayload` parser (VPA/amount/currency/ref/note/
  merchant code, strict validation), status machine (explicit reconcile only),
  5-app configs, native `PackageManager` installed detection (MethodChannel,
  no discontinued dep), package-targeted launch w/ chooser fallback
  (android_intent_plus), single-shot location w/ graceful null, TxStore
  (seed-once, INITIATED-before-launch, attempts, guarded reconcile),
  Scan/Review/Reconcile UI, resume-triggered reconcile sheet. Tests: 26/26.
- Phase 2 — Dashboard & Spending: §58-calibrated seed (26 txs + 2 savings),
  Tx detail fields (UPI ID, app, location, reference), history search
  (merchant/UPI ID/note/reference/category) + category & date filters
  (Today/Week/Month/Custom range) + day grouping, transaction detail bottom
  sheet (§24), static weekly bar chart (CustomPainter, no new dep), monthly
  report teaser card, DAO query surface (paged/search/category totals) with
  real-SQLite tests. Tests: 16/16 pass.

### Fixed
- Drift DateTime stored as int — DAO moved from raw ISO-string SQL to
  type-safe expression API.
- TxDetailSheet overflow on small screens → scrollable sheet.

### Technical
- Toolchain via scoop (per-user): Flutter 3.47.5, Temurin JDK 17, Android
  cmdline-tools seeded into SDK; `flutter doctor` Android toolchain green.
- drift_flutter replaces EOL sqlite3_flutter_libs; Drift codegen via build_runner.

## [v1.0.0] — TBD (release after Phase 6)

### Added
- (to be filled per phase; final: release APK `Equinox-v1.0.0-release.apk`)
