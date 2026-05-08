# Isango App

Isango is a Flutter application for campus event discovery and submission in the UR community. The current codebase establishes the first product shell: shared visual language, route wiring, bottom navigation, and placeholder screens for the initial feature areas.

## Current Scope

- Material 3 app shell with Isango branding
- Shared theme tokens for color, spacing, radii, and typography
- Named routes for the full navigation flow including auth
- Login screen with email/password validation and password visibility toggle
- Sign-up screen with full name, email, phone, and confirmed password fields
- Bottom navigation for `Home`, `Saved`, `Submit`, and `Settings`
- Placeholder screens that keep feature delivery moving while the real UI is implemented incrementally

## Project Structure

```text
lib/
  app.dart
  core/
    constants/
    theme/
  screens/
    auth/
    home/
    saved/
    settings/
    shared/
    submit/
  widgets/
```

## Getting Started

1. Install Flutter and verify it with `flutter doctor`.
2. Fetch packages with `flutter pub get`.
3. Run the app with `flutter run`.

## Next Steps

- Replace placeholder screens with production event discovery flows
- Connect authentication to a real backend (API + token storage)
- Add role-aware navigation (student vs. organiser views)
- Introduce real event data, persistence, and submission validation
