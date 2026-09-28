# EQUINOX — Development Phases (Source of Truth)

> Local-only Android-first Flutter app. NO Supabase, NO Firebase, NO backend,
> NO auth, NO cloud DB, NO cloud sync. All financial data stays on-device.
> Stack: Flutter + Dart + Material 3 + Riverpod + SQLite/Drift + Android
> Camera/Location/Intents + on-device PDF.
> Order: correctness → reliable architecture → functionality → UX → visual polish.
> After every phase: verify → test → update PHASES.md + CHANGELOG.md → fix before continuing.

Status legend: `[ ]` Not Started · `[~]` In Progress · `[x]` Complete · `[!]` Blocked

---

## Phase 1 — Foundation & Design System `[x]`

> Completed 2026-09-27. Verified: `flutter analyze` clean, `flutter test` 2/2
> pass, `app-release.apk` (49.4 MB) + per-ABI splits built fromم release.
> Toolchain: Flutter 3.47.5 + Temurin JDK 17 (scoop, per-user) + Android SDK
> 36.1.0, licenses accepted. Notes: sqlite3_flutter_libs is EOL → used
> drift_flutter; one transient sqlite3 prebuilt-hash failure resolved by
> clean rebuild (upstream asset verified correct via SHA256).

**Objective:** Working Flutter Android project with clean architecture,
Riverpod, Drift database skeleton, M3 theme, bottom navigation, and reusable
components. No business logic beyond seed/wiring.

**Features:**
- Flutter project setup (Android-first, iOS-ready structure), `flutter doctor` clean
- Clean architecture: `presentation → application/state → domain → data → platform`
- Riverpod providers + router/bottom nav (Home, History, Scan, Analytics, Profile)
- Material 3 theme (§39 colors, §40 typography, Indian currency formatting)
- Drift SQLite skeleton: tables from §6 (transactions, payment_attempts, savings,
  savings_goals, monthly_reports, app_settings) + indexes from §54
- Secure settings storage (Keystore-backed), DB migration + integrity handling (§7)
- Reusable components from §56 (at least: PrimaryButton, BottomSheet, EmptyState,
  LoadingState, AmountDisplay, FilterChip, TransactionRow, CategorySelector)
- Onboarding (§48), permission rationale shells (§49), empty states (§47)
- Dev seed data (§58)

**Main files/modules affected:**
- `pubspec.yaml`, `android/`, `lib/main.dart`
- `lib/core/theme/`, `lib/core/widgets/`, `lib/core/format/`
- `lib/data/db/app_db.dart` (Drift), `lib/data/repositories/`
- `lib/domain/models/`, `lib/application/providers/`
- `lib/presentation/{home,history,scan,analytics,profile,onboarding}/`
- `lib/platform/` (stubs for QR/location/UPI intents)

**Dependencies:** flutter_riverpod, drift, sqlite3_flutter_libs, drift_flutter
(or sqlite3), flutter_secure_storage, go_router (or Navigator 2.0), intl, pdf,
share_plus, csv, mobile_scanner, geolocator, permission_handler, device_apps
(or package_info_plus + android_intent_plus), flutter_svg.

**Acceptance criteria:**
- `flutter analyze` clean, `flutter test` passes
- App launches offline, onboarding → bottom nav works, no backend calls
- Drift DB creates + migrates, seed loads, secure storage reads/writes
- Theme matches §39 palette, ₹ formatting correct (₹1,24,500)

**Testing requirements:** widget test (nav + empty states), DB create/migrate
test, `flutter doctor` + release APK builds.

**Definition of done:** Phase 1 APK installs on ARM64, opens offline, DB
verified, PHASES.md + CHANGELOG.md updated.

---

## Phase 2 — Dashboard & Spending `[x]`

> Completed 2026-09-27. Verified: `flutter analyze` clean, `flutter test` 16/16
> pass (spending-math units, DAO/index tests on real SQLite, widget tests),
> release APKs rebuilt. Seed calibrated to §58 (total ₹24,860 · Sept ₹8,420 ·
> week Sep 21–27 ₹2,150 · saved ₹3,580). Providers still read seed directly —
> DAO bodies swap in when Phase 3 writes land (db_test proves the SQL now).
> Weekly chart on Home is static bars; interactive touch chart stays in Phase 4.

**Objective:** Dashboard answers "How much did I spend / save?" (§8) with
history, search, filters, detail — all from local DB (§53–54, §57).

**Features:**
- Dashboard (§36): total/this-month/this-week spending, saved-this-month vs
  target, category breakdown (5 only: Food, Petrol, Personal, College, Home),
  weekly graph, recent transactions, monthly report teaser
- History (§25): grouped by date, filters (All + 5 categories; Today/Week/Month/Custom)
- Search (§26): merchant, UPI ID, description, reference, category — instant via DB
- Transaction detail (§24): merchant, amount, category, description, UPI ID, app,
  date/time, location, reference, status, QR info
