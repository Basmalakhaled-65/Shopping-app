# Shopping App – Clean Architecture update

This bundle contains the updated `lib/` source tree and the supplied `pubspec.yaml`.

## Layer layout

- `lib/domain/entities/`: business entities, independent of API JSON.
- `lib/domain/repositories/`: repository contracts.
- `lib/domain/usecases/`: focused application actions.
- `lib/data/datasources/remote/`: API access/data parsing.
- `lib/data/repositories/`: repository implementations and model/entity mapping.
- `lib/core/`: network client, constants, token storage, and dependency composition.
- `lib/services/`: compatibility facades used by the existing screens so the UI remains stable.
- `lib/screens/`, `lib/widgets/`: existing presentation and UI components.

## Run locally

1. Extract this bundle into your Flutter project root, replacing the project's `lib` folder. Keep a backup of the original first.
2. Make sure the root `pubspec.yaml` matches the included file (or preserve any extra dependencies your project has).
3. In VS Code terminal at the project root run:

```bash
flutter pub get
flutter analyze
flutter run
```

## Important

This source bundle does not include the Android/iOS platform folders because only `lib.zip` and the pasted `pubspec.yaml` were supplied. Existing UI imports are preserved through service facades. The backend `addCart` and `addFavorite` endpoints previously returned HTTP 500 `Invalid URL`; this is a backend-side response and is not fixed by reorganizing Flutter code.
