# Contributing to Petty

Thank you for helping improve Petty. Keep contributions focused, reviewable,
and consistent with the app's native macOS and 2D character direction.

## Before You Start

- Search existing issues before opening a new one.
- Use an issue for behavior changes that need product discussion.
- Do not include secrets, private data, generated build products, or copied
  commercial character assets.
- New bundled art must have a clear redistribution license and complete
  attribution.

## Development Setup

Requirements:

- macOS 14 or newer
- Xcode with a compatible macOS SDK
- Git

Clone and run:

```sh
git clone https://github.com/Saba-Burduli/Petty.git
cd Petty
./script/build_and_run.sh --verify
```

The Xcode project is `Petty/Petty.xcodeproj`, and the runnable scheme is
`Petty`.

## Branch and Pull Request Workflow

1. Branch from `dev`.
2. Use a short branch name that describes the change.
3. Keep commits small and use Conventional Commit messages when practical.
4. Run the relevant build or verification command.
5. Open a pull request targeting `dev`.

The `master` branch is reserved for reviewed, release-ready changes. Routine
contributions should not target it directly.

## Validation

For app changes, run:

```sh
xcodebuild \
  -project Petty/Petty.xcodeproj \
  -scheme Petty \
  -configuration Debug \
  -destination 'platform=macOS' \
  CODE_SIGNING_ALLOWED=NO \
  build
```

For character packs, also confirm that:

- `manifest.json` is valid JSON and uses a unique, stable ID.
- Every referenced frame folder and frame count is correct.
- `ATTRIBUTION.md` identifies the creator, source URL, and license.
- The license explicitly allows redistribution in this repository.

## Pull Request Expectations

- Explain the behavior and why the change is needed.
- List the validation you ran.
- Include screenshots for user-interface changes.
- Call out new dependencies, permissions, asset licenses, and known limits.
- Avoid unrelated formatting or refactoring.