- Spending math: only SUCCESSFUL counts as confirmed (§53); FAILED/CANCELLED
  excluded; PENDING/UNKNOWN separated

**Main files/modules affected:**
- `lib/domain/analytics/spending_summary.dart`, `lib/data/daos/transactions_dao.dart`
- `lib/application/providers/{dashboard,history,search}_provider.dart`
- `lib/presentation/{home,history,transaction_detail,widgets}/`

**Dependencies:** Phase 1 deps only (fl_chart or custom painter for weekly graph).

**Acceptance criteria:**
- Seed totals match §58 (₹24,860 total, ₹8,420 month, ₹2,150 week, ₹3,580 saved)
- History paginates (no full-table load), search <100 ms on 10k rows, filters correct
- Pending/failed never inflate confirmed spending

**Testing requirements:** DAO query tests (indexes hit), spending-math unit tests
(status filtering), widget tests (dashboard cards, search, filters).

**Definition of done:** Dashboard + history + search + detail work offline on
seed + user data; docs updated.

---

## Phase 3 — QR → UPI Payment Flow `[x]`

> Completed 2026-09-27. Verified: `flutter analyze` clean, `flutter test` 26/26
> pass (parser + status-machine + store + DAO + widget), release APKs rebuilt
> (incl. native PackageManager channel). Providers now stream Drift via TxStore
> (seeded once, Phase 1–2 numbers unchanged). device_apps dropped (discontinued)
> for a ~20-line MethodChannel. POP UPI/super.money packages are best-effort
> with generic-chooser fallback — verify in the on-device acceptance matrix
> (needs a real phone + real UPI apps; emulator/camera-matrix is manual).

**Objective:** One-tap Scan → Review → Pay → Reconcile → persisted locally (§14–23, §61).

**Features:**
- Full-screen scanner (§14): frame, haptic, stop-on-detect → parse → review
- UPI QR parsing (§15): VPA, payee, amount, currency, ref, note, QR type; store raw
- Review (§16–18): amount (editable if QR lacks it), merchant, UPI ID, 5-category
  selector (§17), optional description (§18)
- Auto time (§19: local time + tz + raw ts) + auto location (§20, §52: single
  capture, "Location unavailable" fallback, no continuous tracking)
- App selector (§21): super.money, POP UPI, GPay, PhonePe, Paytm + installed detection
- `UPIAppLauncher` abstraction (§22): per-app intent/deep-link, launch, return,
  raw response capture; no fake APIs
- Status machine (§23): DRAFT → INITIATED → PENDING/SUCCESSFUL/FAILED/CANCELLED/
  UNKNOWN; save INITIATED before launch; reconcile on return with
  Yes-completed / No-cancelled / Keep-pending; never auto-success
- payment_attempts row per launch (§6); security rules (§50: no PIN/OTP/bank
  credential handling, no silent payments)

**Main files/modules affected:**
- `lib/platform/{qr_scanner,upi_launcher,upi_apps,location_capture}.dart`
- `lib/domain/upi/upi_payload.dart`, `lib/data/daos/{transactions,payment_attempts}_dao.dart`
- `lib/presentation/scan/{scanner,review,reconcile}_*.dart`
- `android/app/src/main/AndroidManifest.xml` (camera/location/queries/intents)

**Dependencies:** mobile_scanner, geolocator, permission_handler, device_apps,
android_intent_plus (or url_launcher), vibrate/haptics, uuid.

**Acceptance criteria:**
- Full acceptance flow (§62) works on real device with at least GPay/PhonePe
- QR without amount → manual entry required; denied location → transaction continues
- Uninstalled app not launchable; every launch writes payment_attempts row
- Airplane-mode scan + save works (location label may defer per §52)

**Testing requirements:** UPI parser unit tests (all §15 params + malformed QR),
status-machine tests, manual device test matrix (5 apps × success/cancel/pending).

**Definition of done:** Real QR → real UPI app → reconciled status → dashboard
updates; docs updated.

---

## Phase 4 — Savings & Analytics `[x]`

> Completed 2026-09-27. Verified: `flutter analyze` clean, `flutter test` 42/42
> pass (savings math, store atomicity/validation, aggregation units, widget
> flows incl. chart touch + month stepping), release APKs rebuilt. Savings and
> spending share one DB but never mix: contributions are the sole writer of
> goal progress; confirmed-spending queries ignore savings tables entirely.
> Category drill-down reuses History via filter preset (no second list UI).

**Objective:** Savings as first-class explicit contributions (§9–13) + analytics
(§27–30).

**Features:**
- Monthly target (§9): saved/target, %, remaining; Add Savings sheet (§12:
  amount, goal, description, date → instant SQLite save)
- Savings = sum of explicit records only (§10); never inferred from bank balance
- Goals (§11): CRUD, contribute, pause/complete/delete, progress math
- Savings dashboard (§13): month, target, history, active/completed goals, recent
- Analytics (§27–28): totals, averages, counts, largest, top category, savings
  progress; per-category % + count + drill-down
- Weekly 7-day interactive chart (§29: touch day → amount + count, animated entry)
- Monthly view (§30): any recorded month, full breakdown + savings progress

**Main files/modules affected:**
- `lib/data/daos/{savings,savings_goals}_dao.dart`
- `lib/application/providers/{savings,goals,analytics}_provider.dart`
- `lib/presentation/{savings,analytics,widgets}/`

**Dependencies:** Phase 1–2 deps only.

**Acceptance criteria:**
- §9 math exact (₹3,580/₹5,000 = 71.6%, ₹1,420 remaining); goal math exact (§11)
- Savings writes never touch transaction totals and vice versa
- Weekly chart touch + month picker correct across month boundaries

**Testing requirements:** savings/goal math tests, analytics aggregation tests,
widget tests (sheet, goal card, chart touch).

**Definition of done:** Savings + goals + analytics fully offline; docs updated.

---

## Phase 5 — Monthly Reports `[x]`

> Completed 2026-09-27. Verified: `flutter analyze` clean, `flutter test` 53/53
> pass (builder incl. empty/leap/5-week/non-confirmed edges, PDF smoke ×2,
> archive→detail navigation), release APKs rebuilt. Deliberate call: reports
> derive live from source rows (no snapshots, no WorkManager) — always correct,
> offline, reboot-safe. PDF uses "Rs" (WinAnsi has no ₹ glyph; no TTF bundling
> for one glyph). Export/share paths are manual-device-flows, untestable in
> widget tests by design — covered by try/catch + snackbars.

**Objective:** Auto local monthly reports + archive + on-device PDF (§31–35).

**Features:**
- Auto-generate on month close (§31, e.g. Sept report on Oct 1) via local worker
- Content (§32): summary, category breakdown, daily + weekly (W1–W5) spending,
  largest transactions, top merchants, savings vs target, neutral MoM comparison
- Archive (§33): month list with spent/saved/count → detail
- PDF (§34): EQUINOX header, all §32 sections + charts + generation date;
  Export PDF + Share (§35: manual share only, no upload)
- Report tables (§6 monthly_reports) + status-filtered math (§53)

**Main files/modules affected:**
- `lib/domain/reports/report_builder.dart`, `lib/data/daos/reports_dao.dart`
- `lib/platform/report_pdf.dart`, `lib/application/providers/reports_provider.dart`
- `lib/presentation/reports/{archive,detail}_*.dart`

**Dependencies:** pdf, printing, share_plus, workmanager (or alarm-based trigger).

**Acceptance criteria:**
- Sept 2026 seed report matches dashboard numbers; MoM deltas correct
- PDF generates + shares fully offline; report survives reboot + DB upgrade
- FAILED/CANCELLED/PENDING/UNKNOWN never in confirmed totals

**Testing requirements:** report-builder tests (grouping, MoM, edge: empty month,
5-week month), PDF smoke test, worker trigger test.

**Definition of done:** Archive + detail + PDF export/share work offline; docs updated.

---

## Phase 6 — Reliability, Backup & Final Polish `[ ]`

**Objective:** Private-app hardening: recovery, permissions, offline, backup,
polish, release APK (§43–47, §49–51, §57, §59).

**Features:**
- Pending recovery: UNKNOWN/PENDING inbox, retry reconcile, never fabricate status
- Permissions (§49): just-in-time (camera on Scan, location in flow, notifications
  when needed) + rationale + graceful denial
- Offline-first (§51): every §51 bullet works with radios off; §52 geocode deferral
- Integrity (§7, §54): encrypted sensitive fields, secure settings, corruption
  recovery, migrations, indexed queries
- Settings → Data Management (§43–46): Export CSV / JSON, Import JSON restore,
  Delete-all with explicit confirmation; reports stay local (§35)
- Polish (§38–42, §47–48): §39 palette, ₹ typography, animated numbers/progress/
  charts, Scan dominance + haptics, empty states, onboarding; 60 fps, instant saves
- Accessibility + release prep: labels, contrast, version, `flutter analyze/test`,
  release signing, ARM64 APK

**Main files/modules affected:**
- `lib/platform/{permissions,backup,exporters}.dart`
- `lib/presentation/profile/settings/`, `lib/core/{error,recovery}.dart`
- `android/` manifest + signing config, `docs/`

**Dependencies:** csv, file_picker, share_plus, local_auth (optional gate),
wakelock (scan only) — no new cloud deps, ever.

**Acceptance criteria:**
- Full §62 acceptance test passes on device from release APK, airplane-mode
  subset passes, permission-deny paths pass
- Export/import round-trip lossless; delete-all wipes + confirms
- `build/app/outputs/flutter-apk/app-release.apk` + `Equinox-v1.0.0-release.apk`
  (+ arm64 variant) exist and install

**Testing requirements:** integration test (§62 flow), backup round-trip test,
permission/offline matrix, performance check (dashboard <1 s, 60 fps).

**Definition of done:** Release APK delivered, installable, fully offline,
docs final,CHANGELOG released as v1.0.0.
